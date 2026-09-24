-- =================================================================================
-- PROJECT 
-- TITLE: Hospital Management System
-- TOOL: MySQL Workbench
-- =================================================================================

-- =================================================================================
-- Step 1 - Creating database
-- =================================================================================

CREATE DATABASE IF NOT EXISTS hospital_db;

USE hospital_db;

-- =================================================================================
-- Step 2 - Creating Tables
-- =================================================================================

-- 1) Patient Table
CREATE TABLE patient (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50),
    disease VARCHAR(100)
);

SELECT * FROM patient;
-- ---------------------------------------------------------------------------------

-- 2) Doctor Table
CREATE TABLE doctor (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialization VARCHAR(50),
    experience INT
);

SELECT * FROM doctor;
-- ---------------------------------------------------------------------------------

-- 3) Department Table
CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    doctor_id INT,
    FOREIGN KEY (doctor_id)
    REFERENCES doctor(doctor_id)
);

SELECT * FROM department;
-- ---------------------------------------------------------------------------------

-- 4) Appointment Table
CREATE TABLE appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    FOREIGN KEY (patient_id)
    REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id)
    REFERENCES doctor(doctor_id)
);

SELECT * FROM appointment;
-- ---------------------------------------------------------------------------------

-- 5) Treatment Table
CREATE TABLE treatment (
    treatment_id INT PRIMARY KEY,
    patient_id INT,
    treatment_type VARCHAR(100),
    treatment_cost INT,
    FOREIGN KEY (patient_id)
    REFERENCES patient(patient_id)
);

SELECT * FROM treatment;
-- ---------------------------------------------------------------------------------

-- 6) Billing Table
CREATE TABLE billing (
    bill_id INT PRIMARY KEY,
    patient_id INT,
    total_amount INT,
    payment_status VARCHAR(20),
    FOREIGN KEY (patient_id)
    REFERENCES patient(patient_id)
);

SELECT * FROM billing;
-- ---------------------------------------------------------------------------------

-- =================================================================================
-- Step 3 - Finding Relationships Between Tables
-- =================================================================================

-- patient (1) → (many) appointment
-- doctor (1) → (many) appointment
-- patient (1) → (many) billing
-- doctor (1) → (many) department
-- patient (1) → (many) treatment

-- =================================================================================
-- Step 4 - Inserting Values
-- =================================================================================
SELECT * FROM patient;

SELECT * FROM doctor;

SELECT * FROM department;

SELECT * FROM appointment;

SELECT * FROM treatment;

SELECT * FROM billing;

-- =================================================================================
-- Step 5 - Question-Answers
-- =================================================================================

-- GENERAL ANALYSIS

-- Que 1 - What is the total number of patients in the hospital ?
SELECT COUNT(*) AS total_patients
FROM patient;
-- ---------------------------------------------------------------------------------

-- Que 2 - Which doctor handled the maximum number of appointments ?
SELECT doctor_id, COUNT(*) AS total_appointments
FROM appointment
GROUP BY doctor_id
ORDER BY total_appointments DESC
LIMIT 1;
-- ---------------------------------------------------------------------------------

-- Que 3 - Which city has the highest number of patients visiting the hospital ?
SELECT city, COUNT(*) AS patient_count
FROM patient
GROUP BY city
ORDER BY patient_count DESC
LIMIT 1;
-- ---------------------------------------------------------------------------------

-- Que 4 - Which disease is most commonly treated in the hospital ?
SELECT disease, COUNT(*) AS total_cases
FROM patient
GROUP BY disease
ORDER BY total_cases DESC
LIMIT 1;
-- ---------------------------------------------------------------------------------

-- Que 5 - Which department has the maximum number of doctors ?
SELECT dept_name, COUNT(doctor_id) AS doctor_count
FROM department
GROUP BY dept_name
ORDER BY doctor_count DESC
LIMIT 1;
-- ---------------------------------------------------------------------------------

-- TREATMENT AND COST ANALYSIS

-- Que 1 - What is the average treatment cost in the hospital ?
SELECT AVG(treatment_cost) AS avg_treatment_cost
FROM treatment;
-- ---------------------------------------------------------------------------------

-- Que 2 - Which treatment type is most frequently performed ?
SELECT treatment_type, COUNT(*) AS frequency
FROM treatment
GROUP BY treatment_type
ORDER BY frequency DESC
LIMIT 1;
-- ---------------------------------------------------------------------------------

