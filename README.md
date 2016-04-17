# Tool Chain

## Following are the goodies that streamlines my day to day job.

### Kaggle download.sh script

> This script creates s folder and downloads the specified files from Kaggle Competition into Kaggle Competition
> folder under data folder.The script gets the list of downloadable files from the data page of the Kaggle 
> Competition.
>
>> For eg: To download the data for Santander Customer Satisfaction, execute
>>
>> download.sh santander-customer-satisfaction test.csv.zip train.csv.zip
>
> It will create a folder santander-customer-satisfaction/data and unzips the downloaded files.
>

#### Following are the pre-requisites

1. Create a .kagglerc file under $HOME/.kaggle folder.
2. Create a "cookies.txt" file which has got cookies information about your Kaggle account.
3. Script uses wget to download the files.
4. The scripts forms the HTTP URL. So for Kaggle Competition name it cannot just be some arbitrary name. It is the string in the URL pertinent to that Kaggle Competion. For eg: for
   the above example, *santander-customer-satisfaction* is a specified name.
