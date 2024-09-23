#! /bin/bash

set -ex

export LDFLAGS="$LDFLAGS -fopenmp"

# Taken from scipy-feedstock
# HACK: extend $CONDA_PREFIX/meson_cross_file that's created in
# https://github.com/conda-forge/ctng-compiler-activation-feedstock/blob/main/recipe/activate-gcc.sh
# https://github.com/conda-forge/clang-compiler-activation-feedstock/blob/main/recipe/activate-clang.sh
# to use host python; requires that [binaries] section is last in meson_cross_file
echo "python = '${PREFIX}/bin/python'" >> ${CONDA_PREFIX}/meson_cross_file.txt

if [[ $CONDA_BUILD_CROSS_COMPILATION -eq 1 ]]; then
    # Needed?:
    # MESON_ARGS="--cross-file ${CONDA_PREFIX}/meson_cross_file.txt"
    echo "skip_sanity_check = true" >> ${CONDA_PREFIX}/meson_cross_file.txt
fi

# need to run meson first for cross-compilation case
${PYTHON} $(which meson) setup ${MESON_ARGS} \
    builddir || (cat builddir/meson-logs/meson-log.txt && exit 1)

pip install . -vv

echo "======================================================" >> README.rst
echo "fmmlib3d is licensed as follows" >> README.rst
cat fmmlib3d/COPYING >> README.rst

echo "======================================================" >> README.rst
echo "fmmlib2d is licensed as follows" >> README.rst
cat fmmlib2d/COPYING >> README.rst
