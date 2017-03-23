#!/bin/bash
FILENAME=`date +'%Y%m%d-%H%M-%S'`;
RUN=`date`
gulp seleniumOutput > "./reports/$FILENAME.md"
echo " * [Tests run $RUN]($FILENAME.md)" >> reports/README.md
