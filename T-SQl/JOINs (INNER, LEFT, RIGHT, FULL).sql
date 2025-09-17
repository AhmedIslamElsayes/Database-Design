---27 JOINs (INNER, LEFT, RIGHT, FULL)
SELECT a.appointments_id,
       a.appointment_date,
       a.appointment_time,
       a.status,
       a.reason,
       a.notes,
       a.department_id,
       p.first_name +  p.last_name AS patient_full_name,
       d.first_name +  d.last_name AS doctor_full_name
FROM appointments a
INNER JOIN patients p ON a.patient_id = p.patient_id
INNER JOIN doctors d ON a.doctor_id = d.doctor_id;

SELECT p.patient_id,
       p.first_name +  p.last_name AS patient_full_name,
       a.appointments_id,
       a.appointment_date,
       a.appointment_time,
       a.status,
       a.reason,
       a.department_id,
       a.doctor_id
FROM patients p
LEFT JOIN appointments a ON p.patient_id = a.patient_id;

SELECT d.doctor_id,
       d.first_name + d.last_name AS doctor_full_name,
       a.appointments_id,
       a.appointment_date,
       a.appointment_time,
       a.status,
       a.reason,
       a.department_id,
       a.patient_id
FROM appointments a
RIGHT JOIN doctors d ON a.doctor_id = d.doctor_id;

SELECT p.patient_id,
       p.first_name +  p.last_name AS patient_full_name,
       d.doctor_id,
       d.first_name +  d.last_name AS doctor_full_name,
       a.appointments_id,
       a.appointment_date,
       a.appointment_time,
       a.status,
       a.reason,
       a.department_id
FROM patients p
FULL OUTER JOIN appointments a ON p.patient_id = a.patient_id
FULL OUTER JOIN doctors d ON a.doctor_id = d.doctor_id;

SELECT a.appointments_id,
       p.first_name +  p.last_name AS patient_full_name,
       d.first_name +  d.last_name AS doctor_full_name,
       dept.name AS department_name,
       mr.diagnosis,
       b.total_amount AS total_bill_amount
FROM appointments a
INNER JOIN patients p ON a.patient_id = p.patient_id
INNER JOIN doctors d ON a.doctor_id = d.doctor_id
INNER JOIN departments dept ON a.department_id = dept.department_id
LEFT JOIN medical_records mr ON a.appointments_id = mr.appointment_id
LEFT JOIN bills b ON a.appointments_id = b.appointment_id
WHERE a.appointments_id = 'APT005';
