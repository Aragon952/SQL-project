CREATE TABLE p_angajati
(id_angajat NUMBER(3) CONSTRAINT pk_p_angajati PRIMARY KEY,
nume_angajat VARCHAR2(30) NOT NULL,
prenume_angajat VARCHAR2(30) NOT NULL,
data_angajare DATE,
functie VARCHAR2(10)
);
ALTER TABLE p_angajati 
MODIFY functie VARCHAR2(30);

CREATE TABLE p_vehicule 
(id_masina NUMBER(2) CONSTRAINT pk_p_vehicule PRIMARY KEY,
model_masina VARCHAR2(20) NOT NULL,
an_fabricare DATE,
kilometraj NUMBER(8)
);

CREATE TABLE p_depozite
(id_depozit NUMBER(2) CONSTRAINT pk_p_depozite PRIMARY KEY,
denumire_depozit VARCHAR2(20),
numar_angajati NUMBER(3)
);

CREATE TABLE p_comenzi 
(id_comanda NUMBER(3) CONSTRAINT pk_p_comenzi PRIMARY KEY,
data_comanda DATE,
modalitate VARCHAR2(6), CONSTRAINT ck_p_modalitate CHECK (modalitate IN ('fizic' , 'online')),
stare_comanda VARCHAR2(7),CONSTRAINT ck_p_comanda CHECK (stare_comanda IN('livrat', 'nelivrat'))
);

CREATE TABLE p_orase
(id_oras NUMBER(2) CONSTRAINT pk_p_orase PRIMARY KEY,
nume_oras VARCHAR2(20) NOT NULL,
stare_depozit VARCHAR2(10), CONSTRAINT ch_p_stare CHECK (stare_depozit IN ('existent', 'neexistent')),
numar_comenzi NUMBER(3)
);
ALTER TABLE p_orase
DROP CONSTRAINT ch_p_stare;
ALTER TABLE p_orase
ADD CONSTRAINT ch_p_stare CHECK (stare_depozit IN ('existent', 'inexistent'));

CREATE TABLE p_clienti
(id_client NUMBER(3) CONSTRAINT pk_p_clienti PRIMARY KEY,
nume_client VARCHAR2(30) NOT NULL,
prenume_client VARCHAR2(30) NOT NULL,
telefon VARCHAR2(20),
email_client VARCHAR2(50)
);

ALTER TABLE p_vehicule
ADD (id_angajat NUMBER(3), CONSTRAINT fk_angajati FOREIGN KEY (id_angajat) REFERENCES angajati(id_angajat));
ALTER TABLE p_vehicule
DROP CONSTRAINT fk_angajati;
ALTER TABLE p_vehicule
DROP COLUMN id_angajat;
ALTER TABLE p_vehicule
DROP COLUMN an_fabricare;
ALTER TABLE p_vehicule
ADD (an_fabricare VARCHAR2(4));

ALTER TABLE p_depozite
ADD (id_oras NUMBER(2), CONSTRAINT fk_oras FOREIGN KEY (id_oras) REFERENCES p_orase(id_oras));
ALTER TABLE p_depozite
DROP CONSTRAINT fk_oras;
ALTER TABLE p_depozite
DROP COLUMN id_oras;
ALTER TABLE p_depozite
ADD (id_oras NUMBER(2), CONSTRAINT fk_oras_depozit FOREIGN KEY (id_oras) REFERENCES p_orase(id_oras));

ALTER TABLE p_comenzi
ADD (id_depozit NUMBER(2), CONSTRAINT fk_depozit FOREIGN KEY (id_depozit) REFERENCES p_depozite(id_depozit));
ALTER TABLE p_comenzi
ADD(id_client NUMBER(2), CONSTRAINT fk_comenzi_client FOREIGN KEY (id_client) REFERENCES p_clienti(id_client));
ALTER TABLE p_comenzi
MODIFY stare_comanda VARCHAR2(8);
ALTER TABLE p_comenzi
DROP COLUMN id_depozit;
ALTER TABLE p_comenzi
DROP COLUMN id_client;

