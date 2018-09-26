# DayZ-Database-Auto-Backup
Backup DayZ Database With Date & Time Using 7zip & Windows Task Scheduler

I know it's very basic script. But i thought some people would want to use it. I'm sure there is better ways to do it. Anyway here it is.
- Create a file and name it DayZ_Database_Backup.bat   or whatever name you want.
- Within the file you just created add the following
```
@ECHO OFF

SET Dt=%DATE:~4,2%.%DATE:~7,2%.%DATE:~-4% %TIME:~0,2%.%TIME:~3,2%
SET SrcFolder=C:\steamcmd\dayz_server\mpmissions\dayzOffline.chernarusplus\storage_1
SET DestPath=C:\steamcmd\backups
SET TempFolder=C:\steamcmd\backups\storage1

xcopy /O /X /E /H /K /Y "%SrcFolder%" "%TempFolder%"

"C:\Program Files\7-Zip\7z" a "%DestPath%\DayZ_Database.%Dt%.7z" "%TempFolder%"
```
- Make sure you have installed 7zip
- SrcFolder is where you add path location of your DayZ server
- DestPath is where you want the zip file to move to.
- TempFolder is where you create a folder so when the script makes your backup and the file are in use, this will make sure the backup works correctly.
- The last line is where your 7zip is installed and the name of the backup you made. So if you want Your zip file to be name DayZ_Backup then change DayZ_Database to DayZ_Backup on that line.
This will backup your database in a zip file with the name you've chosen with its date and time.
Next to make it that it automates by itself. You will need to make a task using Task Scheduler.
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

Edited the bat file because it can't archive files that are being read by another process, so files like players.db and occasionally the binary files will also fail. And players.db is obviously, very important.

Thanks to @Quackdot for telling me my mistake and offering a workaround.
