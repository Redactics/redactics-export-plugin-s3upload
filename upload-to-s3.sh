#!/bin/bash

set -eo pipefail

DATABASE=$1
FILES=$2
S3_BUCKET=$3

usage()
{
  printf 'Usage:\n' "$0"
  printf '\t%s\n' "/bin/upload-to-s3 [database ID] [comma separated file listing] [Amazon S3 bucket URL]"
}

if [ -z $FILES ] || [ -z $DATABASE ] || [ -z $S3_BUCKET ]
then
    usage
    exit 1
fi

IFS=',' read -a files_array <<< "$FILES"
for file in "${files_array[@]}"
do
    printf "Uploading ${file} to ${S3_BUCKET}/${file}\n"
    /bin/agent-filestreamer download-export $DATABASE $file | aws s3 cp - ${S3_BUCKET}/${file}
done