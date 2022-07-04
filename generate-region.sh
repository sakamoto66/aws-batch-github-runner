#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
terraform=${DIR}/terraform

region=$1
if [ -n "$region" ]; then
  if [ -e "${terraform}/${region}" ]; then
    echo "already exists directory of region \"${region}\"."
    exit 1
  fi
else
  PS3="select region: "
  select region in us-east-1 us-east-2 us-west-1 us-west-2 af-south-1 ap-east-1 ap-south-1 ap-northeast-1 ap-northeast-2 ap-northeast-3 ap-southeast-1 ap-southeast-2 ca-central-1 cn-north-1 cn-northwest-1 eu-central-1 eu-west-1 eu-west-2 eu-west-3 eu-south-1 eu-north-1 me-south-1 sa-east-1
  do
    if [ -n "$region" ]; then
      if [ -e "${terraform}/${region}" ]; then
        echo "already exists directory of region \"${region}\"."
      else
        break
      fi
    fi
  done
fi

mkdir -p "${DIR}/tmp"
rm -rf "${DIR}/tmp/"*
cp -r "${DIR}/template/"* "${DIR}/tmp"

while IFS= read -r -d '' tgt
do
  sed -i -e "s/<region>/${region}/" "${tgt}"
done < <(find "${DIR}/tmp/"* -type f -print0)

rename "s/\[\[region\]\]/${region}/" "${DIR}/tmp/"*
mv "${DIR}/tmp/"* "${terraform}/"
rmdir "${DIR}/tmp/"