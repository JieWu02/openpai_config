import os

def mkdir_and_chown(path):
    os.system("sudo mkdir -p " + path)
    os.system("sudo chown aiscuser:aiscuser " + path)

os.system("whoami")
os.system("ls -l /mnt")

# Mount blob1
# Do not use "/mnt/output" as mount point
mkdir_and_chown("/mnt/jiewu")

mkdir_and_chown("/mnt/azcache/jiewu")

os.system("blobfuse2 mount /mnt/jiewu --config-file=jiewu_config.yaml")


# If needed mount blob2
# ......

os.system("ls -l /mnt/jiewu")
