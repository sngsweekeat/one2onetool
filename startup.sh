#!/bin/bash

set -x

# exec container command
echo $ENVTYPE
exec npm run $ENVTYPE
