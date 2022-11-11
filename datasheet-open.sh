#!/bin/sh

#set -x
set -e

URL="${1}"

DS_ROOT=$(dirname "${0}")/

function show_datasheet
{
  DS_FILE="${DS_FILE_DIR}"$(echo "${URL}"| sed s@"${URL_PREFIX}"@@)
  DS_FILEPATH="${DS_ROOT}${DS_FILE}"
  if test ! -f "${DS_FILEPATH}"
  then
    echo "File \"${DS_FILEPATH}\" not found"
    echo "URL: \"${URL}\""
    (cd "${DS_ROOT}/${DS_FILE_DIR}"; wget "${URL}")
  fi
  evince ${DS_FILEPATH}
  exit $?
}

URL_PREFIX='^https://www\.ti\.com/lit/ds/symlink/'
if echo "${URL}" | grep -q "${URL_PREFIX}"
then
  DS_FILE_DIR="ti.com/"
  show_datasheet
fi

URL_PREFIX="https://components\.omron\.com/us-en/datasheet_pdf/"
if echo "${URL}" | grep -q "${URL_PREFIX}"
then
  DS_FILE_DIR="omron.com/"
  show_datasheet
fi
