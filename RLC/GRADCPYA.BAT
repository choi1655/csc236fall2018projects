@echo off

copy %1 %2 %3

:wait
if not exist %3 goto wait

:exit
