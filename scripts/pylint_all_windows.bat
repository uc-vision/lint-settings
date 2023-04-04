:: Can be run with an absoulute or relative path as first argument.

@ECHO OFF
set /a modified=0
set pathToScan=%1
echo -------------------------------------------------------------------------------------------
echo   Running pylint_all_windows script to scan and rate found python files.
echo   The program can be run by itself or an absolute / relative path provided to start
echo   recursively scanning for python files. If there is spaces in the path, encapsulat
echo   the path in quotation marks. To run pylint on a single file the provided file path
echo   must exist, or it is recommended to run python pylint file or py -m pylint file
echo -------------------------------------------------------------------------------------------

if [%pathToScan%]==[] (
  echo   No path provided, scanning from current directory:
  set pathToscan=%cd%
  goto startScanning
)
if exist %cd%\%pathToScan% (
  set pathToScan=%cd%\%pathToScan%
  if exist %cd%\%pathToScan%\ (
    echo   Relative folder path provided:
    goto startScanning
  ) else (
    echo   Relative file path provided:
    goto pylintFile
  )
)
if exist %pathToScan% (
  if exist %pathToScan%\ (
    echo   Absolute folder path provided:
    goto startScanning
  ) else (
    echo   Absolute file path provided:
    goto pylintFile
  )
)
echo   Provided path %pathToScan% was not valid. Using current directory:
set pathToScan=%cd%


:startScanning

echo   %pathToScan%
echo -------------------------------------------------------------------------------------------
echo .
for /r %pathToScan% %%x in (*.py) do (
echo Found file to run pylint test on: %%~nx.py
py -m pylint "%%x"
set /a modified+=1
)

goto finishPylint

:pylintFile
echo   %pathToScan%
echo -------------------------------------------------------------------------------------------
echo .
py -m pylint %pathToScan%
goto finishPylint


:finishPylint
echo Completed pylint for %modified% file(s).
pause