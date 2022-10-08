@ECHO OFF

CALL git-sub-clone

git submodule update --progress --init --recursive --force
rem git submodule foreach --recursive git checkout master
rem git submodule foreach --recursive git pull