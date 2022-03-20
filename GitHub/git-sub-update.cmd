@ECHO OFF

CALL git-sub-clone

git submodule foreach --recursive git checkout master
git submodule foreach --recursive git pull