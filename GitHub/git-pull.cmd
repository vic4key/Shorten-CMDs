@ECHO OFF

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: Status/Differences

IF %NARGS% NEQ 0 (
	git pull --no-rebase origin %1 %2 %3
) ELSE (
  git pull origin master
)
