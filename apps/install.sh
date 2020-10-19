# updating catalogue
echo Updating app catalogue ...
sudo apt -qq update &>/dev/null

dir=$(dirname "$0")
# install the app(s) if not already installed
if [ "$#" -eq 0 ]
then
  appList=$(cat "$dir"/list.txt)
else
  appList="$@"
fi

for f in $appList 
do
  if dpkg -s $f &>/dev/null
  then
    echo $f is already installed.
  else
    echo installing $f ...
    if sudo apt install -qqy $f &>/dev/null
    then
      echo $f installed.
      echo $f>>"$dir"/log.log 
    else
      echo $f could not be installed.
    fi
  fi
done
