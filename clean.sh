#! /bin/bash

dir=$(dirname "$0")

# If user is a sudoer, install apps
if groups | grep "\<sudo\>" -q
then
#  "$dir"/apps/uninstall.sh
echo skipping for now
fi

if ls "$dir"/logs/config.log &>/dev/null
then
  for f in $(cat "$dir"/logs/config.log)
  do
    if ls ~/."$f"rc &>/dev/null
    then
      echo Removing configuration for "$f"
      rm ~/."$f"rc
    fi
    if ls "$dir"/old/"$f"rc.old &>/dev/null
    then
      mv "$dir"/old/"$f"rc.old ~/."$f"rc
      echo Old configuration for "$f" restored.
    fi
  done
  
  rm "$dir"/logs/config.log
  rm "$dir"/old/*.old.empty
else
echo No configuration to restore.
fi
