import os, fnmatch
import shutil

REPLACE_CONSTANT="MONGODB_KAFKA_CONNECTOR_VERSION"
SRC_DIR = "source"
REPLACE_MAP = {
    "v1.6": "1.6.1",
    "v1.5": "1.5.1",
    "v1.4": "1.4.0",
    "v1.3": "1.3.0",
}

#https://stackoverflow.com/questions/4205854/python-way-to-recursively-find-and-replace-string-in-text-files
def findReplace(directory, find, replace, filePattern):
    for path, dirs, files in os.walk(os.path.abspath(directory)):
        for filename in fnmatch.filter(files, filePattern):
            filepath = os.path.join(path, filename)
            with open(filepath) as f:
                s = f.read()
            s = s.replace(find, replace)
            with open(filepath, "w") as f:
                f.write(s)

def copyThenReplace(src, dst, replace):
    destination = shutil.copytree(src, dst) 
    findReplace(dst, REPLACE_CONSTANT, replace, "Dockerfile*")

for k,v in REPLACE_MAP.items():
    abs_src = os.path.abspath(SRC_DIR)
    abs_dst = os.path.abspath(k)
    try:
        shutil.rmtree(abs_dst)
    except FileNotFoundError:
        pass
    copyThenReplace(abs_src, abs_dst, v)
