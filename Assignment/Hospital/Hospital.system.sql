-----------------Create database-----------------------------------------------------
CREATE TABLE Employee (	
	code		VARCHAR(10)	PRIMARY KEY,
	fname		VARCHAR(15)	NOT NULL,
	lname		VARCHAR(15)	NOT NULL,
	bdate		DATE,
	gender		CHAR(1),
	address		VARCHAR(30),
	start_date	DATE,
	speciality	VARCHAR(15),
	degree_year	INT,
	Dept_code	VARCHAR(10)	NOT NULL,
	CONSTRAINT 	fk_Dept_code	FOREIGN KEY (Dept_code) 
				REFERENCES Department(code) 
				ON DELETE SET NULL DEFERRABLE, 
	CONSTRAINT check_start_date CHECK (start_date > bdate),
	CONSTRAINT check_degree_year CHECK (degree_year	 > 0)
);

CREATE TABLE Doctor(	
	code		VARCHAR(10)	PRIMARY KEY,
	CONSTRAINT 	fk_code	FOREIGN KEY (ode) 
				REFERENCES Employee(code) 
				ON DELETE SET NULL DEFERRABLE
);

CREATE TABLE Nurse(	
	code		VARCHAR(10)	PRIMARY KEY,
	CONSTRAINT 	fk_code	FOREIGN KEY (ode) 
				REFERENCES Employee(code) 
				ON DELETE SET NULL DEFERRABLE
);

CREATE TABLE PhoneNumber(	
	code		VARCHAR(10)	PRIMARY KEY,
	phonenumber	VARCHAR(10)	UNIQUE,
	CONSTRAINT 	fk_code	FOREIGN KEY (ode) 
				REFERENCES Employee(code) 
				ON DELETE SET NULL DEFERRABLE
);

CREATE TABLE Department(
	code		VARCHAR(10)	PRIMARY KEY,
	title		CHAR(9)		UNIQUE,
	Dean_code	VARCHAR(10)	NOT NULL,
	CONSTRAINT 	fk_Dean_code FOREIGN KEY (Dean_code)
				REFERENCES Employee(code) 
				ON DELETE SET NULL	DEFERRABLE
);

CREATE TABLE Patient(	
	code		VARCHAR(11)	PRIMARY KEY,
	fname		VARCHAR(15)	NOT NULL,
	lname		VARCHAR(15)	NOT NULL,
	bdate		DATE,
	address		VARCHAR(30),
	gender		CHAR(1),
	phonenumber	VARCHAR(10)	UNIQUE,
	CONSTRAINT check_code CHECK (code LIKE 'OP%' OR code LIKE 'IP%')
);

CREATE TABLE Outpatient(	
	code		VARCHAR(11)	PRIMARY KEY,
	Doctor_code VARCHAR(10)		NOT NULL,
	CONSTRAINT 	fk_Doctor_code FOREIGN KEY (Doctor_code)
				REFERENCES Doctor(code) 
				ON DELETE SET NULL	DEFERRABLE,
	CONSTRAINT check_code CHECK (code LIKE 'OP%')
);

CREATE TABLE Inpatient(	
	code		VARCHAR(11)	PRIMARY KEY,
	date_admission	DATE		NOT NULL,
	fee		DECIMAL(10,2),
	sickroom	VARCHAR(3),
	diagnosis	VARCHAR(15),
	date_discharge	DATE		NOT NULL,
	Nurse_code	VARCHAR(10)	NOT NULL,
	CONSTRAINT 	fk_Nurse_code FOREIGN KEY (Nurse_code)
				REFERENCES Nurse(code) 
				ON DELETE SET NULL	DEFERRABLE,
	CONSTRAINT check_date_discharge CHECK date_discharge > date_admission),
	CONSTRAINT check_code CHECK (code LIKE 'IP%')
);

CREATE TABLE Examination(	
	SSN		CHAR(10)	PRIMARY KEY,
	examinationDate		DATE	NOT NULL,
	diagnosis	VARCHAR(15),
	nextExamination	DATE,
	fee		DECIMAL(10,2),
	Outpatient_code	VARCHAR(11),
	CONSTRAINT 	fk_Outpatient_code FOREIGN KEY (Outpatient_code)
				REFERENCES Outpatient(code) 
				ON DELETE SET NULL	DEFERRABLE,
	CONSTRAINT check_nextExamination CHECK (examinationDate	> nextExamination)
);

CREATE TABLE Medication(		
	code		VARCHAR(10)	PRIMARY KEY,
	name		VARCHAR(15)	UNIQUE,
	effect		VARCHAR(15),
	expirationDate	DATE,
	price		DECIMAL(10,2)
);


