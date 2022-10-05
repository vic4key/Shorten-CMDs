@ECHO OFF

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: N-Args

IF %NARGS% NEQ 1 (
	GOTO L_INVALID_NARGS
)

:: Remove

SET repos_sub_module_dir=%1
git submodule deinit -f %repos_sub_module_dir%
git rm -f %repos_sub_module_dir%

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: git-sub-remove #1
ECHO		#1 -^> The sub-module name
ECHO	Example:
ECHO		git-sub-remove local/path/to/sub-module

:: Exit

:L_EXIT