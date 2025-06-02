#!/bin/bash -e

readonly BASE_DIR=$(cd $(dirname $0); pwd)
readonly BASENAME="$(basename $0)"
readonly DEPS="$BASE_DIR/../example/deps/g++/deps"
readonly PU=$BASE_DIR/../md_gen/export/sh/pu2png.sh

function help(){
    local -r exit_code=$1
    set +x

    echo "$BASENAME  [option] : "
    echo "    -o <DIR>        : generate <DIR>"
    echo "    -p <PKG>        : use <PKG> as package file"
    echo "    -x              : set -x."
    echo "    -h              : show this message"


    exit $exit_code
}

OUT_DIR=arch
IN_PKG=
readonly TARGET_NAME="arch"

while getopts "o:p:xh" flag; do
    case $flag in 
    o) OUT_DIR="$OPTARG" ;; 
    p) IN_PKG="$OPTARG" ;; 
    x)  set -x ;; 
    h)  help 0 ;; 
    \?) help 1 ;; 
    esac
done
shift $(expr ${OPTIND} - 1)

readonly TARGET_DIR=$1

if [ ! -d $OUT_DIR ]; then
    mkdir $OUT_DIR
fi

if [[ ! -n "$IN_PKG"  ]]; then
    IN_PKG=$OUT_DIR/p.txt
    $DEPS p -o $IN_PKG -R $TARGET_DIR 
fi

$DEPS p2p -i $IN_PKG -o $OUT_DIR/p2p.txt $TARGET_DIR
$DEPS a2pu  -i $OUT_DIR/p2p.txt -o $OUT_DIR/arch.pu

$PU $OUT_DIR/arch.pu

