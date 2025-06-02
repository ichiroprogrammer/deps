#!/bin/bash -e

readonly BASE_DIR=$(cd $(dirname $0); pwd)
readonly BASENAME="$(basename $0)"

cd $BASE_DIR


./deps.sh -x -p p.txt -o out ../example/deps

diff -r exp out
\rm -rf out

./deps.sh -o out ../example/deps

diff -r exp2 out
\rm -rf out
