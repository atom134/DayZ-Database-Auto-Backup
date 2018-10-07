# DayZ-Database-Auto-Backup [Download](https://github.com/XxFri3ndlyxX/DayZ-Database-Auto-Backup/releases/tag/v2.0)
Backup DayZ Database With Date & Time Using 7zip & Windows Task Scheduler

I know it's very basic script. But i thought some people would want to use it. I'm sure there is better ways to do it. Anyway here it is.
A NEW method by @Aussie Cleetus using sql lite. Highly Recommended

-Create a file and name it DayZ_Database_Backup.bat   or whatever name you want.

-Within the file you just created add the following
```
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
```
It will **require** an additional file named **exclude.txt** placed in **your storage_1 folder** as follows:
```
dynamic_000.bin
dynamic_001.bin
dynamic_002.bin
dynamic_003.bin
dynamic_004.bin
dynamic_005.bin
dynamic_006.bin
dynamic_007.bin
dynamic_008.bin
dynamic_009.bin
dynamic_010.bin
dynamic_011.bin
```
NOTE: This batch file can be configured for different installation paths

Download SQL Lite Tools Here
You want the sqlite-tools appropriate for your operating system (most will be looking for sqlite-tools-win32-x86-3250200.zip)
extract the zip file to C:\sqlite3tools

Change C:\DayZServer in line 11 to wherever you want the player database backups to go
Change C:\DayZServer\mpmissions\dayzOffline.chernarusplus\storage_1\players.db to suit the location where yours is found.
Save as "backup.bat" or whatever you choose - just note the location as we need it in the next step (for this example I will stick with it being C:\DayZServer
\backup.bat)
Now we setup a scheduler event in BEC
```
<!-- (runs every hour, 60 seconds after BEC starts, loop set to 3 times but if you are wise and using auto-restarts on 2-3 hrs, the server will never reach that many loops) -->
    <job id='45'>
        <day>1,2,3,4,5,6,7</day>
        <start>000060</start>
        <runtime>010000</runtime>
        <loop>3</loop>
        <cmd>C:\DayZServer\backup.bat</cmd>
    </job>
```
I adapted the OP's method and found a way around needing the server offline to back it up. This creates a copy of the players.db file in a directory created with the date and time of the backup.





**Other Alternative Methods**

- **Create a file** and name it DayZ_Database_Backup.bat   or whatever name you want.
- Within the file you just created **add the following**
```
@ECHO OFF

SET Dt=%DATE:~4,2%.%DATE:~7,2%.%DATE:~-4% %TIME:~0,2%.%TIME:~3,2%
SET SrcFolder=C:\steamcmd\dayz_server\mpmissions\dayzOffline.chernarusplus\storage_1
SET DestPath=C:\steamcmd\backups
SET TempFolder=C:\steamcmd\backups\storage1

xcopy /O /X /E /H /K /Y "%SrcFolder%" "%TempFolder%"

"C:\Program Files\7-Zip\7z" a "%DestPath%\DayZ_Database.%Dt%.7z" "%TempFolder%"
```
- **Make sure** you have installed 7zip
- SrcFolder is where you add path location of your DayZ server
- DestPath is where you want the zip file to move to.
- TempFolder is where you create a folder so when the script makes your backup and the file are in use, this will make sure the backup works correctly.
- The last line is where your 7zip is installed and the name of the backup you made. So if you want Your zip file to be name DayZ_Backup then change DayZ_Database to DayZ_Backup on that line.
This will backup your database in a zip file with the name you've chosen with its date and time.


**Method 1 (Using Bec Scheduler.xml with bat file) Recommended**

This method will make your backup run by the scheduler.xml and a quick cmd prompt will show briefly.

**Add the following code** to your Bec scheduler.xml

```
<!-- Start Database Backups -->
    <job id='45'>
        <day>1,2,3,4,5,6,7</day>
        <start>000060</start>
        <runtime>001500</runtime>
        <loop>0</loop>
        <cmd>C:\Servers\DayZServer\battleye\Bec\Backups\DayZ_Database_Backup.bat</cmd>
    </job>
<!-- End Database Backups -->
```
**Make sure to**

- Change **Job Id**
- Change **Path** location of your **bat file**.


**Method 2 ( Using Windows Task Scheduler) Last Resorts**

In this method, we will be using Windows Task Scheduler.

- Search for Task Scheduler and open it
- On the right side, Click Create Task
- Write the name you want the task to be
- Go to Trigger tab
- Click New and choose Daily
- At the bottom tick  Repeat task every
- Choose the time Ex: 1 hour
- To right where it says For a duration of choose Indefinetly
- Click ok
- Go to Action Tab
- Click New then click Browse then go to the location where you newly created .bat file you made is.
- Click ok
- Go to Settings tab and tick whatever you feel like you need.
- Once your finish Click ok.
- That's it your done and now a backup of your database with date and time will be done automatically for you.

Let me know if you have any problem. 

Modified the bat file because it would not archive files that are being read by another process (when dayz is running) and the backup would fail.

Thanks to @Quackdot for telling me my mistake and offering a workaround.

Thanks to @blkcamarors for giving me the idea of using Bec to start the .bat 

Thanks to @Aussie Cleetus For his version which is highly recommended. He has put lots of effort to make this work. Make sure to thank him if you use his version.
