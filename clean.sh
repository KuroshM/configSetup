#! /bin/bash

dir=$(dirname "$0")

# If user is a sudoer, uninstall previously installed apps
if groups | grep "\<sudo\>" -q
then
  "$dir"/apps/uninstall.sh
fi

# if there is a config file ...
if ls "$dir"/logs/config.log &>/dev/null
then
  for f in $(cat "$dir"/logs/config.log)
  do
    # if there is a configuration dotfile for the app, remove it
    if ls ~/."$f"rc &>/dev/null
    then
      echo Removing configuration for "$f"
      rm ~/."$f"rc
    fi
    # if there is an old configuration file, restore it
    if ls "$dir"/old/"$f"rc.old &>/dev/null
    then
      mv "$dir"/old/"$f"rc.old ~/."$f"rc
      echo Old configuration for "$f" restored.
    fi
  done
  
  # remove thr configuration log
  rm "$dir"/logs/config.log
  # remove files related to apps originally without configuration
  rm "$dir"/old/*.old.empty
else
echo No configuration to restore.
fi
