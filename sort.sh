#!/bin/sh
for i in $(cat $1) ; do echo $i ; done | sort | uniq
