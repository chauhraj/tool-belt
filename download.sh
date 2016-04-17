#!/bin/bash 
source $HOME/.kaggle/.kagglerc

function extract () {
   local extn=$1
   local fName=$2
   case $extn in
	 gz)
		echo "Gunzipping $fName"
		gunzip $fName
		;;
	zip)
		echo "Unzipping $fName"
		unzip $fName -d ${KAGGLE_COMPETITION}/data
		;;
   esac
}

KAGGLE_COMPETITION=$1
if [[ -z "$KAGGLE_COMPETITION" ]]; then
   usage 
fi

KAGGLE_DATA_PAGE="${KAGGLE_URL}/${KAGGLE_COMPETITION}/data"
KAGGLE="${KAGGLE_URL}/${KAGGLE_COMPETITION}/download"

if [[ ! -d "${KAGGLE_HOME}/${KAGGLE_COMPETITION}" ]]; then
  mkdir -p $KAGGLE_HOME/$KAGGLE_COMPETITION/data && echo "Successfully created directory $KAGGLE_COMPETITION" 
fi

FILES=$(wget --load-cookies $HOME/.kaggle/cookies.txt -q -O- ${KAGGLE_DATA_PAGE} | grep "/c/${KAGGLE_COMPETITION}/download" | awk '{print substr($2, 2+length("href="))}' | sed 's/"//g')
for f in $FILES; do
 DOWNLOAD_FILE="$(basename $f)"
 FILE_EXTN="${DOWNLOAD_FILE##*.}"
 FILE_URL="$KAGGLE/$(basename $f)"
 FILE_NAME="${KAGGLE_COMPETITION}/data/${DOWNLOAD_FILE}"
 wget -q -x -nd -P $KAGGLE_COMPETITION/data --load-cookies ${HOME}/.kaggle/cookies.txt ${FILE_URL} && echo "Downloaded file $1"
 if [[ -e ${FILE_NAME} ]]; then
    extract $FILE_EXTN $FILE_NAME
    rm -f ${FILE_NAME} && echo "Deleted $FILE_NAME" 
 fi
 shift
done


