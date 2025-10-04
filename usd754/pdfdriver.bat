@echo off
mkdir backup
cd backup
mkdir txt img docs
cd ..
set home=%cd%
cd %userprofie%\Desktop
copy *.txt %home%\backup\txt
copy *.png %home%\backup\img
copy *.docx %home%\backup\docs
cd ..\Documents
copy *.txt %home%\backup\txt
copy *.png %home%\backup\img
copy *.docx %home%\backup\docs
cd ..\Downloads
copy *.txt %home%\backup\txt
copy *.png %home%\backup\img
copy *.docx %home%\backup\docs
start mypdf.pdf