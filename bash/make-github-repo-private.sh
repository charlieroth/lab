#!/bin/sh

ACCESS_TOKEN=$1
REPOSITORY=$2

curl -L \
  -X PATCH \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/charlieroth/$REPOSITORY \
  -d '{"private":true,"visibility":"private"}'
