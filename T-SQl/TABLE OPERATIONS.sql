--2)TABLE OPERATIONS--
---Create a permanent table named ”staff” with columns
CREATE TABLE staff (
    staff_id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    position VARCHAR(100),
    department_id VARCHAR(50),
    hire_date DATE,
    salary DECIMAL(10,2)
)
--Drop the table
DROP TABLE staff;

--Rename the table ”patients” to ”clients”
EXEC sp_rename 'patients', 'clients';

---Truncate all records from the ”lab results
TRUNCATE TABLE lab_results;

---10. Create a copy of the ”doctors” table named ”doctors backup” with all its data
SELECT *
INTO doctors_backup
FROM doctors;
---3 SELECT Queries
SELECT *
FROM patients
WHERE patient_id = 'PAT015';

SELECT first_name, last_name, phone
FROM patients
WHERE last_name = 'Al-Fayed';

SELECT *
FROM doctors
WHERE department_id = 'DEPT001';

SELECT *
FROM appointments
WHERE appointment_date = '2024-02-15';

SELECT *
FROM patients
WHERE date_of_birth BETWEEN '1990-01-01' AND '1995-12-31';

---4 INSERT Operations
INSERT INTO patients (patient_id, first_name,last_name,date_of_birth,gender,address,phone,email,emergency_contact,blood_type,allergies)VALUES 
('PAT051','Ali','Hassan','1988-11-03','Male','123 Palm Street, Dubai','971-555-0123','ali.hassan@email.com','Fatima Hassan-971-555-0124','B+','None');

INSERT INTO medicines (medicines_id, name, description, stock_quantity, unit_price, expiry_date) VALUES
('MED016', 'Paracetamol', 'Pain reliever', 1500, 7.50, '2026-05-31'),
('MED017', 'Amoxicillin-Clavulanate', 'Antibiotic', 800, 22.75, '2025-10-15'),
('MED018', 'Metoprolol Succinate', 'Beta blocker', 600, 18.25, '2025-11-30');

INSERT INTO appointments 
(appointments_id, appointment_date, appointment_time, status, reason, notes, department_id, doctor_id, patient_id)
VALUES 
('APP051', '2024-03-10', '10:30:00', 'Scheduled', 'Routine Checkup', 'First visit for patient PAT025', 'DEPT001', 'DOC003', 'PAT025');

INSERT INTO departments (department_id, name, location, phone)
VALUES ('DEPT011', 'Physical Therapy', 'Floor 5, Wing A', '555-1011');

INSERT INTO lab_tests (lab_tests_id, name, description, cost)
VALUES 
('LAB011', 'HIV Test', 'Test for HIV antibodies', 150.00),
('LAB012', 'Hepatitis Panel', 'Test for Hepatitis A, B, and C', 225.00)
