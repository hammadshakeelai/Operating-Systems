@echo off
mkdir C:\Outer\Middle\Inner
echo Institute of Management Sciences > C:\Outer\Middle\Inner\info.txt
copy C:\Outer\Middle\Inner\info.txt E:\asd
cd /d E:\asd
del info.txt
rmdir /s /q C:\Outer
pause