#! /bin/bash
if [[ $(uname) == 'Darwin' ]]; then
    export LDFLAGS="$LDFLAGS -undefined dynamic_lookup -bundle -fopenmp"
else
    export LDFLAGS="$LDFLAGS -shared -fopenmp"
fi

python setup.py install --single-version-externally-managed --record record.txt

echo "======================================================" >> README.rst
echo "fmmlib3d is licensed as follows" >> README.rst
cat fmmlib3d/COPYING >> README.rst

echo "======================================================" >> README.rst
echo "fmmlib2d is licensed as follows" >> README.rst
cat fmmlib2d/COPYING >> README.rst
