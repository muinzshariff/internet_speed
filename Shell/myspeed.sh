#!/bin/bash

if [ $# -lt 2 ]; then
    echo "usage --> `basename ${0}` InputFilePath Outputfilename" 
    exit 1
fi

#Moving the headers to staging file
awk 'NR==1 {print $0}' ${1} > mdb.bcp

#Selecting rows with Download string from 3rd column
awk -F, '$3=="Download"' ${1} >> mdb.bcp

#Renaming the column from Test_type to Test type
sed -i '1s/Test_type/Test type/' mdb.bcp

#Selecting the columns needed for the output file
cut -d, -f 1-4 mdb.bcp --output-delimiter='|'> ${2}
