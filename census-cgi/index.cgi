#!/bin/sh
echo Status: 200
echo Content-Type: text/plain
echo
[ "/" = "$PATH_INFO" ] && {
  echo USAGE: "https://$SERVER_NAME/path/to/file.hoon"
  exit 0
}
# this is horribly insecure, but we shouldn't have read access to
# any files we shouldn't be reading anyway
file=../"$PATH_INFO"
cat $file # TODO census
