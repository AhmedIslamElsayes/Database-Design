-----Views
create view vPatientAppointments as
SELECT 
	p.first_name + ' ' + p.last_name as full_name_pat ,
	a.appointment_date,
	d.first_name + ' ' + d.last_name as full_name_dot 
FROM patients p
JOIN appointments a 
    ON p.patient_id = a.patient_id
JOIN doctors d 
    ON a.doctor_id = d.doctor_id; 
select *  from vPatientAppointments

insert into patients (patient_id , first_name , last_name, date_of_birth)
 values ('PAT052' , 'mirna' , 'ahmed' ,'2001-07-07')

EXEC sp_rename 'vPatientAppointments', 'vPatientVisits';
 
 drop view vPatientVisits

 create view vDailyRevenue AS
 select  billing_date , 
		SUM(paid_amount) AS total_revenue
FROM bills
GROUP BY billing_date
select * from vDailyRevenue