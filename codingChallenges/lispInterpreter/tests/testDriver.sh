#!/usr/bin/bash
outputFile=$1.expected
binaryFile=$2
$binaryFile $1 2> /dev/null | grep "and string representation is" | sed "s/^.*and string representation is//g" > $outputFile
#$binaryFile $1 2> /dev/null > $outputFile
exit 0

