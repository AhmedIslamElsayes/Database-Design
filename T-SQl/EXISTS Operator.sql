--EXISTS Operator
SELECT *
FROM doctors d
WHERE EXISTS (
    SELECT 1
    FROM appointments a
    WHERE a.doctor_id = d.doctor_id
      AND a.status = 'Completed'
)

SELECT *
FROM patients p
WHERE EXISTS (
    SELECT 1
    FROM bills b
    WHERE b.patient_id = p.patient_id
      AND b.payment_status != 'Paid'
)

SELECT *
FROM medicines m
WHERE EXISTS (
    SELECT 1
    FROM prescription_medicines pm
    WHERE pm.medicine_id = m.medicines_id
);

SELECT *
FROM departments d
WHERE not EXISTS (
    SELECT 1
    FROM doctors doc
    WHERE doc.department_id = d.department_id
)

SELECT *
FROM patients p
WHERE NOT EXISTS (
    SELECT 1
    FROM appointments a
    WHERE a.patient_id = p.patient_id
)