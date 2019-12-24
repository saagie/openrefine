#!/bin/bash

# Remove first / if SAAGIE_BASE_PATH starts with one
if [[ $SAAGIE_BASE_PATH == /* ]]; then
    export SAAGIE_BASE_PATH=$(echo $SAAGIE_BASE_PATH | sed '0,/\// s/\///')
fi

sed -i 's:SAAGIE_BASE_PATH:'"$SAAGIE_BASE_PATH"':g' /etc/nginx/conf.d/openrefine.conf
nginx
/app/refine -m 2048m -i 0.0.0.0 -d /data
