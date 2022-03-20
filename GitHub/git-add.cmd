@ECHO OFF

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: Status/Differences

IF %NARGS% NEQ 0 (
	git add %1 %2 %3 %4 %5 %6 %7
) ELSE (
	git add .
)