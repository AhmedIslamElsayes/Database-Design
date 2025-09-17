---5 UPDATE Operations
UPDATE patients
SET phone = '966-500-2007'
WHERE patient_id = 'PAT007'

UPDATE appointments
SET status = 'COMPLETED'
WHERE appointments_id  = 'APT012'

UPDATE medicines
SET stock_quantity = 2500
WHERE medicines_id = 'MED005';

UPDATE doctors
SET email = 'lisa.thomas@medicalcenter.com'
WHERE doctor_id = 'DOC008';

UPDATE bills
SET payment_status = 'Paid',
    paid_amount = 350.00
WHERE bills_id = 'BILL004';

---5 DELETE Operations
DELETE FROM patients
WHERE patient_id = 'PAT042';

DELETE FROM appointments
WHERE appointment_date < '2020-01-01';

WITH DuplicatePatients AS (
    SELECT 
        patient_id,
        first_name,
        last_name,
        date_of_birth,
        ROW_NUMBER() OVER (
            PARTITION BY first_name, last_name, date_of_birth
            ORDER BY patient_id
        ) AS row_num
    FROM patients
)
DELETE FROM DuplicatePatients
WHERE row_num > 1

DELETE from medicines
where expiry_date < CAST(GETDATE() AS DATE)

DELETE FROM lab_results
WHERE patient_id = 'PAT018';