ALTER TABLE p_clienti
ADD (id_comanda NUMBER(2), CONSTRAINT fk_comenzi FOREIGN KEY (id_comanda) REFERENCES p_comenzi(id_comanda));
ALTER TABLE p_clienti
DROP COLUMN id_comanda;
ALTER TABLE p_clienti
ADD (id_oras NUMBER(2), CONSTRAINT fk_oras_client FOREIGN KEY (id_oras) REFERENCES p_orase(id_oras));

ALTER TABLE p_vehicule
ADD (id_depozit NUMBER(2), CONSTRAINT fk_depozit_masina FOREIGN KEY (id_depozit) REFERENCES p_depozite(id_depozit));

ALTER TABLE p_angajati
ADD (salariul NUMBER(6) NOT NULL);
ALTER TABLE p_angajati 
MODIFY functie VARCHAR2(30);
ALTER TABLE p_angajati
ADD (id_masina NUMBER(2), CONSTRAINT fk_masini FOREIGN KEY (id_masina) REFERENCES p_vehicule(id_masina));


INSERT INTO p_orase
VALUES(1, 'Bucuresti', 'existent', 15);
INSERT INTO p_orase
VALUES(2, 'Braila', 'existent', 10);
INSERT INTO p_orase
VALUES(3, 'Brasov', 'inexistent', 10);
INSERT INTO p_orase
VALUES(4, 'Timisoara', 'inexistent', 20);
INSERT INTO p_orase
VALUES(5, 'Brasov', 'inexistent', 10);
DELETE FROM p_orase
WHERE id_oras = 5;
INSERT INTO p_orase
VALUES(5, 'Iasi', 'existent', 15);
INSERT INTO p_orase
VALUES(6, 'Cluj', 'existent', 10);
INSERT INTO p_orase
VALUES(7, 'Craiova', 'inexistent', 10);
INSERT INTO p_orase
VALUES(8, 'Constanta', 'existent', 10);
INSERT INTO p_orase
VALUES(9, 'Oradea', 'inexistent', 10);
INSERT INTO p_orase
VALUES(10, 'Targu Jiu', 'inexistent', 10);

UPDATE  p_orase
SET nume_oras = 'Buzau'
WHERE id_oras = 3;
UPDATE  p_orase
SET nume_oras = 'Mangalia'
WHERE id_oras = 4;
UPDATE  p_orase
SET nume_oras = 'Targu Mures'
WHERE id_oras = 10;
UPDATE  p_orase
SET nume_oras = 'Cluj-Napoca'
WHERE id_oras = 6;
UPDATE  p_orase
SET nume_oras = 'Bacau'
WHERE id_oras = 9;

ALTER TABLE p_angajati
ADD (id_manager NUMBER (2));

UPDATE p_angajati
SET id_manager = 1
WHERE id_angajat IN (SELECT id_angajat FROM p_angajati WHERE UPPER(functie) LIKE '%VALOARE%');

UPDATE p_angajati
SET id_manager = 2
WHERE id_angajat IN (12, 13);
UPDATE p_angajati
SET id_manager = 3
WHERE id_angajat IN (14, 15);
UPDATE p_angajati
SET id_manager = 4
WHERE id_angajat IN (16, 17);
UPDATE p_angajati
SET id_manager = 5
WHERE id_angajat IN (18, 19);
UPDATE p_angajati
SET id_manager = 6
WHERE id_angajat IN (20, 21);
UPDATE p_angajati
SET id_manager = 7
WHERE id_angajat IN (22, 23);
UPDATE p_angajati
SET id_manager = 8
WHERE id_angajat IN (24, 25);
UPDATE p_angajati
SET id_manager = 9
WHERE id_angajat IN (26, 27);
UPDATE p_angajati
SET id_manager = 10
WHERE id_angajat IN (28, 29);
UPDATE p_angajati
SET id_manager = 11
WHERE id_angajat IN (30, 31);

UPDATE p_angajati
SET id_manager = NULL
WHERE id_angajat = 1;

INSERT INTO p_depozite
VALUES(1, 'Bucuresti', 5, 1);
INSERT INTO p_depozite
VALUES(2, 'Braila', 5, 2);
INSERT INTO p_depozite
VALUES(3, 'Iasi', 10, 5);
INSERT INTO p_depozite
VALUES(4, 'Cluj', 7, 6);
INSERT INTO p_depozite
VALUES(5, 'Constanta', 15, 8);
INSERT INTO p_depozite
VALUES(6, 'depozit6', NULL, NULL);
INSERT INTO p_depozite
VALUES(7, 'depozit7', NULL, NULL);
INSERT INTO p_depozite
VALUES(8, 'depozit8', NULL, NULL);
INSERT INTO p_depozite
VALUES(9, 'depozit9', NULL, NULL);
INSERT INTO p_depozite
VALUES(10, 'depozit10', NULL, NULL);

