usage() {
    echo "Usage: $0 Xcelerium/"
    exit 1
}

if [ "$#" -ne 1 ];  then
    usage
fi

directory=$1

if [ ! -d "$directory" ]; then
   echo "Directory does not exist."
   exit 1
fi

current_date=$(date +"%Y-%m-%d")

backup_file="backup_${current_date}.tar.gz"

tar -czf "$backup_file"  "$directory"
if [  $? -eq 0 ]; then
   echo "Backup of the directory was successful."
else 
   echo "Error in backup."
   exit 1
fi