CREATE TABLE ImportedMedication(		
	code		VARCHAR(10)	PRIMARY KEY,
	quantity	DECIMAL(10),
	date		DATE,
	price		DECIMAL(10.2),
	CONSTRAINT 	fk_code FOREIGN KEY (code)
				REFERENCES Medication(code) 
				ON DELETE SET NULL	DEFERRABLE
);


CREATE TABLE Provider(		
	number		DECIMAL(10)	PRIMARY KEY,
	name		VARCHAR(15)	UNIQUE,
	address		VARCHAR(15),
	phone		VARCHAR(10)	UNIQUE
);

CREATE TABLE Detail(		
	Examination	VARCHAR(10)	PRIMARY KEY,
	Medication	VARCHAR(10)	PRIMARY KEY,
	CONSTRAINT 	fk_Examination FOREIGN KEY (Examination)
				REFERENCES Examination(SSN) 
				ON DELETE SET NULL	DEFERRABLE,
	CONSTRAINT 	fk_Medication FOREIGN KEY (Medication)
				REFERENCES Medication(code) 
				ON DELETE SET NULL	DEFERRABLE
);

CREATE TABLE Treat(		
	Doctor		VARCHAR(10)	PRIMARY KEY,
	Inpatient	VARCHAR(11)	PRIMARY KEY,
	Medication	VARCHAR(10)	PRIMARY KEY,
	CONSTRAINT 	fk_Doctor FOREIGN KEY (Doctor)
				REFERENCES Doctor(code) 
				ON DELETE SET NULL	DEFERRABLE,
	CONSTRAINT 	fk_Inpatient FOREIGN KEY (Inpatient)
				REFERENCES Inpatient(code) 
				ON DELETE SET NULL	DEFERRABLE,
	CONSTRAINT 	fk_Medication FOREIGN KEY (Medication)
				REFERENCES Medication(code) 
				ON DELETE SET NULL	DEFERRABLE
);

CREATE TABLE Provide(		
	Provider	DECIMAL(10)	PRIMARY KEY,
	Medication	VARCHAR(10)	PRIMARY KEY,
	CONSTRAINT 	fk_Provider FOREIGN KEY (Provider)
				REFERENCES Provider(number) 
				ON DELETE SET NULL	DEFERRABLE,
	CONSTRAINT 	fk_Medication FOREIGN KEY (Medication)
				REFERENCES Medication(code) 
				ON DELETE SET NULL	DEFERRABLE
);

-------------------------Insert data-----------------------------------------------------------------------------------------------------
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';


INSERT INTO Employee VALUES ('1231231234', 'John', 'Smith', '09-01-1965', 'M', '791 Weston', '12-03-1999', 'Medical genetics', 6, 'D101');
INSERT INTO Employee VALUES ('1231231235', 'William', 'William', '12-04-1976', 'M', '26 Hamiton', '01-01-1989', 'Family healthcare', 4, 'D102');
INSERT INTO Employee VALUES ('1231231236', 'Sam', 'Liang', '03-04-1978', 'F', '233 Red', '02-09-2000', 'Dermatology', 8, 'D111');
INSERT INTO Employee VALUES ('2231231234', 'Rogger', 'Johson', '23-10-1995', 'M', '45 F road', '23-10-2022', 'Anesthesiology', 8, 'D102');
INSERT INTO Employee VALUES ('1234231234', 'Forger', 'Robbert', '08-11-2000', 'M', '21 Luccy', '23-10-2022', 'Family healthcare', 5, 'D112');

INSERT INTO Doctor VALUES ('1231231234');
INSERT INTO Doctor VALUES ('1231231235');
INSERT INTO Doctor VALUES ('1231231236');

INSERT INTO Nurse VALUES ('2231231234');
INSERT INTO Nurse VALUES ('1234231234');

INSERT INTO PhoneNumber VALUES ('1231231234', '0909765321');
INSERT INTO PhoneNumber VALUES ('1231231234', '0944765321');
INSERT INTO PhoneNumber VALUES ('1231231235', '0906765329');
INSERT INTO PhoneNumber VALUES ('1231231236', '0909722881');
INSERT INTO PhoneNumber VALUES ('1231231236', '0202722881');
INSERT INTO PhoneNumber VALUES ('1231231236', '0203722881');
INSERT INTO PhoneNumber VALUES ('2231231234', '0909765321');
INSERT INTO PhoneNumber VALUES ('1234231234', '0342765321');

INSERT INTO Department VALUES ('D101', 'Medical genetics', '1231231234');
INSERT INTO Department VALUES ('D102', 'Anesthesiology', '2231231234');
INSERT INTO Department VALUES ('D111', 'Dermatology', '1231231236');
INSERT INTO Department VALUES ('D112', 'Family support', '1234231234');

