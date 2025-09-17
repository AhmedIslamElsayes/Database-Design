---aggregate function
SELECT COUNT(*) AS male_patient_count
FROM patients
WHERE gender = 'Male';

SELECT SUM(total_amount - paid_amount) AS total_outstanding_balance
FROM bills;

SELECT MIN(unit_price) AS lowest_medicine_price
FROM medicines;

SELECT MAX(total_amount) AS highest_bill_amount
FROM bills;

SELECT AVG(cost) AS average_lab_test_cost
FROM lab_tests; 