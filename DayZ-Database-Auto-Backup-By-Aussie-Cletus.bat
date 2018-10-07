@ECHO OFF

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "fullstamp=%YYYY%_%MM%_%DD%_%HH%_%Min%_%Sec%"

set serverroot=C:\DayZServer
set sqlitebin=C:\sqlite3tools\sqlite3.exe

set storagedir=%serverroot%\mpmissions\dayzOffline.chernarusplus\storage_1
set playerdatabase=%storagedir%\players.db
set worlddatabase=%storagedir%\data
set backupsdirname=Backups

set backupdir=%serverroot%\%backupsdirname%
set backupplayerdatabase=players.db
set backupworlddatabase=%backupdir%\%fullstamp%\data

set xcopybase=C:\Windows\System32\xcopy.exe
set xcopyparams=/o /x /k /e /r /h /y /i
set xcopyexclude=/exclude:%storagedir%\exclude.txt
set xcopycmd=%xcopybase% %xcopyexclude% "%worlddatabase%" "%backupworlddatabase%"

set sqliteintcmd=".backup %backupplayerdatabase%"
set sqlitecmd=%sqlitebin% %playerdatabase% %sqliteintcmd%

c:
cd %backupdir%
mkdir %fullstamp%
cd %fullstamp%
mkdir data

echo "Starting World Persistence Backup"
%xcopycmd%
echo "Starting Player Database Backup"
%sqlitecmd%
cd ../..
