#!/bin/bash
set -ex
DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd ${DIR}/../python/legion_linux

# Build and install python package
python3 -m pip install --upgrade build installer
python3 -m build

if [ "$EUID" -ne 0 ]
  then echo "Please run as root to install"
  exit
else
    python3 -m installer --destdir="/" dist/*.whl
    #Create config folder
    #cp -r /usr/share/legion_linux /etc/legion_linux
    cp -r /usr/local/share/legion_linux /etc/legion_linux
fi

echo "Done"
