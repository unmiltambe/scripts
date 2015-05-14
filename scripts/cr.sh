#! /bin/bash
# Backup source files for code review 

# Enable for debugging
#set -x

if [[ "$#" != 3 ]]
then
    echo "Invalid arguments"
    echo "Usage: cr <Source List> <Source Base Network Share> <Comment>"
    exit 1
fi

echo $2

# Store arguments
listFile=$1
srcBaseNetworkShare=$2
commentStr=$3

branchHead="/cygdrive/d/src/REF_10_0_0_B116_devbch10-2"
formNum=`basename $1`
tgtBaseDir="/cygdrive/d/CR/$formNum"
srcBaseMntUnix="$tgtBaseDir/TmpMount"
srcBaseMntWin=`cygpath -w $srcBaseMntUnix`

echo Form:            $formNum
echo File List:       $listFile
echo Branch Head:     $branchHead
echo Friendly Dir:    $srcBaseNetworkShare
echo Output Dir:      $tgtBaseDir

mkdir -p $tgtBaseDir
cmd.exe /C mklink /D $srcBaseMntWin $srcBaseNetworkShare 
./backup.sh $listFile $branchHead $tgtBaseDir "$formNum - Branch Head - $commentStr"
./backup.sh $listFile $srcBaseMntUnix $tgtBaseDir "$formNum - Before CR - $commentStr"
./backup.sh $listFile $srcBaseMntUnix $tgtBaseDir "$formNum - After CR - $commentStr"
cmd.exe /C rmdir $srcBaseMntWin 