-- Que 3 - How does treatment cost vary across diseases ?
SELECT p.disease, AVG(t.treatment_cost) AS avg_cost
FROM patient p
JOIN treatment t
ON p.patient_id = t.patient_id
GROUP BY p.disease;
-- ---------------------------------------------------------------------------------

-- HOSPITAL WORKFLOW ANALYSIS

-- Que 1 - Which patients received treatments costing above average treatment cost ?
SELECT patient_id, treatment_cost
FROM treatment
WHERE treatment_cost >
(
SELECT AVG(treatment_cost)
FROM treatment
);
-- ---------------------------------------------------------------------------------

-- Que 2 - Which departments handle patients with the highest treatment expenses ?
SELECT dept.dept_name, SUM(t.treatment_cost) AS total_cost
FROM department dept
JOIN doctor d
ON dept.doctor_id = d.doctor_id
JOIN appointment a
ON d.doctor_id = a.doctor_id
JOIN treatment t
ON a.patient_id = t.patient_id
GROUP BY dept.dept_name
ORDER BY total_cost DESC;
-- ---------------------------------------------------------------------------------

-- Que 3 - Which patients visited the hospital multiple times for appointments ?
SELECT patient_id, COUNT(appointment_id) AS visit_count
FROM appointment
GROUP BY patient_id
HAVING COUNT(appointment_id) > 1;
-- ---------------------------------------------------------------------------------

-- Que 4 : Which doctors are handling the highest number of treatments through appointments ?
SELECT d.doctor_name as doctor_id , COUNT(t.treatment_id) AS total_treatments
FROM doctor d
JOIN appointment a
ON d.doctor_id = a.doctor_id
JOIN treatment t
ON a.patient_id = t.patient_id
GROUP BY d.doctor_name
ORDER BY total_treatments DESC;
-- ---------------------------------------------------------------------------------

-- PAYMENTS AND REVENUE INSIGHTS

-- Que 1 - What percentage of total hospital revenue is still pending ?
SELECT 
SUM(CASE WHEN payment_status='Pending' THEN total_amount ELSE 0 END)
*100 / SUM(total_amount) AS pending_percentage
FROM billing;
-- ---------------------------------------------------------------------------------

-- Que 2 - Which patients generated billing amounts above hospital average revenue ?
SELECT patient_id, total_amount
FROM billing
WHERE total_amount >
(
SELECT AVG(total_amount)
FROM billing
);
-- ---------------------------------------------------------------------------------

-- CROSS-TABLE INSIGHTS

-- Que 1 : Which diseases require the most expensive treatments overall ?
SELECT p.disease, SUM(t.treatment_cost) AS total_cost
FROM patient p
JOIN treatment t
ON p.patient_id = t.patient_id
GROUP BY p.disease
ORDER BY total_cost DESC;
-- ---------------------------------------------------------------------------------

-- Que 2 : Which city contributes the highest hospital revenue ?
SELECT p.city, SUM(b.total_amount) AS revenue
FROM patient p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.city
ORDER BY revenue DESC
LIMIT 1;
-- ---------------------------------------------------------------------------------

-- Que 3 : Which doctors treat patients with the highest total treatment costs ?
SELECT d.doctor_name as doctor_id, SUM(t.treatment_cost) AS total_cost
FROM doctor d
JOIN appointment a
ON d.doctor_id = a.doctor_id
JOIN treatment t
ON a.patient_id = t.patient_id
GROUP BY d.doctor_name
ORDER BY total_cost DESC;
-- ---------------------------------------------------------------------------------

-- Que 4 : Which specialization contributes the highest hospital revenue ?
SELECT d.specialization, SUM(b.total_amount) AS revenue
FROM doctor d
JOIN appointment a
ON d.doctor_id = a.doctor_id
JOIN billing b
ON a.patient_id = b.patient_id
GROUP BY d.specialization
ORDER BY revenue DESC;
-- ---------------------------------------------------------------------------------

-- Que 5 : Which diseases contribute most to hospital workload ?
SELECT disease, COUNT(*) AS total_cases
FROM patient
GROUP BY disease
ORDER BY total_cases DESC;
-- ---------------------------------------------------------------------------------