INSERT INTO p_vehicule
VALUES(1, 'Audi A6', 5000, 1, '2021');
INSERT INTO p_vehicule
VALUES(2, 'Dacia Logan', 45000, 1, '2018');
INSERT INTO p_vehicule
VALUES(3, 'Dacia Logan', 37000, 2, '2018');
INSERT INTO p_vehicule
VALUES(4, 'Dacia Logan', 22000, 3, '2020');
INSERT INTO p_vehicule
VALUES(5, 'Dacia Logan', 100000, 4, '2015');
INSERT INTO p_vehicule
VALUES(6, 'Dacia Logan', 83000, 5, '2016');
INSERT INTO p_vehicule
VALUES(7, 'Ford Transit', 69000, 1, '2017');
INSERT INTO p_vehicule
VALUES(8, 'Ford Transit', 12000, 1, '2021');
INSERT INTO p_vehicule
VALUES(9, 'Ford Transit', 55000, 2, '2018');
INSERT INTO p_vehicule
VALUES(10, 'Ford Transit', 105000, 2, '2015');
INSERT INTO p_vehicule
VALUES(11, 'Ford Transit', 42000, 3, '2018');
INSERT INTO p_vehicule
VALUES(12, 'Ford Transit', 57000, 3, '2018');
INSERT INTO p_vehicule
VALUES(13, 'Ford Transit', 85000, 4, '2016');
INSERT INTO p_vehicule
VALUES(14, 'Ford Transit', 31000, 4, '2019');
INSERT INTO p_vehicule
VALUES(15, 'Ford Transit', 78000, 5, '2017');
INSERT INTO p_vehicule
VALUES(16, 'Ford Transit', 25000, 5, '2020');
SELECT * FROM P_VEHICULE;

