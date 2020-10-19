#! /bin/bash

dir=$(dirname "$0")

# If user is a sudoer, install apps
if groups | grep "\<sudo\>" -q
then
#  "$dir"/apps/install.sh
echo skipping
fi

for f in bash $(cat "$dir"/apps/list.txt)
do
  # if app is installed
  if dpkg -s $f &>/dev/null
  then
    # if app already has an old configuaration, do not configure
    if ls "$dir"/old/"$f"rc.old* &>/dev/null
    then
      echo "$f" already configured.
    else
    # if not previously configured
      echo Configuring "$f" ...
      # if it already has a configuration file, back it up
      if ls ~/."$f"rc &>/dev/null
      then
	echo Storing old configuration for "$f".
        mv ~/."$f"rc "$dir"/old/"$f"rc.old
      else
        # otherwise, create a dummy old file to signal that app is already configured
	touch "$dir"/old/"$f"rc.old.empty
      fi
      # create the configuration file as to source the relevant files
      echo $f>>"$dir"/logs/config.log
    fi
  fi
done
