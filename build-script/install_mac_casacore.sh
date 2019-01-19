#!/bin/bash

GEODATAHOME=/Users/mark/data
echo set data dir: $GEODATAHOME

cd ../..

DIR="build"
if [ -d $DIR ]; then
    echo $DIR Exists!
    rm -rf $DIR
fi
mkdir $DIR && cd $DIR

export CASACOREHOME=`pwd`
echo set casacore home: $CASACOREHOME

# Boost should no longer be necessary
#Fix so that cmake can find the boost-python library file
#ln -s /usr/local/Cellar/boost-python/1.68.0/lib/libboost_python27-mt.dylib \
#      /usr/local/lib/libboost_python-mt.dylib

cmake ../casacore -DCMAKE_INSTALL_PREFIX=$CASACOREHOME \
                  -DUSE_FFTW3=ON \
                  -DUSE_HDF5=ON \
                  -DUSE_THREADS=ON \
                  -DUSE_OPENMP=ON \
                  -DCMAKE_BUILD_TYPE=Release \
                  -DBUILD_TESTING=OFF \
                  -DBoost_NO_BOOST_CMAKE=1 \
                  -DBUILD_PYTHON=OFF \
                  -DDATA_DIR=$GEODATAHOME

make -j 2
make install

ls $CASACOREHOME/lib
ls $CASACOREHOME/include/casacore

#sudo cp -r $CASACOREHOME/lib/* /usr/local/lib/
#sudo cp -r $CASACOREHOME/include/casacore /usr/local/include/
