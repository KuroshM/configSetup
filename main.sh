#! /bin/bash


# If user is a sudoer, install apps
if groups | grep "\<sudo\>" -q
then
  ./apps/install.sh
fi