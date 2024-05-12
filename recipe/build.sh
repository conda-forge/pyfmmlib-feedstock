#! /bin/bash
export LDFLAGS="$LDFLAGS -fopenmp"

${ PYTHON } -m pip install . -vv

echo "======================================================" >> README.rst
echo "fmmlib3d is licensed as follows" >> README.rst
cat fmmlib3d/COPYING >> README.rst

echo "======================================================" >> README.rst
echo "fmmlib2d is licensed as follows" >> README.rst
cat fmmlib2d/COPYING >> README.rst
