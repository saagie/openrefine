#!/bin/bash
sed -i 's:SAAGIE_BASE_PATH:'"$SAAGIE_BASE_PATH"':g' /etc/nginx/sites-enabled/openrefine.conf
nginx
/app/refine -m 2048m -i 0.0.0.0 -d /data
