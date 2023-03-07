@ECHO OFF
set /a modified=0


echo -------------------------------------------------------------------------------------------
echo   Running format_all script for all python files located in:
echo   %cd%
echo -------------------------------------------------------------------------------------------
echo   
for /r %%x in (*.py) do (
echo Found file to format: %%~nx.py
py -m yapf "%%x" -i --style "{based_on_style: google, column_limit: 80, indent_width: 2}" && echo   Formatted to google style.
py -m unify -i "%%x" >nul 2>&1 && echo   Unified all strings to: '
py -m isort "%%x" && echo   Sorted all python imports.
set /a modified+=1
)
echo Completed formatting for %modified% files.
pause