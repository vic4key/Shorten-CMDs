@ECHO OFF

SET /p response=[+] Revert changes in local reposity ? 
SET "confirm=0"
IF [%response%]==[Y] SET confirm=1
IF [%response%]==[y] SET confirm=1

IF [%confirm%]==[1] (
  git reset --hard
) ELSE (
  ECHO Canceled
)