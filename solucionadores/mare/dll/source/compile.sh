#! /bin/sh

LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LIBRARY_PATH
export LIBRARY_PATH

gfortran -shared -O2 -o libprevisao.so -fPIC ROTINAS_MARE_PREVISAO.f90
gfortran -shared -O2 -o libanalise.so -fPIC ROTINAS_MARE_ANALISE.f90
