@ECHO OFF

netsh interface show interface

netsh interface set interface "Ethernet" disable
timeout /t 3
netsh interface show interface

netsh interface set interface "Ethernet" enable
timeout /t 3
netsh interface show interface

PAUSE