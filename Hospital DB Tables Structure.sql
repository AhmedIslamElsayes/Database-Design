
-- Patients Table
CREATE TABLE patients (
patient_id VARCHAR(50) PRIMARY KEY ,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
date_of_birth DATE NOT NULL, -- '2025 - 8 - 24'
gender VARCHAR(10) check (gender in ('Male' , 'Female')),
address VARCHAR(255),
phone VARCHAR(20) unique,
email VARCHAR(100) unique,
emergency_contact VARCHAR(100),
blood_type VARCHAR(5),
allergies VARCHAR(255)
);

-- Departments Table
CREATE TABLE departments (
department_id VARCHAR(50) PRIMARY KEY,
name VARCHAR(100) NOT NULL,
location VARCHAR(100),
phone VARCHAR(20)
);
-- Medicines Table
CREATE TABLE medicines (
medicines_id VARCHAR(50) PRIMARY KEY,
name VARCHAR(100) NOT NULL,
description TEXT,
stock_quantity INT DEFAULT 0,
unit_price DECIMAL(10,2), 
expiry_date DATE
);
-- Lab Tests Table
CREATE TABLE lab_tests (
lab_tests_id VARCHAR(50) PRIMARY KEY,
name VARCHAR(100) NOT NULL,
description TEXT,
cost DECIMAL(10,2) check (cost > 50)
);
-- Doctors Table
CREATE TABLE doctors (
doctor_id VARCHAR(50) PRIMARY KEY,
department_id VARCHAR(50),
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
specialization VARCHAR(100),
phone VARCHAR(20),
email VARCHAR(100),
FOREIGN KEY (department_id) 
REFERENCES 
departments(department_id)
);

-- Appointments Table
CREATE TABLE appointments (
appointments_id VARCHAR(50) PRIMARY KEY,

appointment_date DATE NOT NULL,
appointment_time TIME NOT NULL,
status VARCHAR(50),
reason VARCHAR(255),
notes TEXT,
department_id VARCHAR(50),
doctor_id VARCHAR(50),
patient_id VARCHAR(50),
FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
FOREIGN KEY (department_id) REFERENCES departments(department_id),
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE medical_records (
medical_records_id VARCHAR(50) PRIMARY KEY,
patient_id VARCHAR(50),
appointment_id VARCHAR(50),
diagnosis TEXT,
treatment TEXT,
record_date DATE,
notes TEXT,
doctor_id VARCHAR(50),
FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
FOREIGN KEY (appointment_id) REFERENCES appointments(appointments_id),
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Prescriptions Table
CREATE TABLE prescriptions (
prescriptions_id VARCHAR(50) PRIMARY KEY,
patient_id VARCHAR(50),
medical_record_id VARCHAR(50),
prescription_date DATE,
notes TEXT,
doctor_id VARCHAR(50),
FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
FOREIGN KEY (medical_record_id) REFERENCES medical_records(medical_records_id),
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);


-- Prescription_Medicines Table
CREATE TABLE prescription_medicines (

prescription_medicines_id VARCHAR(50) PRIMARY KEY,
prescription_id VARCHAR(50),
medicine_id VARCHAR(50),
dosage VARCHAR(100),
frequency VARCHAR(100),
duration VARCHAR(100),
FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescriptions_id),
FOREIGN KEY (medicine_id) REFERENCES medicines(medicines_id)
);

-- Lab Results Table
CREATE TABLE lab_results (
lab_results_id VARCHAR(50) PRIMARY KEY,
patient_id VARCHAR(50),
appointment_id VARCHAR(50),
lab_test_id VARCHAR(50),
result TEXT,
result_date DATE,
notes TEXT,
FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
FOREIGN KEY (appointment_id) REFERENCES appointments(appointments_id),
FOREIGN KEY (lab_test_id) REFERENCES lab_tests(lab_tests_id)
);
-- Bills Table
CREATE TABLE bills (
bills_id VARCHAR(50) PRIMARY KEY ,
total_amount DECIMAL(10,2) NOT NULL,
paid_amount DECIMAL(10,2) DEFAULT 0,
payment_status VARCHAR(50),
billing_date DATE,
payment_method VARCHAR(50),
patient_id VARCHAR(50),
appointment_id VARCHAR(50),
FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
FOREIGN KEY (appointment_id) REFERENCES appointments(appointments_id)
);
-- Staff Table
CREATE TABLE staff (
    staff_id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    role VARCHAR(50), -- Nurse, Receptionist, Technician
    phone VARCHAR(20),
    email VARCHAR(100),
    department_id VARCHAR(50),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Rooms Table
CREATE TABLE rooms (
    room_id VARCHAR(50) PRIMARY KEY,
    room_number VARCHAR(20) UNIQUE,
    room_type VARCHAR(50), -- ICU, General, Private
    status VARCHAR(50) DEFAULT 'Available'
);

-- Admissions Table
CREATE TABLE admissions (
    admission_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50),
    room_id VARCHAR(50),
    admission_date DATE,
    discharge_date DATE,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- Insurance Table
CREATE TABLE insurance (
    insurance_id VARCHAR(50) PRIMARY KEY,
    company_name VARCHAR(100),
    policy_number VARCHAR(100),
    coverage_details TEXT,
    patient_id VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Payments Transactions Table
CREATE TABLE payment_transactions (
    transaction_id VARCHAR(50) PRIMARY KEY,
    bill_id VARCHAR(50),
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_method VARCHAR(50),
    notes TEXT,
    FOREIGN KEY (bill_id) REFERENCES bills(bills_id)
);

-- Suppliers Table
CREATE TABLE suppliers (
    supplier_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255)
);

-- Medicine_Suppliers Table (many-to-many)
CREATE TABLE medicine_suppliers (
    medicine_supplier_id VARCHAR(50) PRIMARY KEY,
    supplier_id VARCHAR(50),
    medicine_id VARCHAR(50),
    supply_date DATE,
    quantity INT,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicines_id)
);

-- Users & Roles
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    username VARCHAR(100) UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50), -- Admin, Doctor, Nurse, Receptionist
    linked_doctor_id VARCHAR(50), -- if user is a doctor
    linked_staff_id VARCHAR(50),  -- if user is staff
    FOREIGN KEY (linked_doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (linked_staff_id) REFERENCES staff(staff_id)
);
CREATE TABLE doctor_salaries (
    salary_id VARCHAR(50) PRIMARY KEY,
    doctor_id VARCHAR(50),
    base_salary DECIMAL(10,2) NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0,
    deductions DECIMAL(10,2) DEFAULT 0,
    effective_date DATE NOT NULL,
    notes TEXT,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);



