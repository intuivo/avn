#!/bin/bash

typeset __abspath=$(cd ${0%/*} && echo $PWD/${0##*/})
typeset __shelldir=`dirname "${__abspath}"`
typeset __testdir=`dirname "${__shelldir}"`
typeset __tmp=`mktemp /tmp/avn-test.XXXXXX`
typeset __written=""

# start in a known location
cd "${__testdir}/examples/home"

function _avn() {
  echo avn called >> ${__tmp}
}

source "${__shelldir}/helpers.sh"
source "${__testdir}/../bin/avn.sh"

# test that _avn isn't invoked when .node-version file isn't there
cd "${__testdir}/examples/none"
__written=`echo $(cat ${__tmp})`

assertEqual `pwd` "${__testdir}/examples/none" || exit 1
assertEqual "" "${__written}" || exit 1

rm ${__tmp}
