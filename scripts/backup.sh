#! /bin/bash
# Simple script to backup a list of files

# Enable for debugging
# set -x

echo

if [[ "$#" != 4 ]]
then
    echo "Invalid arguments"
    echo "Usage: backup.sh <List File> <Source Base Dir> <Target Base Dir> <Comment>"
    exit 1
fi

# Store arguments
listFile=$1
srcBaseDir=$2
tgtBaseDir=$3
commentStr=$4

# Create backup dir name "Date - Comment"
dateStr=`date +%F-%a-%H.%M.%S`
tgtBaseDir=$tgtBaseDir/$dateStr" - "$commentStr

echo 'List File:    '$1
echo 'Source Dir:   '$srcBaseDir
echo 'Target Dir:   '$tgtBaseDir
echo

echo "Creating backup directory structure..."
mkdir -p "$tgtBaseDir"
cat "$listFile" | xargs -I {} dirname {} | xargs -I {} mkdir -p "$tgtBaseDir"/{}

echo "Copying CVS metadata..."
cat "$listFile" | xargs -I {} dirname {} | xargs -I {} cp -r "$srcBaseDir"/{}/CVS "$tgtBaseDir"/{}/

echo "Copying files..."
cp "$listFile" "$tgtBaseDir"/"INDEX_$dateStr - $commentStr.txt"
cat "$listFile" | xargs -I {} cp -r "$srcBaseDir"/{} "$tgtBaseDir"/{}

echo "Done."

