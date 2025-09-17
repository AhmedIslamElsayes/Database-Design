----Backup and Restore
BACKUP DATABASE [Hospital_DB]
TO DISK = 'D:\depi\SQL\Hospital_DB Full.bak'
WITH NAME = 'Hospital DB Full Backup',
     DESCRIPTION = 'Full Backup of Hospital_DB database',
     INIT,
     STATS = 10;

----Restore
RESTORE DATABASE [Hospital_DB]
FROM DISK = 'D:\depi\SQL\Hospital_DB Full.bak'
WITH 
    FILE = 1,
    NOUNLOAD,
    REPLACE,
    STATS = 10;