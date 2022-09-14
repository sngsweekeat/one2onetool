#!/bin/bash
#testing
set -x

# exec container command
echo $ENVTYPE
exec npm run $ENVTYPE
