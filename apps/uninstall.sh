# uninstall all apps installed by myConfig and listed in log.log
dir=$(dirname "$0")
if ls "$dir"/log.log &>/dev/null
then
  apps=$(cat "$dir"/log.log)
  rm "$dir"/log.log
  
  for f in $apps 
  do
    echo uninstalling $f ...
    if sudo apt autoremove -y $f &>/dev/null
    then
      echo $f uninstalled.
    else
      echo $f could not be uninstalled.
      echo $f>>"$dir"/log.log -gc
    fi
  done
else
  echo Nothing to uninstall.
fi