INSERT INTO p_angajati
VALUES(1, 'Petrov', 'Mihai', TO_DATE('14-09-2002','DD-MM-YYYY'),'Manager',1,150000);
INSERT INTO p_angajati
VALUES(2, 'Steven', 'King', TO_DATE('19-06-2008','DD-MM-YYYY'),'Sofer obiecte valoare',2,50000);
INSERT INTO p_angajati
VALUES(3, 'Neena', 'Kochhar', TO_DATE('26-01-2009','DD-MM-YYYY'),'Sofer obiecte valoare',2,45000);
INSERT INTO p_angajati
VALUES(4, 'Lex', 'De Haan', TO_DATE('27-06-2007','DD-MM-YYYY'),'Sofer obiecte valoare',3,60000);
INSERT INTO p_angajati
VALUES(5, 'Alexander', 'Hunold', TO_DATE('28-03-2008','DD-MM-YYYY'),'Sofer obiecte valoare',3,54000);
INSERT INTO p_angajati
VALUES(6, 'Bruce', 'Ernst', TO_DATE('29-01-2008','DD-MM-YYYY'),'Sofer obiecte valoare',4,58000);
INSERT INTO p_angajati
VALUES(7, 'David', 'Austin', TO_DATE('30-03-2009','DD-MM-YYYY'),'Sofer obiecte valoare',4,44000);
INSERT INTO p_angajati
VALUES(8, 'Valli', 'Pataballa', TO_DATE('18-01-2009','DD-MM-YYYY'),'Sofer obiecte valoare',5,42000);
INSERT INTO p_angajati
VALUES(9, 'Diana', 'Lorentz', TO_DATE('01-09-2008','DD-MM-YYYY'),'Sofer obiecte valoare',5,48000);
INSERT INTO p_angajati
VALUES(10, 'Nancy', 'Greenberg', TO_DATE('03-05-2008','DD-MM-YYYY'),'Sofer obiecte valoare',6,51000);
INSERT INTO p_angajati
VALUES(11, 'Daniel', 'Faviet', TO_DATE('04-04-2008','DD-MM-YYYY'),'Sofer obiecte valoare',6,53000);
INSERT INTO p_angajati
VALUES(12,'John', 'Chen', TO_DATE('05-06-2013','DD-MM-YYYY'),'Sofer obiecte normale',7,30000);
INSERT INTO p_angajati
VALUES(13, 'Ismael', 'Sciarra', TO_DATE('06-04-2016','DD-MM-YYYY'),'Sofer obiecte normale',7,16000);
INSERT INTO p_angajati
VALUES(14, 'Luis', 'Popp', TO_DATE('07-12-2015','DD-MM-YYYY'),'Sofer obiecte normale',8,18000);
INSERT INTO p_angajati
VALUES(15, 'Den', 'Raphaely', TO_DATE('08-10-2015','DD-MM-YYYY'),'Sofer obiecte normale',8,19000);
INSERT INTO p_angajati
VALUES(16, 'Alexander', 'Khoo', TO_DATE('09-06-2015','DD-MM-YYYY'),'Sofer obiecte normale',9,21000);
INSERT INTO p_angajati
VALUES(17, 'Shelli', 'Baida', TO_DATE('10-02-2015','DD-MM-YYYY'),'Sofer obiecte normale',9,22500);
INSERT INTO p_angajati
VALUES(18, 'Sigal', 'Tobias', TO_DATE('11-12-2013','DD-MM-YYYY'),'Sofer obiecte normale',10,28000);
INSERT INTO p_angajati
VALUES(19, 'Guy', 'Himuro', TO_DATE('12-06-2014','DD-MM-YYYY'),'Sofer obiecte normale',10,25000);
INSERT INTO p_angajati
VALUES(20, 'Karen', 'Colmenares', TO_DATE('13-09-2013','DD-MM-YYYY'),'Sofer obiecte normale',11,29000);
INSERT INTO p_angajati
VALUES(21, 'Matthew', 'Weiss', TO_DATE('15-03-2013','DD-MM-YYYY'),'Sofer obiecte normale',11,31000);
INSERT INTO p_angajati
VALUES(22, 'Adam', 'Fripp', TO_DATE('16-10-2012','DD-MM-YYYY'),'Sofer obiecte normale',12,33000);
INSERT INTO p_angajati
VALUES(23, 'Payam', 'Kaufling', TO_DATE('17-01-2012','DD-MM-YYYY'),'Sofer obiecte normale',12,36000);
INSERT INTO p_angajati
VALUES(24, 'Shanta', 'Vollman', TO_DATE('18-02-2012','DD-MM-YYYY'),'Sofer obiecte normale',13,35500);
INSERT INTO p_angajati
VALUES(25, 'Kevin', 'Mourgos', TO_DATE('19-08-2011','DD-MM-YYYY'),'Sofer obiecte normale',13,38000);
INSERT INTO p_angajati
VALUES(26, 'Julia', 'Nayer', TO_DATE('20-01-2011','DD-MM-YYYY'),'Sofer obiecte normale',14,42000);
INSERT INTO p_angajati
VALUES(27, 'James', 'Landry', TO_DATE('21-07-2011','DD-MM-YYYY'),'Sofer obiecte normale',14,37200);
INSERT INTO p_angajati
VALUES(28, 'Steven', 'Markle', TO_DATE('22-01-2013','DD-MM-YYYY'),'Sofer obiecte normale',15,32000);
INSERT INTO p_angajati
VALUES(29, 'Laura', 'Bissot', TO_DATE('23-11-2011','DD-MM-YYYY'),'Sofer obiecte normale',15,36600);
INSERT INTO p_angajati
VALUES(30, 'Mozhe', 'Atkinson', TO_DATE('24-05-2013','DD-MM-YYYY'),'Sofer obiecte normale',16,30500);
INSERT INTO p_angajati
VALUES(31, 'Jason', 'Mallin', TO_DATE('25-05-2012','DD-MM-YYYY'),'Sofer obiecte normale',16,34000);



