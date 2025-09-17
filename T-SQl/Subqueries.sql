----Subqueries
ALTER TABLE doctors
ADD salary int 
SELECT first_name + ' ' + last_name
FROM doctors
where salary = (SELECT MAX(salary) from doctors)

select distinct p.first_name + ' ' + p.last_name
from patients p
where p.patient_id IN (
    SELECT a.patient_id
    FROM appointments a
    WHERE a.doctor_id IN (
        SELECT d.doctor_id
        FROM doctors d
        WHERE d.department_id = 'DEPT001'
    )
)

select  m.medicines_id, m.name, m.unit_price, m.stock_quantity
from medicines m
where m.unit_price > (
    select AVG(m2.unit_price)
    from medicines m2
    where m2.stock_quantity = m.stock_quantity
)

SELECT appointments_id
       appointment_date,
       (SELECT COUNT(*)
        FROM appointments 
        WHERE patient_id = patient_id) as aaa
FROM appointments 

select dep.name from departments dep 
join doctors d ON dep.department_id = d.department_id
where d.department_id in ( SELECT department_id
    FROM doctors 
    WHERE specialization LIKE '%Surgeon%'
    GROUP BY department_id) 

SELECT p.patient_id, p.first_name + ' ' + p.last_name as name
FROM patients p join bills b
on p.patient_id = b.patient_id
WHERE  b.patient_id in (
    SELECT patient_id
    FROM bills 
    WHERE payment_status = 'Pending'
)

select d.first_name + ' ' + d.last_name AS name,
       d.doctor_id,
       count(a.appointments_id) AS total_appointments,
       (select avg(cnt)
        from (
            select COUNT(*) AS cnt
            from appointments
            group by doctor_id
        ) t) AS avg_appointments_per_doctor
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name
HAVING COUNT(a.appointments_id) > 1;

select m.name 
from medical_records mr 
join prescriptions p 
on mr.patient_id = p.patient_id
join prescription_medicines pm 
on pm.prescription_id =p.prescriptions_id
join medicines m
on m.medicines_id = pm.medicine_id
where mr.patient_id =(select patient_id 
					from  medical_records 
					where patient_id = 'PAT001')

UPDATE m
SET m.stock_quantity = m.stock_quantity + 50
FROM medicines m
JOIN prescription_medicines pm ON m.medicines_id = pm.medicine_id
join prescriptions p
on pm.prescription_id = p.prescriptions_id
WHERE p.prescriptions_id in ( SELECT prescriptions_id
    FROM prescriptions 
    WHERE  prescription_date >= DATEADD(MONTH, -1, GETDATE())
    GROUP BY prescriptions_id
    HAVING COUNT(*) > 10 )

DELETE lt
FROM lab_tests lt
 JOIN lab_results lr ON lt.lab_tests_id = lr.lab_results_id
WHERE  lab_results_id not in (
    SELECT DISTINCT lab_tests_id FROM lab_results
)