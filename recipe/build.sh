#! /bin/bash

set -ex

export LDFLAGS="$LDFLAGS -fopenmp"

mkdir builddir

# Taken from scipy-feedstock
# HACK: extend $CONDA_PREFIX/meson_cross_file that's created in
# https://github.com/conda-forge/ctng-compiler-activation-feedstock/blob/main/recipe/activate-gcc.sh
# https://github.com/conda-forge/clang-compiler-activation-feedstock/blob/main/recipe/activate-clang.sh
# to use host python; requires that [binaries] section is last in meson_cross_file
echo "python = '${PREFIX}/bin/python'" >> ${CONDA_PREFIX}/meson_cross_file.txt
cat ${CONDA_PREFIX}/meson_cross_file.txt


# -wnx flags mean: --wheel --no-isolation --skip-dependency-check
$PYTHON -m build -w -n -x \
    -Cbuilddir=builddir

echo "======================================================" >> README.rst
echo "fmmlib3d is licensed as follows" >> README.rst
cat fmmlib3d/COPYING >> README.rst

echo "======================================================" >> README.rst
echo "fmmlib2d is licensed as follows" >> README.rst
cat fmmlib2d/COPYING >> README.rst