INSERT INTO Patient VALUES ('2022121212', 'Lung', 'Lee', '12-12-2002', '33 Sun road', 'M', '0101212311');
INSERT INTO Patient VALUES ('2022121211', 'Geoung', 'Jin', '02-08-1996', '22 Gimiung', 'M', '0865167853' );
INSERT INTO Patient VALUES ('2022111212', 'Sala', 'Boly', '11-11-2005', '33 Black', 'F', '022212311' );
INSERT INTO Patient VALUES ('2022211212', 'Horono', 'Bill', '22-12-1965', '33 White', 'M', '0101212300' );
INSERT INTO Patient VALUES ('2000021212', 'Chamelos', 'Kim', '09-09-2001', '33 Hillstone', 'F', '0101212011' );
INSERT INTO Patient VALUES ('2020201212', 'Hana', 'Johnson', '31-12-1976', '33 Hillstone, 'F', '0101218311' );
INSERT INTO Patient VALUES ('0122121212', 'Sily', 'Bento', '23-04-1977', '01 Sun road', 'M', '0101217311' );

INSERT INTO Outpatient VALUES ('2022121212', '1231231235');
INSERT INTO Outpatient VALUES ('2022111212', '1231231235');
INSERT INTO Outpatient VALUES ('2022211212', '1231231234');
INSERT INTO Outpatient VALUES ('0122121212', '1231231235');

INSERT INTO Inpatient VALUES ('2022121211', '12-09-2021', 100.02, '303', 'no', '11-11-2021', '1234231234');
INSERT INTO Inpatient VALUES ('2000021212', '21-02-2022', 1200.23, '303', 'no', '01-05-2022', '1234231234');
INSERT INTO Inpatient VALUES ('2020201212', '31-10-2005', 123, '303', 'no', '29-01-2006', '1234231234');

INSERT INTO Examination VALUES ('1231241234','12-01-2021','no', '12-02-2021', 100.02, '2022111212');
INSERT INTO Examination VALUES ('1231241235','24-01-2022','no', '27-01-2022', 99.02, '2022121212');
INSERT INTO Examination VALUES ('1231241236','12-01-2021','no', '12-02-2021', 99.02, '2022211212');
INSERT INTO Examination VALUES ('1231241237','20-08-2020','no', '27-09-2020', 99.02, '0122121212');
INSERT INTO Examination VALUES ('1231241238','12-02-2021','no', '', 100.02, '2022111212');

INSERT INTO Medication VALUES ('2110201212', 'Vitanmin C','no','12-09-2024', 20);
INSERT INTO Medication VALUES ('2110201215', 'Vitanmin A','no','12-09-2024', 40);
INSERT INTO Medication VALUES ('2110201252', 'Canxi','no','12-09-2024', 20);
INSERT INTO Medication VALUES ('2110201051', 'Ion','no','12-09-2024', 20);

INSERT INTO ImportedMedication VALUES ('2110201215', 10, 12-01-2019, 40);

INSERT INTO Provider VALUES ('2110201212','Panda', '123 Hillstone', '0123456678');
INSERT INTO Provider VALUES ('2110201232','Banda', '123 Hillstone', '0123456677');
INSERT INTO Provider VALUES ('2110201032','Ada', '1 Bstone', '0323456677');


INSERT INTO Detail VALUES ('1231241234','2110201212');
INSERT INTO Detail VALUES ('1231241234','2110201215');
INSERT INTO Detail VALUES ('1231241234','2110201252');
INSERT INTO Detail VALUES ('1231241235','2110201252');
INSERT INTO Detail VALUES ('1231241236','2110201252');
INSERT INTO Detail VALUES ('1231241237','2110201215');
INSERT INTO Detail VALUES ('1231241238','2110201252');

INSERT INTO Treat VALUES ('1231231234', '2022121211', '2110201252');
INSERT INTO Treat VALUES ('1231231234', '2022121211', '2110201051');
INSERT INTO Treat VALUES ('1231231235', '2022121211', '2110201051');
INSERT INTO Treat VALUES ('1231231234', '2020201212', '2110201215');
INSERT INTO Treat VALUES ('1231231234', '2000021212', '2110201215');

INSERT INTO Provide VALUES ('2110201212','2110201212');
INSERT INTO Provide VALUES ('2110201212','2110201051');
INSERT INTO Provide VALUES ('2110201232','2110201212');
INSERT INTO Provide VALUES ('2110201212','2110201215');
INSERT INTO Provide VALUES ('2110201232','2110201252');
-------------------------Constraints-----------------------------------------------------------------------------------------------------
ALTER TABLE Department ADD deanyear int;
ALTER TABLE Department ADD CONSTRAINT check_year CHECK (deanyear> 5);

CREATE TRIGGER check_expiration
AFTER INSERT OR UPDATE OF code, expirationDate
ON Medication
FOR EACH ROW
WHEN (EXISTS (SELECT * 
		FROM Medication
		WHERE expirationDate - to_date(current_date) >0 ))
	