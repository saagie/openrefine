#!/bin/bash

# Remove first / if CONTEXT_PATH starts with one
if [[ $CONTEXT_PATH == /* ]]; then
    export CONTEXT_PATH=$(echo $CONTEXT_PATH | sed '0,/\// s/\///')
fi

# As refine script doesn't handle this refine.context_path parameter (managed by refine server), hack this script so that it can handle this option.
sed -i 's:CLASSPATH="\$REFINE_CLASSES_DIR\${SEP}\$REFINE_LIB_DIR\/\*":add_option "-Drefine.context_path=/'$CONTEXT_PATH'"\nCLASSPATH="\$REFINE_CLASSES_DIR\${SEP}\$REFINE_LIB_DIR\/\*":g' /app/refine


/app/refine -m 2048m -i 0.0.0.0 -d /data 
