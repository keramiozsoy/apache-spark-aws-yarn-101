#!/bin/sh

mkdir delab
cd delab
python3 -m venv delab-venv
find delab-venv/
ls -ltr delab-venv/bin
source delab-venv/bin/activate
python -m pip install --upgrade pip
pip install jupyterlab
nohup jupyter lab --ip 0.0.0.0 &
