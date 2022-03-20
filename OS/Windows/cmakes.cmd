@ECHO OFF

SETLOCAL EnableDelayedExpansion

SET SRC=%1

CMAKE -G "Visual Studio 16 2019 Win64" %SRC%