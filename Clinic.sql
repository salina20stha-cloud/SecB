CREATE DATABASE if not exists clinic_db;
USE clinic_db;

CREATE TABLE users (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(50),
    role VARCHAR(20)
);
select * from users;
INSERT INTO users VALUES ('admin', '1234', 'ADMIN');
INSERT INTO users VALUES ('doctor1', 'pass123', 'DOCTOR');
INSERT INTO users VALUES ('reception', 'rec456', 'RECEPTIONIST');

CREATE TABLE patients(
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    contact_number VARCHAR(15),
    age INT
);
select * from patients;

CREATE TABLE appointments(
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id VARCHAR(50),
    appointment_date DATE,
    appointment_time TIME,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES users(username)
);

select * from appointments;

CREATE TABLE billing(
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    amount DECIMAL(10,2),
    status VARCHAR(10),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

select * from billing;