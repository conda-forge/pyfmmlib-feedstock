#! /bin/bash
if [[ $(uname) == 'Darwin' ]]; then
    export LDFLAGS="$LDFLAGS -undefined dynamic_lookup -bundle -fopenmp"
else
    export LDFLAGS="$LDFLAGS -shared -fopenmp"
fi

python setup.py install --single-version-externally-managed --record record.txt
