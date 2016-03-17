source $HOME/.kaggle/.kagglerc

KAGGLE_COMPETITION=$1
if [[ -z "$KAGGLE_COMPETITION" ]]; then
   usage 
fi
KAGGLE="${KAGGLE_URL}/${KAGGLE_COMPETITION}/download"

if [[ ! -d "${KAGGLE_HOME}/${KAGGLE_COMPETITION}" ]]; then
  mkdir -p $KAGGLE_HOME/$KAGGLE_COMPETITION/data && echo "Successfully created directory $KAGGLE_COMPETITION" 
fi

shift
while (( "$#" )); do
 FILE_URL="$KAGGLE/$1"
 FILE_NAME="${KAGGLE_COMPETITION}/data/$1"
 wget -q -x -nd -P $KAGGLE_COMPETITION/data --load-cookies ${HOME}/.kaggle/cookies.txt ${FILE_URL} && echo "Downloaded file $1"
 if [[ -e ${FILE_NAME} ]]; then
    unzip ${FILE_NAME} -d ${KAGGLE_COMPETITION}/data
    rm -f ${FILE_NAME} && echo "Deleted $FILE_NAME" 
 fi
 shift
done