INSERT INTO p_clienti
VALUES(1,'Buster', 'Edwards','0711223344','jason.steven',1);
INSERT INTO p_clienti
VALUES(2,'Daniel', 'Gueney','6597002895','daniel.gueney',1);
INSERT INTO p_clienti
VALUES(3,'Farrah', 'Lange','3069645454','farrah.lange',1);
INSERT INTO p_clienti
VALUES(4,'Hal', 'Stockwell','5040006174','hal.stockwell',2);
INSERT INTO p_clienti
VALUES(5,'Malcolm', 'Kanth','1400871705','malcolm.kanth',2);
INSERT INTO p_clienti
VALUES(6,'Malcolm', 'Broderick','8124353616','malcolm.broderick',2);
INSERT INTO p_clienti
VALUES(7,'Mary', 'Lemmon','7315272906','mary.lemmon',3);
INSERT INTO p_clienti
VALUES(8,'Matt', 'Gueney','5519658596','matt.gueney',3);
INSERT INTO p_clienti
VALUES(9,'Max', 'Schell','8111268619','max.schell',3);
INSERT INTO p_clienti
VALUES(10,'Cynda', 'Whitcraft','1415864172','cynda.whitcraft',4);
INSERT INTO p_clienti
VALUES(11,'Donald', 'Minnelli','2903643519','donald.minnelli',4);
INSERT INTO p_clienti
VALUES(12,'Hannah', 'Broderick','8151306924','hannah.brorderick',4);
INSERT INTO p_clienti
VALUES(13,'Dan', 'Williams','1483890714','dan.williams',5);
INSERT INTO p_clienti
VALUES(14,'Raul', 'Wilder','2316371516','raul.wilder',5);
INSERT INTO p_clienti
VALUES(15,'Sally', 'Bogart','0589844987','sally.bogart',5);
INSERT INTO p_clienti
VALUES(16,'Bruce', 'Bates','4613437978','bruce.bates',6);
INSERT INTO p_clienti
VALUES(17,'Brooke', 'Shepherd','0057168184','brooke.shepherd',6);
INSERT INTO p_clienti
VALUES(18,'Emmet', 'Walken','9347415899','emmet.walken',6);
INSERT INTO p_clienti
VALUES(19,'Ellen', 'Palin','9205019799','ellen.palin',7);
INSERT INTO p_clienti
VALUES(20,'Ellen', 'Khan','8259225233','ellen.khan',7);
INSERT INTO p_clienti
VALUES(21,'Fred', 'Reynolds','6755000863','fred.reynolds',7);
INSERT INTO p_clienti
VALUES(22, 'George', 'Adjani','0785477544','george.adjani',8);
INSERT INTO p_clienti
VALUES(23,'Irene', 'Laughton','6138683562','irene.laughton',8);
INSERT INTO p_clienti
VALUES(24,'Prem', 'Walken','2657203668','prem.walken',8);
INSERT INTO p_clienti
VALUES(25,'Alan','Walker','0943948159','alan.walker',9);
INSERT INTO p_clienti
VALUES(26,'Kyle', 'Schneider','4405264704','kyle.schneider',9);
INSERT INTO p_clienti
VALUES(27,'Shelley', 'Peckinpah','7373465022','shelley.peckinpah',9);
INSERT INTO p_clienti
VALUES(28,'Prem', 'Garcia','6500859077','prem.garcia',10);
INSERT INTO p_clienti
VALUES(29, 'Bob', 'McCarthy','6771574353','bob.mccarthy',10);
INSERT INTO p_clienti
VALUES(30,'Dom', 'Hoskins','9850930402','dom.hoskins',10);

CREATE SEQUENCE id_clienti_seq
START WITH 1 INCREMENT BY 1
MAXVALUE 60;
drop sequence id_clienti_seq;
Alter sequence id_clienti_seq   increment by 1;

INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 1, 1);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 2, 4);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 3, 13);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 4, 16);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 5, 22);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 1, 2);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 2, 5);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 3, 14);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 4, 17);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 5, 23);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 1, 3);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 2, 6);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 3, 15);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 4, 18);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','livrat', 5, 24);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 1, 1);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 2, 4);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 3, 13);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 4, 16);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 5, 22);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 1, 2);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 2, 5);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 3, 14);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 4, 17);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 5, 23);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 1, 3);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 2, 6);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 3, 15);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 4, 18);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'fizic','nelivrat', 5, 24);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 1, 19);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 2, 7);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 3, 25);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 4, 28);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 5, 10);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 1, 20);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 2, 8);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 3, 26);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 4, 29);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 5, 11);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 1, 21);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 2, 9);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 3, 27);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 4, 30);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','livrat', 5, 12);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 1, 19);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 2, 7);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 3, 25);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 4, 28);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 5, 10);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 1, 20);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 2, 8);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 3, 26);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 4, 29);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 5, 11);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 1, 21);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 2, 9);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 3, 27);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 4, 30);
INSERT INTO p_comenzi
VALUES(id_clienti_seq.NEXTVAL,TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2002-01-01','J'),TO_CHAR(DATE '2020-12-31','J'))),'J'), 'online','nelivrat', 5, 12);

COMMIT;

DELETE FROM p_comenzi;
SELECT * FROM p_comenzi;

DROP TABLE p_comenzi;
FLASHBACK TABLE p_comenzi TO BEFORE DROP;

SELECT * FROM p_angajati;


--SELECTATI id-ul angajatului, numele concatenat cu prenumele si salariul angajatilor cu salariul intre 25000 si 35000
SELECT id_angajat, nume_angajat || ' ' || prenume_angajat AS Nume, salariul
FROM p_angajati
WHERE salariul >= 25000 AND salariul <= 35000;

--1. Sa se afiseze angajatii si nivelul ierarhic al acestora pornind de la angajatul cu id-ul 1 (sa se ordoneze in functie de nivelul ierahic).
SELECT id_angajat, nume_angajat, id_manager, LEVEL 
FROM p_angajati
CONNECT BY PRIOR id_angajat= id_manager
START WITH id_angajat = 1;

-- Sa se afiseze toti superiorii lui Payam
SELECT id_angajat, nume_angajat, id_manager, LEVEL 
FROM p_angajati
CONNECT BY id_angajat= PRIOR id_manager
START WITH UPPER(nume_angajat) = 'PAYAM';

--Afisati angajatii companiei subordonati inregistrarii radacina sub forma de organigrama.
SELECT LEVEL, LPAD(' ', LEVEL)|| nume_angajat 
FROM p_angajati
CONNECT BY PRIOR id_angajat = id_manager
START WITH id_angajat= 1;

--Sa se afiseze angajatii si nivelul ierarhic al acestora pornind de la angajatul cu id-ul 1 (sa se ordoneze in functie de nivelul ierahic), al angajatilor care nu au fost angajati intre 2013 si 2015
SELECT id_angajat, nume_angajat, id_manager, LEVEL 
FROM p_angajati
WHERE data_angajare NOT BETWEEN TO_DATE('01-01-2013','DD-MM-YYYY') AND TO_DATE('31-DEC-2015','DD-MM-YYYY')
CONNECT BY PRIOR id_angajat = id_manager 
START WITH id_angajat = 1 
ORDER BY LEVEL;

--Sa se afiseze angajatii si comenzi cu care se ocupa sau s-au ocupat de aceste livrari
SELECT DISTINCT a.id_angajat, a.nume_angajat, c.id_comanda
FROM p_angajati a, p_comenzi c, p_vehicule v, p_depozite d
WHERE a.id_masina = v.id_masina
AND v.id_depozit =  d.id_depozit
AND d.id_depozit = c.id_depozit
AND id_angajat != 1;

--Sa se afiseze clientii si starea comenzilor acestora pentru comenzile mai vechi de 7 ani
SELECT c.id_client, c.nume_client || ' ' || c.prenume_client AS nume, co.stare_comanda
FROM p_clienti c, p_comenzi co
WHERE c.id_client = co.id_client 
AND 7 < (SELECT MONTHS_BETWEEN (SYSDATE, co.data_comanda) "MONTHS" FROM DUAL)/12;

--Sa se afiseze masina, kilometrajul si anul fabricarii vehiculelor fabricare minim in 2018 ordonate crescator
SELECT id_masina, model_masina, kilometraj, an_fabricare
FROM p_vehicule
WHERE TO_NUMBER(an_fabricare) >= 2018
ORDER BY kilometraj DESC ;

--Sa se afiseze kilometrajul mediu si numarul de vehicule grupate pe ani
SELECT an_fabricare, AVG(kilometraj), COUNT(id_masina)
FROM p_vehicule
WHERE TO_NUMBER(an_fabricare) = ANY (SELECT TO_NUMBER(an_fabricare) FROM p_vehicule)
GROUP BY an_fabricare;

--Se presupune ca intr-un an, kilometrajul fiecarei masini creste cu 6500km. Sa se afiseze valoare de baza si valoarea noua presupusa.
SELECT id_masina, model_masina, kilometraj as kilometraj_an_baza, kilometraj+6500 as kilometraj_final_estimat
FROM p_vehicule;

-- Sa se afiseze valoare de baza si valoarea noua presupusa folosind functia CASE a kilometrajului, presupunand ca masinile de tip Dacia parcurg inca 8000km, cele de tip Ford inca 5000km iar restul 3000km
SELECT id_masina, model_masina, kilometraj,
CASE 
    WHEN UPPER(model_masina) LIKE '%DACIA%' THEN 8000
    WHEN LOWER(model_masina) LIKE '%ford%' THEN 5000
    ELSE 3000 
END + kilometraj as kilometraj_estimat
FROM p_vehicule;

--Realizati cerinta anterioara folosind functia DECODE, pt masinile mai noi de 2018 
SELECT id_masina, model_masina, kilometraj,
DECODE(UPPER(model_masina), '%DACIA%', 8000, '%FORD%', 5000, 3000) +kilometraj as kilometraj_estimat
FROM p_vehicule
WHERE TO_NUMBER(SUBSTR(an_fabricare,3,2)) >=18; 


--Sa se afiseze orasul depozitelor, cat si depozitele care nu se afla in orase, plus numarul de angajati
SELECT d.id_depozit, d.numar_angajati, o.nume_oras
FROM p_depozite d, p_orase o 
WHERE d.id_oras = o.id_oras(+);

--Sa se realizeze operatia de modificare a kilometrajului cu 10% pentru toate masinile cu kilometrajul mai mic decat media anului 2019. Sa se anuleze operatia

UPDATE p_vehicule
SET kilometraj = kilometraj*1.1
WHERE kilometraj <= (SELECT AVG(kilometraj) FROM p_vehicule WHERE an_fabricare = TO_CHAR(2019) GROUP BY an_fabricare);
ROLLBACK;

-- Sa se afiseze numele si prenumele angajatilor cu o vechime de minim 10 ani si al tuturor clientilor 
SELECT nume_angajat || ' ' || prenume_angajat AS nume
FROM p_angajati
WHERE 10 < (SELECT MONTHS_BETWEEN (SYSDATE, data_angajare) "MONTHS" FROM DUAL)/12
UNION
SELECT nume_client || ' ' || prenume_client AS nume
FROM p_clienti;

--15

--1.	Sa realizeze o tabela virtuala cu toate masinile fabricate in 2018. Actualiz?m kilometrajul cu 20%

CREATE OR REPLACE VIEW v_vehicule_2018
AS SELECT * FROM p_vehicule
WHERE an_fabricare LIKE '2018';
UPDATE v_vehicule_2018
SET kilometraj = kilometraj*1.2;

-- Sa se realizeze o tabela virtuala cu datele personale ale angajatilor angajati in luna Martie care sa fie READ ONLY
CREATE OR REPLACE VIEW v_angajati_datepers
AS SELECT id_angajat, nume_angajat, prenume_angajat
FROM p_angajati
WHERE 3 = EXTRACT(MONTH FROM data_angajare)
WITH READ ONLY;

--Sa se afiseze clientii si comenzile acestora, si cu cate zile in urma au fost facute
SELECT c.id_client,c.nume_client, c.prenume_client, co.id_comanda, co.data_comanda, ROUND(SYSDATE - data_comanda) AS timp
FROM p_clienti c, p_comenzi co
WHERE c.id_client = co.id_client;

--Sa se afiseze toti subordonatii de pe nivelul 3:
SELECT id_angajat, nume_angajat, id_manager, LEVEL 
FROM p_angajati
WHERE LEVEL=3
CONNECT BY PRIOR id_angajat =  id_manager
ORDER BY LEVEL;

--Sa se afiseze superiorii angajatilor aflati pe ultimul nivel de subordonare:
SELECT nume_angajat, LEVEL-1 Numar_Superiori, SYS_CONNECT_BY_PATH(nume_angajat, '/') Nume_Superiori
FROM p_angajati
START WITH id_angajat = 1
CONNECT BY PRIOR id_angajat = id_manager 
ORDER BY LEVEL desc;

