@ECHO OFF

netsh interface show interface

netsh interface set interface "Ethernet" disable
rem timeout /t 3
netsh interface show interface

netsh interface set interface "Ethernet" enable
rem timeout /t 3
netsh interface show interface

PAUSE