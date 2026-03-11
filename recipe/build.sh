#! /bin/bash

set -ex

mkdir builddir

export LDFLAGS="$LDFLAGS -fopenmp"

# {{{ Taken from https://github.com/conda-forge/numpy-feedstock/blob/main/recipe/build.sh

# -wnx flags mean: --wheel --no-isolation --skip-dependency-check
$PYTHON -m build -w -n -x \
    -Cbuilddir=builddir \
    -Csetup-args=${MESON_ARGS// / -Csetup-args=} \
    || (cat builddir/meson-logs/meson-log.txt && exit 1)


$PYTHON -m pip install dist/pyfmmlib*.whl

# }}}

echo "======================================================" >> README.rst
echo "fmmlib3d is licensed as follows" >> README.rst
cat fmmlib3d/COPYING >> README.rst

echo "======================================================" >> README.rst
echo "fmmlib2d is licensed as follows" >> README.rst
cat fmmlib2d/COPYING >> README.rst
