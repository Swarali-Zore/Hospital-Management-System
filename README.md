# 🏥 Hospital Management System – SQL Project

A SQL-based **Hospital Management System** designed to organize and analyze hospital records including patients, doctors, departments, appointments, treatments, and billing information.

## 📌 Project Overview

The **Hospital Management System** uses a structured relational database to store hospital information and perform meaningful analysis using SQL.

The project demonstrates practical use of:

- Database and table creation
- Primary and foreign keys
- Entity-Relationship (ER) modeling
- `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`, and `HAVING`
- Aggregate functions such as `COUNT()`, `SUM()`, and `AVG()`
- SQL joins
- Subqueries
- Conditional aggregation using `CASE`
- Cross-table data analysis

## 🎯 Project Goal

The goal of this project is to design and implement a Hospital Management System that efficiently manages **patient, doctor, appointment, treatment, and billing data** for organized storage, retrieval, and analysis of hospital records.

## 🗄️ Database Structure

**Database Name:** `hospital_db`

The database contains six main tables:

| Table | Purpose |
|---|---|
| `patient` | Stores patient details such as name, age, gender, city, and disease |
| `doctor` | Stores doctor names, specializations, and experience |
| `department` | Stores department information and associated doctors |
| `appointment` | Stores patient-doctor appointment records and appointment dates |
| `treatment` | Stores treatment type and treatment cost for patients |
| `billing` | Stores billing amounts and payment status |

## 🔗 Database Relationships

The ER diagram establishes the following relationships:

- One patient → many appointments
- One doctor → many appointments
- One patient → many billing records
- One doctor → many departments
- One patient → many treatments

Primary and foreign keys are used to connect related tables and maintain relationships between hospital records.

## 📊 Data Analysis Performed

The project includes SQL queries for several categories of analysis.

### General Analysis

- Total number of patients
- Doctor handling the maximum number of appointments
- City with the highest number of patients
- Most commonly treated disease
- Department with the maximum number of doctors

### Treatment & Cost Analysis

- Average treatment cost
- Most frequently performed treatment
- Average treatment cost across diseases
- Patients receiving treatments above the average treatment cost

### Hospital Workflow Analysis

- Departments handling patients with the highest treatment expenses
- Patients visiting the hospital multiple times
- Doctors handling the highest number of treatments through appointments

### Payment & Revenue Analysis

- Percentage of hospital revenue that is still pending
- Patients generating billing amounts above average hospital revenue

### Cross-Table Analysis

- Diseases requiring the most expensive treatments overall
- City contributing the highest hospital revenue
- Doctors treating patients with the highest total treatment costs
- Specializations contributing to hospital revenue
- Diseases contributing most to hospital workload

## 🧠 SQL Concepts Demonstrated

This project provides hands-on practice with:

```sql
CREATE TABLE
SELECT
WHERE
GROUP BY
ORDER BY
HAVING
JOIN
COUNT()
SUM()
AVG()
CASE
LIMIT
Subqueries
Foreign Keys
Primary Keys
