#! /bin/bash

set -ex

mkdir builddir

export LDFLAGS="$LDFLAGS -fopenmp"

# Taken from scipy-feedstock
# HACK: extend $CONDA_PREFIX/meson_cross_file that's created in
# https://github.com/conda-forge/ctng-compiler-activation-feedstock/blob/main/recipe/activate-gcc.sh
# https://github.com/conda-forge/clang-compiler-activation-feedstock/blob/main/recipe/activate-clang.sh
# to use host python; requires that [binaries] section is last in meson_cross_file
echo "python = '${PREFIX}/bin/python'" >> ${CONDA_PREFIX}/meson_cross_file.txt

# if [[ $CONDA_BUILD_CROSS_COMPILATION -eq 1 ]]; then
#     # Needed?:
#     # MESON_ARGS="--cross-file ${CONDA_PREFIX}/meson_cross_file.txt"
#     echo "[properties]" >> ${CONDA_PREFIX}/meson_cross_file.txt
#     echo "skip_sanity_check = true" >> ${CONDA_PREFIX}/meson_cross_file.txt
# fi

cat ${CONDA_PREFIX}/meson_cross_file.txt

# meson-python already sets up a -Dbuildtype=release argument to meson, so
# we need to strip --buildtype out of MESON_ARGS or fail due to redundancy
MESON_ARGS_REDUCED="$(echo $MESON_ARGS | sed 's/--buildtype release //g')"

# -wnx flags mean: --wheel --no-isolation --skip-dependency-check
$PYTHON -m build -w -n -x \
    -Cbuilddir=builddir \
    -Csetup-args=${MESON_ARGS_REDUCED// / -Csetup-args=} \
    || (cat builddir/meson-logs/meson-log.txt && exit 1)


$PYTHON -m pip install dist/pyfmmlib*.whl

echo "======================================================" >> README.rst
echo "fmmlib3d is licensed as follows" >> README.rst
cat fmmlib3d/COPYING >> README.rst

echo "======================================================" >> README.rst
echo "fmmlib2d is licensed as follows" >> README.rst
cat fmmlib2d/COPYING >> README.rst
