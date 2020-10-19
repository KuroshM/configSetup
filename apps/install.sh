# updating catalogue
echo Updating app catalogue ...
sudo apt -qq update &>/dev/null

dir=$(dirname "$0")
logdir="$dir"/../logs
# install the app(s) if not already installed
if [ "$#" -eq 0 ]
then
  appList=$(cat "$dir"/list.txt "$dir"/../config.txt | sort -u)
else
  appList="$@"
fi

for f in $appList 
do
  if command -v $f &>/dev/null
  then
    echo $f is already installed.
  else
    echo installing $f ...
    if sudo apt install -qqy $f &>/dev/null
    then
      echo $f installed.
      echo $f>>"$logdir"/install.log
    else
      echo $f could not be installed.
    fi
  fi
done
