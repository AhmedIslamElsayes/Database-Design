---1) Database Operations
CREATE DATABASE Hospital_Backup_DB;
DROP DATABASE IF EXISTS [Hospital Backup DB];
ALTER DATABASE Hospital_Backup_DB
MODIFY NAME = Medical_Center_DB;
use Medical_Center_DB;

/*Create a temporary table named #temp patient vitals with columns: temp id INT, patient id
VARCHAR(50), blood pressure VARCHAR(10), temperature DECIMAL(4,2), heart rate INT*/
create table #temp(
temp_id int , 
patient_id VARCHAR(50), 
blood_pressure VARCHAR(10),
temperature DECIMAL(4,2),
heart_rate INT