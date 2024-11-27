import os

def mkdir_and_chown(path):
    os.system("sudo mkdir -p " + path)
    os.system("sudo chown aiscuser:aiscuser " + path)

os.system("whoami")
os.system("ls -l /mnt")

# Mount blob1
# Do not use "/mnt/output" as mount point
mkdir_and_chown("/mnt/haoling")

mkdir_and_chown("/mnt/azcache/haoling")

os.system("blobfuse2 mount /mnt/haoling --config-file=haoling_config.yaml")


# If needed mount blob2
# ......

os.system("ls -l /mnt/haoling")
