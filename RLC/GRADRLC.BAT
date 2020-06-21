@echo off
echo.

rem // test access to required files
if exist results  erase results
if exist results  goto  locked
if exist rlc.ans  erase rlc.ans

rem // assure all executable files exist
if not exist rlcdrvr.exe   goto error1
if not exist gradcpy.bat   goto error2
if not exist gradcpya.bat  goto error2
if not exist graddoc.exe   goto error2
if not exist gradgtl.exe   goto error2
if not exist gradlog.exe   goto error2
if not exist gradmrlc.exe  goto error2
if not exist gradrlc.mod   goto error2
if not exist rlc.asm       goto error3

rem // init grading count
if exist gradrlc.cnt goto tmetest
copy gradrlc.mod gradrlc.cnt

:tmetest
rem // init history log
if exist gradrlc.tme goto endtme
echo Grading and testing history log > gradrlc.tme
:endtme
if %1. == s. goto run
gradgtl gradrlc.tme                                           >> results
if errorlevel 4 goto disp
goto run

:disp
gradgtl gradrlc.tme
goto exit

:run
rem // update count and log
gradlog gradrlc.cnt gradrlc.tme p47 2
if errorlevel 4 goto locked

echo RLC Grading System Version 4.0 >> results

type gradid.p47  >> results
type gradrlc.tme >> results

rem // run tests

echo.                                                         >> results
echo Testing 1 dimension compression                          >> results
rlcdrvr 8
rlcdrvr 9                                                     >> results

if     errorlevel 2 goto err1d
if not errorlevel 0 goto err1d

rem // all tests run ... get the instruction grade
echo 1 dimension compression is working                       >> results
echo.                                                         >> results
echo The following is credit earned for 1-dim compression     >> results
call gradcpy results+testout1 gradjunk                        >  junk
call gradcpy gradjunk         results                         >  junk
echo.                                                         >> results
echo ++ Grade ++  040 = Points earned for correct answers.    >> results

rem // grade instructions written
echo.                                                         >> results
gradmrlc rlc.asm                                              >> results

rem Grade documentation
echo.                                                         >> results
graddoc rlc.asm                                               >> results

rem Calculate the grade
echo.                                                         >> results
gradres
type  gradres.tmp                                             >> results
erase gradres.tmp
if exist gradin  erase gradin

echo Building the file rlc.ans for electronic submission...   >> results

echo.                                                         >> results
call gradcpy.bat results+rlc.asm rlc.ans                      >  junk

goto exit


:error1
echo.
echo The executable file 'rlcdrvr.exe' does not exist.
echo.
echo.                                                         >> results
echo The executable file 'rlcdrvr.exe' does not exist.        >> results
echo.                                                         >> results
goto exit


:error2
echo.
echo The grading system has detected a problem.
echo Some of the required files are missing.
echo Try to re-copy all the grading files from the course locker.
echo If this fails then contact the instructor.
echo.
echo.                                                         >> results
echo The grading system has detected a problem.               >> results
echo Some of the required files are missing.                  >> results
echo Re-copy all the grading files from the course locker.    >> results
echo If this fails then contact the instructor.               >> results
echo.                                                         >> results
goto exit


:error3
echo.
echo The source file 'rlc.asm' does not exist.
echo This file needs to be in the current directory.
echo.
echo.                                                         >> results
echo The source file 'rlc.asm' does not exist.                >> results
echo This file needs to be in the current directory.          >> results
echo.                                                         >> results
goto exit


:locked
if exist results erase results
echo.
echo The grading system can not access its files.
echo Shutdown and reboot the system
echo.
goto exit

rem // grade instructions written
echo.                                                         >> results
gradmfx1 rlc.asm                                              >> results

rem // Grade documentation
echo.                                                         >> results
graddoc rlc.asm                                               >> results

rem Calculate the grade
echo.                                                         >> results
gradres
type  gradres.tmp                                             >> results
erase gradres.tmp                                             >> results
echo Building the file rlc.ans for electronic submission...   >> results
echo.                                                         >> results
call gradcpy.bat results+rlc.asm rlc.ans                      >  junk
goto exit


:err1d
echo.                                                         >> results
echo 1 dimension compression is not working                   >> results
echo.                                                         >> results
echo ++ Grade ++  000 = Points earned for correct answers.    >> results
echo.                                                         >> results
gradres
type  gradres.tmp                                             >> results
erase gradres.tmp                                             >> results
echo Building the file rlc.ans for electronic submission...   >> results
echo.                                                         >> results
call gradcpy.bat results+rlc.asm rlc.ans                      >  junk
goto exit


:exit
if exist junk     erase junk
if exist junkout  erase junkout
if exist gradjunk erase gradjunk
if exist testout1 erase testout1
if exist testout2 erase testout2
