#!/bin/bash
sed -e ':a' -e 'N' -e '$!ba' -e 's/%/%%/g' -e 's/\n/%1$c/g' -e 's/""/%2$c%3$s%2$c/g' -e 's/"/%2$c/g' -e 's/$/%1$c/' -e 's/5/%4$d/g' $1
