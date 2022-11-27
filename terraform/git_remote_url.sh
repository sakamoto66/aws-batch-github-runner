#!/usr/bin/env bash

URL=$(git config --get remote.origin.url | rev | cut -c 5- | rev)
echo "{\"url\":\"${URL}\"}"