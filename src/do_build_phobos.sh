#!/usr/bin/env bash

# set -x

# args:
#    1) directory for build
#    2) os

. src/setup_env.sh "$2"

echo -e "\tbuilding phobos"

cd $1/phobos

$makecmd DMD=../dmd/generated/*/release/$COMPILER_MODEL/dmd MODEL=$OUTPUT_MODEL $EXTRA_ARGS -f $makefile auto-tester-build >> ../phobos-build.log 2>&1
if [ $? -ne 0 ]; then
    echo -e "\tphobos failed to build"
    exit 1
fi

if [ "$2" != "Win_32" -a "$2" != "Win_32_64" ]; then
    $makecmd DMD=../dmd/src/dmd MODEL=$OUTPUT_MODEL $EXTRA_ARGS -f $makefile install >> ../phobos-build.log 2>&1
    if [ $? -ne 0 ]; then
	echo -e "\tfailed to install $repo"
	exit 1
    fi
fi
