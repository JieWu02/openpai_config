import requests
import time
import socket
import platform
from threading import Event

class Worker:
    def __init__(self, master_url):
        self.master_url = master_url
        self.worker_id = self.get_worker_id()
        self.stop_event = Event()
        
    def get_worker_id(self):
        """生成唯一worker标识"""
        hostname = socket.gethostname()
        return f"{hostname}-{socket.gethostbyname(hostname)}"

    def send_heartbeat(self):
        """发送心跳信息"""
        try:
            response = requests.post(
                f"{self.master_url}/heartbeat",
                json={
                    "worker_id": self.worker_id,
                    "ip": socket.gethostbyname(socket.gethostname()),
                    "metadata": {
                        "os": platform.system(),
                        "load": self.get_system_load()
                    }
                },
                timeout=5
            )
            return response.ok
        except Exception as e:
            print(f"Heartbeat failed: {str(e)}")
            return False

    def get_system_load(self):
        """获取系统负载（示例）"""
        import psutil  # 需要安装psutil包
        return {
            "cpu_percent": psutil.cpu_percent(),
            "mem_percent": psutil.virtual_memory().percent
        }

    def run(self):
        """启动心跳循环"""
        while not self.stop_event.is_set():
            self.send_heartbeat()
            self.stop_event.wait(30)  # 每30秒发送一次

if __name__ == "__main__":
    # 使用示例：python worker.py http://your.master.ip:5000
    import sys
    if len(sys.argv) < 2:
        print("Usage: python worker.py <master_url>")
        sys.exit(1)
        
    worker = Worker(sys.argv[1])
    try:
        worker.run()
    except KeyboardInterrupt:
        worker.stop_event.set()

