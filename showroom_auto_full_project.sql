BEGIN EXECUTE IMMEDIATE 'DROP VIEW v_vanzari_complete';  EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP VIEW v_clienti_contact';   EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE seq_vanzari';     EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP INDEX index_metoda_plata'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP INDEX index_functie';      EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP SYNONYM clienti_showroom'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE SR_PLATI      CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE SR_TESTDRIVE  CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE SR_VANZARI    CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE SR_MASINI     CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE SR_ANGAJATI   CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE SR_CLIENTI    CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

CREATE TABLE SR_CLIENTI (
    id_client   NUMBER(10)   NOT NULL,
    nume        VARCHAR2(20) NOT NULL,
    prenume     VARCHAR2(25) NOT NULL,
    telefon     VARCHAR2(15),
    email       VARCHAR2(40)
);

CREATE TABLE SR_MASINI (
    id_masina     NUMBER(10)   NOT NULL,
    marca         VARCHAR2(20) NOT NULL,
    model         VARCHAR2(25) NOT NULL,
    an_fabricatie NUMBER(4)    NOT NULL,
    pret          NUMBER(10,2) NOT NULL,
    status        VARCHAR2(20) DEFAULT 'DISPONIBILA' NOT NULL
);

CREATE TABLE SR_ANGAJATI (
    id_angajat NUMBER(10)   NOT NULL,
    nume       VARCHAR2(40) NOT NULL,
    functie    VARCHAR2(20) NOT NULL,
    salariu    NUMBER(8,2)  NOT NULL
);

CREATE TABLE SR_VANZARI (
    id_vanzare   NUMBER(10)   NOT NULL,
    id_client    NUMBER(10)   NOT NULL,
    id_masina    NUMBER(10)   NOT NULL,
    id_angajat   NUMBER(10)   NOT NULL,
    data_vanzare DATE         NOT NULL,
    pret_final   NUMBER(10,2) NOT NULL
);

CREATE TABLE SR_TESTDRIVE (
    id_test   NUMBER(10)    NOT NULL,
    id_client NUMBER(10)    NOT NULL,
    id_masina NUMBER(10)    NOT NULL,
    data_test DATE          NOT NULL,
    feedback  VARCHAR2(200)
);

CREATE TABLE SR_PLATI (
    id_plata     NUMBER(10)   NOT NULL,
    id_vanzare   NUMBER(10)   NOT NULL,
    suma         NUMBER(10,2) NOT NULL,
    metoda_plata VARCHAR2(20) NOT NULL,
    data_plata   DATE         NOT NULL
);


ALTER TABLE SR_CLIENTI   ADD CONSTRAINT pk_sr_clienti   PRIMARY KEY (id_client);
ALTER TABLE SR_MASINI    ADD CONSTRAINT pk_sr_masini    PRIMARY KEY (id_masina);
ALTER TABLE SR_ANGAJATI  ADD CONSTRAINT pk_sr_angajati  PRIMARY KEY (id_angajat);
ALTER TABLE SR_VANZARI   ADD CONSTRAINT pk_sr_vanzari   PRIMARY KEY (id_vanzare);
ALTER TABLE SR_TESTDRIVE ADD CONSTRAINT pk_sr_testdrive PRIMARY KEY (id_test);
ALTER TABLE SR_PLATI     ADD CONSTRAINT pk_sr_plati     PRIMARY KEY (id_plata);


ALTER TABLE SR_VANZARI   ADD CONSTRAINT fk_vanz_client  FOREIGN KEY (id_client)  REFERENCES SR_CLIENTI(id_client);
ALTER TABLE SR_VANZARI   ADD CONSTRAINT fk_vanz_masina  FOREIGN KEY (id_masina)  REFERENCES SR_MASINI(id_masina);
ALTER TABLE SR_VANZARI   ADD CONSTRAINT fk_vanz_angajat FOREIGN KEY (id_angajat) REFERENCES SR_ANGAJATI(id_angajat);
ALTER TABLE SR_TESTDRIVE ADD CONSTRAINT fk_test_client  FOREIGN KEY (id_client)  REFERENCES SR_CLIENTI(id_client);
ALTER TABLE SR_TESTDRIVE ADD CONSTRAINT fk_test_masina  FOREIGN KEY (id_masina)  REFERENCES SR_MASINI(id_masina);
ALTER TABLE SR_PLATI     ADD CONSTRAINT fk_plata_vanzare FOREIGN KEY (id_vanzare) REFERENCES SR_VANZARI(id_vanzare);


ALTER TABLE SR_MASINI  ADD  CONSTRAINT ck_sr_masini_status CHECK (status IN ('DISPONIBILA','VANDUTA'));
ALTER TABLE SR_PLATI   ADD  CONSTRAINT ck_sr_plata_suma    CHECK (suma > 0);
ALTER TABLE SR_MASINI  ADD  CONSTRAINT ck_sr_masini_an     CHECK (an_fabricatie BETWEEN 1970 AND 2025);
ALTER TABLE SR_MASINI  ADD  CONSTRAINT uq_sr_masini        UNIQUE (marca, model, an_fabricatie);
ALTER TABLE SR_CLIENTI MODIFY email VARCHAR2(80);
ALTER TABLE SR_VANZARI MODIFY data_vanzare DEFAULT SYSDATE;


INSERT INTO SR_CLIENTI VALUES (1, 'Popescu',   'Andrei',   '0722110110', 'andrei.popescu@gmail.com');
INSERT INTO SR_CLIENTI VALUES (2, 'Ionescu',   'Mihai',    '0722220220', 'mihai.ionescu@gmail.com');
INSERT INTO SR_CLIENTI VALUES (3, 'Georgescu', 'Radu',     '0722330330', 'radu.georgescu@gmail.com');
INSERT INTO SR_CLIENTI VALUES (4, 'Dumitru',   'Alex',     '0722440440', 'alex.dumitru@gmail.com');
INSERT INTO SR_CLIENTI VALUES (5, 'Marin',     'Vlad',     '0722550550', 'vlad.marin@gmail.com');
INSERT INTO SR_CLIENTI VALUES (6, 'Stan',      'Ioana',    '0722660660', 'ioana.stan@gmail.com');
INSERT INTO SR_CLIENTI VALUES (7, 'Matei',     'Bianca',   '0722770770', 'bianca.matei@gmail.com');
INSERT INTO SR_CLIENTI VALUES (8, 'Petrescu',  'Daria',    '0722880880', 'daria.petrescu@gmail.com');
INSERT INTO SR_CLIENTI VALUES (9, 'Tudor',     'Cristian', '0722990990', 'cristian.tudor@gmail.com');
INSERT INTO SR_CLIENTI VALUES (10,'Ilie',      'Stefan',   '0722100100', 'stefan.ilie@gmail.com');
INSERT INTO SR_CLIENTI VALUES (11,'Radu',      'Cosmin',   '0722200200', 'cosmin.radu@gmail.com');
INSERT INTO SR_CLIENTI VALUES (12,'Enache',    'Laura',    '0722300300', 'laura.enache@gmail.com');
INSERT INTO SR_CLIENTI VALUES (99,'Pop',       'Rares',    '0712345678', 'rares.pop@gmail.com');


INSERT INTO SR_ANGAJATI VALUES (1,  'Rusu Ana',      'Agent Vanzari',      5200);
INSERT INTO SR_ANGAJATI VALUES (2,  'Morar Paul',    'Agent Vanzari',      4800);
INSERT INTO SR_ANGAJATI VALUES (3,  'Enache Sorin',  'Consilier Financiar',8200);
INSERT INTO SR_ANGAJATI VALUES (4,  'Badea Elena',   'Agent Vanzari',      4000);
INSERT INTO SR_ANGAJATI VALUES (5,  'Preda Iulian',  'Agent Vanzari',      5100);
INSERT INTO SR_ANGAJATI VALUES (6,  'Vasile Mara',   'Agent Vanzari',      4950);
INSERT INTO SR_ANGAJATI VALUES (7,  'Nita George',   'Consilier Financiar',7400);
INSERT INTO SR_ANGAJATI VALUES (8,  'Oprea Tudor',   'Agent Vanzari',      5300);
INSERT INTO SR_ANGAJATI VALUES (9,  'Lazar Ioan',    'Manager Showroom',   9600);
INSERT INTO SR_ANGAJATI VALUES (10, 'Dinca Alina',   'Agent Vanzari',      5350);
INSERT INTO SR_ANGAJATI VALUES (11, 'Popa Robert',   'Manager Showroom',   11260);
INSERT INTO SR_ANGAJATI VALUES (12, 'Iacob Diana',   'Consilier Financiar',8000);


INSERT INTO SR_MASINI VALUES (1,  'Dacia',      'Duster',  2021, 18000, 'DISPONIBILA');
INSERT INTO SR_MASINI VALUES (2,  'Dacia',      'Logan',   2020, 10500, 'VANDUTA');
INSERT INTO SR_MASINI VALUES (3,  'Volkswagen', 'Golf',    2019, 19000, 'DISPONIBILA');
INSERT INTO SR_MASINI VALUES (4,  'BMW',        '320d',    2018, 26300, 'VANDUTA');
INSERT INTO SR_MASINI VALUES (5,  'Audi',       'A4',      2017, 22900, 'DISPONIBILA');
INSERT INTO SR_MASINI VALUES (6,  'Toyota',     'Corolla', 2022, 18900, 'DISPONIBILA');
INSERT INTO SR_MASINI VALUES (7,  'Hyundai',    'i30',     2021, 15400, 'VANDUTA');
INSERT INTO SR_MASINI VALUES (8,  'Skoda',      'Octavia', 2020, 17200, 'DISPONIBILA');
INSERT INTO SR_MASINI VALUES (9,  'Mercedes',   'C200',    2019, 27900, 'DISPONIBILA');
INSERT INTO SR_MASINI VALUES (10, 'Ford',       'Focus',   2016, 12900, 'VANDUTA');
INSERT INTO SR_MASINI VALUES (11, 'Renault',    'Megane',  2006, 13900, 'DISPONIBILA');
INSERT INTO SR_MASINI VALUES (12, 'Mazda',      'CX5',     2021, 21500, 'DISPONIBILA');


INSERT INTO SR_VANZARI VALUES (1,  2,  2,  1,  DATE '2025-12-01', 10500);
INSERT INTO SR_VANZARI VALUES (2,  4,  4,  3,  DATE '2025-12-02', 26300);
INSERT INTO SR_VANZARI VALUES (3,  7,  7,  2,  DATE '2025-12-03', 15400);
INSERT INTO SR_VANZARI VALUES (4,  10, 10, 5,  DATE '2025-12-04', 12900);
INSERT INTO SR_VANZARI VALUES (5,  3,  1,  8,  DATE '2025-12-05', 18000);
INSERT INTO SR_VANZARI VALUES (6,  6,  3,  10, DATE '2025-12-06', 19000);
INSERT INTO SR_VANZARI VALUES (7,  9,  8,  6,  DATE '2025-12-07', 17200);
INSERT INTO SR_VANZARI VALUES (8,  1,  6,  1,  DATE '2025-12-08', 18900);
INSERT INTO SR_VANZARI VALUES (9,  5,  5,  9,  DATE '2025-12-09', 22900);
INSERT INTO SR_VANZARI VALUES (10, 8,  9,  3,  DATE '2025-12-10', 27900);
INSERT INTO SR_VANZARI VALUES (11, 11, 11, 12, DATE '2025-12-11', 13900);
INSERT INTO SR_VANZARI VALUES (12, 12, 12, 4,  DATE '2025-12-12', 21500);


INSERT INTO SR_TESTDRIVE VALUES (1,  1,  1,  DATE '2025-10-21', 'O masina fiabila');
INSERT INTO SR_TESTDRIVE VALUES (2,  3,  3,  DATE '2025-08-03', 'Consum prea mare');
INSERT INTO SR_TESTDRIVE VALUES (3,  5,  5,  DATE '2025-03-22', 'Confort premium');
INSERT INTO SR_TESTDRIVE VALUES (4,  6,  6,  DATE '2024-12-23', 'Foarte stabila, tehnologie de ultima generatie');
INSERT INTO SR_TESTDRIVE VALUES (5,  7,  8,  DATE '2021-04-24', 'Spatiu depozitare mare');
INSERT INTO SR_TESTDRIVE VALUES (6,  8,  9,  DATE '2023-07-25', 'Confort excelent');
INSERT INTO SR_TESTDRIVE VALUES (7,  2,  2,  DATE '2022-10-13', 'Potrivita pentru familisti');
INSERT INTO SR_TESTDRIVE VALUES (8,  4,  3,  DATE '2025-11-10', 'Directie precisa');
INSERT INTO SR_TESTDRIVE VALUES (9,  9,  10, DATE '2025-02-26', 'Buna de carat baloti');
INSERT INTO SR_TESTDRIVE VALUES (10, 10, 8,  DATE '2024-10-24', 'Buna la drum lung');
INSERT INTO SR_TESTDRIVE VALUES (11, 11, 11, DATE '2025-11-30', 'Design pe placul meu');
INSERT INTO SR_TESTDRIVE VALUES (12, 12, 12, DATE '2023-12-01', 'Putere buna');
INSERT INTO SR_TESTDRIVE VALUES (99, 99, 1,  DATE '2025-11-15', 'Test drive reusit');


INSERT INTO SR_PLATI VALUES (1,  1,  10500, 'CARD',     DATE '2023-10-01');
INSERT INTO SR_PLATI VALUES (2,  12, 21500, 'TRANSFER', DATE '2024-12-02');
INSERT INTO SR_PLATI VALUES (3,  2,  16000, 'TRANSFER', DATE '2025-08-10');
INSERT INTO SR_PLATI VALUES (4,  2,  14500, 'TRANSFER', DATE '2025-12-05');
INSERT INTO SR_PLATI VALUES (5,  3,  19900, 'CASH',     DATE '2025-12-03');
INSERT INTO SR_PLATI VALUES (6,  4,  22900, 'CARD',     DATE '2025-12-04');
INSERT INTO SR_PLATI VALUES (7,  4,  10500, 'TRANSFER', DATE '2025-12-06');
INSERT INTO SR_PLATI VALUES (8,  5,  18000, 'TRANSFER', DATE '2025-12-05');
INSERT INTO SR_PLATI VALUES (9,  6,  19500, 'CARD',     DATE '2025-12-06');
INSERT INTO SR_PLATI VALUES (10, 7,  17900, 'TRANSFER', DATE '2025-12-07');
INSERT INTO SR_PLATI VALUES (11, 8,  29500, 'TRANSFER', DATE '2025-12-08');
INSERT INTO SR_PLATI VALUES (12, 9,  27500, 'CARD',     DATE '2025-12-09');

COMMIT;



UPDATE SR_ANGAJATI SET salariu = salariu * 1.05 WHERE functie = 'Agent Vanzari';


UPDATE SR_PLATI SET metoda_plata = 'CARD' WHERE metoda_plata = 'CASH';


UPDATE SR_MASINI SET pret = pret * 1.1 WHERE an_fabricatie > 2018;


UPDATE SR_ANGAJATI SET functie = 'Manager Showroom' WHERE id_angajat = 3;

COMMIT;

CREATE OR REPLACE VIEW v_vanzari_complete AS
SELECT v.id_vanzare,
       c.nume || ' ' || c.prenume   AS client,
       m.marca || ' ' || m.model    AS masina,
       a.nume                        AS angajat,
       a.functie,
       v.data_vanzare,
       v.pret_final
FROM SR_VANZARI v
JOIN SR_CLIENTI  c ON c.id_client  = v.id_client
JOIN SR_MASINI   m ON m.id_masina  = v.id_masina
JOIN SR_ANGAJATI a ON a.id_angajat = v.id_angajat;


CREATE OR REPLACE VIEW v_clienti_contact AS
SELECT id_client, nume, prenume, telefon, email
FROM SR_CLIENTI
WHERE telefon IS NOT NULL AND email IS NOT NULL
WITH READ ONLY;

CREATE INDEX index_metoda_plata ON SR_PLATI(metoda_plata);

CREATE INDEX index_functie ON SR_ANGAJATI(UPPER(functie));

CREATE SEQUENCE seq_vanzari
    START WITH 1000
    INCREMENT BY 1
    MAXVALUE 9999
    NOCYCLE;

CREATE SYNONYM clienti_showroom FOR SR_CLIENTI;

SELECT 'SR_CLIENTI'  AS tabela, COUNT(*) AS nr_randuri FROM SR_CLIENTI  UNION ALL
SELECT 'SR_MASINI',              COUNT(*)               FROM SR_MASINI   UNION ALL
SELECT 'SR_ANGAJATI',            COUNT(*)               FROM SR_ANGAJATI UNION ALL
SELECT 'SR_VANZARI',             COUNT(*)               FROM SR_VANZARI  UNION ALL
SELECT 'SR_TESTDRIVE',           COUNT(*)               FROM SR_TESTDRIVE UNION ALL
SELECT 'SR_PLATI',               COUNT(*)               FROM SR_PLATI;

--cerinta C: structuri alt/rep
--1.
SET SERVEROUTPUT ON;

DECLARE
    v_id_masina SR_MASINI.id_masina%TYPE := &id_masina;
    v_marca     SR_MASINI.marca%TYPE;
    v_model     SR_MASINI.model%TYPE;
    v_pret      SR_MASINI.pret%TYPE;
    v_categorie VARCHAR2(40);
BEGIN
    SELECT marca, model, pret
    INTO v_marca, v_model, v_pret
    FROM SR_MASINI
    WHERE id_masina = v_id_masina;

    DBMS_OUTPUT.PUT_LINE('Masina selectata: ' || v_marca || ' ' || v_model);
    DBMS_OUTPUT.PUT_LINE('Pretul masinii este: ' || v_pret || ' lei');

    IF v_pret < 15000 THEN
        v_categorie := 'Masina accesibila';
    ELSIF v_pret BETWEEN 15000 AND 25000 THEN
        v_categorie := 'Masina medie';
    ELSE
        v_categorie := 'Masina premium';
    END IF;
    DBMS_OUTPUT.PUT_LINE('Categoria masinii este: ' || v_categorie);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista masina cu id-ul introdus: ' || v_id_masina);
END;
/

--2.
SET SERVEROUTPUT ON;
DECLARE
    v_pret_final SR_VANZARI.pret_final%TYPE;
    v_categorie VARCHAR2(30);
BEGIN
    FOR i in 1..12 LOOP
        SELECT pret_final
        INTO v_pret_final
        FROM SR_VANZARI
        WHERE id_vanzare = i;
        
        IF v_pret_final < 15000 THEN v_categorie := 'Vanzare mica';
        ELSIF v_pret_final BETWEEN 15000 AND 25000 THEN v_categorie := 'Vanzare medie';
        ELSE v_categorie := 'Vanzare mare';
        END IF;
        DBMS_OUTPUT.PUT_LINE('Vanzarea cu id-ul ' || i || ' are valoarea' || v_pret_final || ' lei si este clasificata ca: ' || v_categorie);
    END LOOP;
END;
/

--3.
SET SERVEROUTPUT ON;
DECLARE
    v_id_angajat SR_ANGAJATI.id_angajat%TYPE := 1;
    v_nume SR_ANGAJATI.nume%TYPE;
    v_functie SR_ANGAJATI.functie%TYPE;
    v_salariu SR_ANGAJATI.salariu%TYPE;
BEGIN
    WHILE v_id_angajat <=12 LOOP
        SELECT nume, functie, salariu INTO v_nume, v_functie, v_salariu
        FROM SR_ANGAJATI
        WHERE id_angajat = v_id_angajat;
    
        DBMS_OUTPUT.PUT_LINE('Angajatul cu id-ul ' || v_id_angajat || ': nume: ' || v_nume || ', functie: ' || v_functie || ', salariu: ' || v_salariu);
        EXIT WHEN v_salariu >= 9000;
        v_id_angajat := v_id_angajat +1;
    END LOOP;
END;
/

--4.
SET SERVEROUTPUT ON;
DECLARE
    v_id_masina SR_MASINI.id_masina%TYPE :=1;
    v_marca SR_MASINI.marca%TYPE;
    v_model SR_MASINI.model%TYPE;
    v_pret SR_MASINI.pret%TYPE;
    v_status SR_MASINI.status%TYPE;
BEGIN
    LOOP 
        SELECT id_masina, marca, model, pret, status
        INTO v_id_masina, v_marca, v_model, v_pret, v_status
        FROM SR_MASINI
        WHERE v_id_masina = id_masina;
        DBMS_OUTPUT.PUT_LINE('Masina cu id: ' || v_id_masina || ': marca: ' || v_marca || ', model: ' || v_model || ', pret: ' || v_pret || ', status: ' || v_status);
        v_id_masina := v_id_masina +1;
        EXIT WHEN v_id_masina > 12;
    END LOOP;
END;
/
    
--cerinta D: exceptii
--1. implicita 

SET SERVEROUTPUT ON;
DECLARE
    v_id_masina SR_MASINI.id_masina%TYPE := &id_masina;
    v_marca SR_MASINI.marca%TYPE;
    v_model SR_MASINI.model%TYPE;
    v_pret SR_MASINI.pret%TYPE;
BEGIN
    SELECT id_masina, marca, model, pret
    INTO v_id_masina, v_marca, v_model, v_pret
    FROM SR_MASINI
    WHERE id_masina = v_id_masina;
    DBMS_OUTPUT.PUT_LINE('Masina cu id: ' || v_id_masina || ': marca: ' || v_marca || ', model: ' || v_model || ', pret: ' || v_pret);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista nicio masina cu id-ul ' || v_id_masina);
END;
/

--2.implicita

SET SERVEROUTPUT ON;
BEGIN
    INSERT INTO SR_CLIENTI(id_client, nume, prenume, telefon, email)
    VALUES (1, 'Test', 'Client', '0700000000', 'test.client@gmail.com');
    DBMS_OUTPUT.PUT_LINE('Clientul a fost inserat cu succes!');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: exista deja un client cu acest id!');
END;
/

--3.explicita

SET SERVEROUTPUT ON;
DECLARE
    v_pret_nou NUMBER(10,2) := &pret_nou;
    pret_invalid EXCEPTION;
BEGIN
    IF v_pret_nou <= 0 THEN
        RAISE pret_invalid;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Pretul introdus este valid: ' || v_pret_nou || ' lei.');
    END IF;
EXCEPTION
    WHEN pret_invalid THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: pretul introdus nu poate fi <=0.');
END;
/

--4.explicita

SET SERVEROUTPUT ON;
DECLARE
    v_id_vanzare  SR_VANZARI.id_vanzare%TYPE := &id_vanzare;
    v_plata_noua  SR_PLATI.suma%TYPE := &plata_noua;
    v_pret_final  SR_VANZARI.pret_final%TYPE;
    v_total_plati NUMBER(10,2);
    v_rest        NUMBER(10,2);
    ex_plata_depaseste_rest EXCEPTION;
BEGIN
    SELECT pret_final
    INTO v_pret_final
    FROM SR_VANZARI
    WHERE id_vanzare = v_id_vanzare;

    SELECT NVL(SUM(suma), 0)
    INTO v_total_plati
    FROM SR_PLATI
    WHERE id_vanzare = v_id_vanzare;
    v_rest := v_pret_final - v_total_plati;
    DBMS_OUTPUT.PUT_LINE('Pret final vanzare: ' || v_pret_final);
    DBMS_OUTPUT.PUT_LINE('Total platit pana acum: ' || v_total_plati);
    DBMS_OUTPUT.PUT_LINE('Rest de plata: ' || v_rest);
    DBMS_OUTPUT.PUT_LINE('Plata introdusa: ' || v_plata_noua);

    IF v_plata_noua > v_rest THEN
        RAISE ex_plata_depaseste_rest;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Plata este valida si poate fi inregistrata.');
    END IF;

EXCEPTION
    WHEN ex_plata_depaseste_rest THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: plata introdusa depaseste restul de plata.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista vanzarea cu id-ul ' || v_id_vanzare);
END;
/ 

--cerinta E:cursori
--1.implicit

SET SERVEROUTPUT ON;
DECLARE
    v_nr_randuri NUMBER;
BEGIN
    UPDATE SR_MASINI
    SET pret = pret * 1.05
    WHERE status = 'DISPONIBILA';
    v_nr_randuri := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('Au fost actualizate ' || v_nr_randuri || ' masini disponibile.');
    ROLLBACK;
END;
/

--2. explicit fara param
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_masini_disponibile IS
        SELECT marca, model, pret
        FROM SR_MASINI
        WHERE status = 'DISPONIBILA'
        ORDER BY pret;
    v_marca SR_MASINI.marca%TYPE;
    v_model SR_MASINI.model%TYPE;
    v_pret  SR_MASINI.pret%TYPE;
BEGIN
    OPEN c_masini_disponibile;
    LOOP
        FETCH c_masini_disponibile
        INTO v_marca, v_model, v_pret;
        EXIT WHEN c_masini_disponibile%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
            'Masina disponibila: ' || v_marca || ' ' || v_model ||
            ', pret: ' || v_pret || ' lei'
        );
    END LOOP;
    CLOSE c_masini_disponibile;
END;
/

--3.explicit cu parametru
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_vanzari_angajat(p_id_angajat SR_ANGAJATI.id_angajat%TYPE) IS
        SELECT v.id_vanzare, c.nume || ' ' || c.prenume AS client, m.marca || ' ' || m.model AS masina, v.pret_final
        FROM SR_VANZARI v
        JOIN SR_CLIENTI c ON c.id_client = v.id_client
        JOIN SR_MASINI m ON m.id_masina = v.id_masina
        WHERE v.id_angajat = p_id_angajat
        ORDER BY v.pret_final DESC;
    v_id_angajat SR_ANGAJATI.id_angajat%TYPE := &id_angajat;
    v_id_vanzare SR_VANZARI.id_vanzare%TYPE;
    v_client     VARCHAR2(100);
    v_masina     VARCHAR2(100);
    v_pret_final SR_VANZARI.pret_final%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Vanzarile angajatului cu id-ul: ' || v_id_angajat);
    OPEN c_vanzari_angajat(v_id_angajat);
    LOOP
        FETCH c_vanzari_angajat
        INTO v_id_vanzare, v_client, v_masina, v_pret_final;
        EXIT WHEN c_vanzari_angajat%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Vanzare ID ' || v_id_vanzare || ' | Client: ' || v_client || ' | Masina: ' || v_masina || ' | Pret final: ' || v_pret_final || ' lei'
        );
    END LOOP;
    CLOSE c_vanzari_angajat;
END;
/

--4. cursor for loop
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_plati_card IS
        SELECT id_plata, id_vanzare, suma, metoda_plata, data_plata
        FROM SR_PLATI
        WHERE metoda_plata = 'CARD'
        ORDER BY suma DESC;
BEGIN
    FOR plata IN c_plati_card LOOP
        DBMS_OUTPUT.PUT_LINE('Plata ID ' || plata.id_plata || ' | Vanzare ID: ' || plata.id_vanzare || ' | Suma: ' || plata.suma || ' | Metoda: ' || plata.metoda_plata || ' | Data: ' || plata.data_plata);
    END LOOP;
END;
/

--cerinta F: functii, proceduri,pachete
--1.creare pachet

CREATE OR REPLACE PACKAGE package_showroom_sgbd AS
    FUNCTION f_total_platit(p_id_vanzare IN SR_VANZARI.id_vanzare%TYPE) RETURN NUMBER;

    FUNCTION f_rest_de_plata(p_id_vanzare IN SR_VANZARI.id_vanzare%TYPE) RETURN NUMBER;

    FUNCTION f_bonus_angajat(p_id_angajat IN SR_ANGAJATI.id_angajat%TYPE) RETURN NUMBER;

    PROCEDURE p_afiseaza_vanzari_angajat(p_id_angajat IN SR_ANGAJATI.id_angajat%TYPE);

    PROCEDURE p_modifica_pret_masina(p_id_masina IN SR_MASINI.id_masina%TYPE,p_procent IN NUMBER);
END package_showroom_sgbd;
/

--2.creare corp pachet
CREATE OR REPLACE PACKAGE BODY package_showroom_sgbd AS

    FUNCTION f_total_platit(p_id_vanzare IN SR_VANZARI.id_vanzare%TYPE) RETURN NUMBER
    IS
        v_total NUMBER(10,2);
    BEGIN
        SELECT NVL(SUM(suma), 0)
        INTO v_total
        FROM SR_PLATI
        WHERE id_vanzare = p_id_vanzare;

        RETURN v_total;
    END f_total_platit;


    FUNCTION f_rest_de_plata(p_id_vanzare IN SR_VANZARI.id_vanzare%TYPE) RETURN NUMBER
    IS
        v_pret_final SR_VANZARI.pret_final%TYPE;
        v_total_platit NUMBER(10,2);
        v_rest NUMBER(10,2);
    BEGIN
        SELECT pret_final
        INTO v_pret_final
        FROM SR_VANZARI
        WHERE id_vanzare = p_id_vanzare;

        v_total_platit := f_total_platit(p_id_vanzare);
        v_rest := v_pret_final - v_total_platit;

        RETURN v_rest;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END f_rest_de_plata;


    FUNCTION f_bonus_angajat(
        p_id_angajat IN SR_ANGAJATI.id_angajat%TYPE
    ) RETURN NUMBER
    IS
        v_salariu SR_ANGAJATI.salariu%TYPE;
        v_functie SR_ANGAJATI.functie%TYPE;
        v_total_vandut NUMBER(10,2);
        v_bonus NUMBER(10,2);
    BEGIN
        SELECT salariu, functie
        INTO v_salariu, v_functie
        FROM SR_ANGAJATI
        WHERE id_angajat = p_id_angajat;

        SELECT NVL(SUM(pret_final), 0)
        INTO v_total_vandut
        FROM SR_VANZARI
        WHERE id_angajat = p_id_angajat;

        IF v_functie = 'Manager Showroom' THEN
            v_bonus := v_salariu * 0.10 + v_total_vandut * 0.01;
        ELSIF v_functie = 'Consilier Financiar' THEN
            v_bonus := v_salariu * 0.08 + v_total_vandut * 0.005;
        ELSIF v_functie = 'Agent Vanzari' THEN
            v_bonus := v_salariu * 0.07 + v_total_vandut * 0.005;
        ELSE
            v_bonus := v_salariu * 0.05;
        END IF;

        RETURN ROUND(v_bonus, 2);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END f_bonus_angajat;


    PROCEDURE p_afiseaza_vanzari_angajat(
        p_id_angajat IN SR_ANGAJATI.id_angajat%TYPE
    )
    IS
        CURSOR c_vanzari IS
            SELECT v.id_vanzare, c.nume || ' ' || c.prenume AS client, m.marca || ' ' || m.model AS masina, v.pret_final
            FROM SR_VANZARI v
            JOIN SR_CLIENTI c ON c.id_client = v.id_client
            JOIN SR_MASINI m ON m.id_masina = v.id_masina
            WHERE v.id_angajat = p_id_angajat
            ORDER BY v.pret_final DESC;

        v_nr_vanzari NUMBER := 0;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Vanzarile angajatului cu id-ul ' || p_id_angajat || ':');

        FOR r IN c_vanzari LOOP
            v_nr_vanzari := v_nr_vanzari + 1;
            DBMS_OUTPUT.PUT_LINE('Vanzare ID ' || r.id_vanzare || ' | Client: ' || r.client || ' | Masina: ' || r.masina || ' | Pret final: ' || r.pret_final || ' lei');
        END LOOP;

        IF v_nr_vanzari = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Angajatul nu are vanzari inregistrate.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Numar total vanzari: ' || v_nr_vanzari);
        END IF;
    END p_afiseaza_vanzari_angajat;


    PROCEDURE p_modifica_pret_masina(p_id_masina IN SR_MASINI.id_masina%TYPE, p_procent IN NUMBER)
    IS
        v_pret_initial SR_MASINI.pret%TYPE;
        v_pret_nou SR_MASINI.pret%TYPE;
        ex_procent_invalid EXCEPTION;
    BEGIN
        IF p_procent <= -100 THEN
            RAISE ex_procent_invalid;
        END IF;

        SELECT pret
        INTO v_pret_initial
        FROM SR_MASINI
        WHERE id_masina = p_id_masina;

        UPDATE SR_MASINI
        SET pret = pret * (1 + p_procent / 100)
        WHERE id_masina = p_id_masina;
        
        SELECT pret
        INTO v_pret_nou
        FROM SR_MASINI
        WHERE id_masina = p_id_masina;
        DBMS_OUTPUT.PUT_LINE('Pret initial: ' || v_pret_initial || ' lei');
        DBMS_OUTPUT.PUT_LINE('Pret nou: ' || ROUND(v_pret_nou, 2) || ' lei');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista masina cu id-ul ' || p_id_masina);
        WHEN ex_procent_invalid THEN
            DBMS_OUTPUT.PUT_LINE('Procent invalid. Pretul nu poate fi redus cu 100% sau mai mult.');
    END p_modifica_pret_masina;
END package_showroom_sgbd;
/

--3.testare functii
--3.1.
SELECT id_vanzare, package_showroom_sgbd.f_total_platit(id_vanzare) AS total_platit
FROM SR_VANZARI
ORDER BY id_vanzare;

--3.2.
SELECT id_vanzare, pret_final, package_showroom_sgbd.f_total_platit(id_vanzare) AS total_platit, package_showroom_sgbd.f_rest_de_plata(id_vanzare) AS rest_de_plata
FROM SR_VANZARI
ORDER BY id_vanzare;

--3.3
SELECT id_angajat, nume, functie, salariu, package_showroom_sgbd.f_bonus_angajat(id_angajat) AS bonus_estimat
FROM SR_ANGAJATI
ORDER BY bonus_estimat DESC;

--4.testare proceduri
--4.1
SET SERVEROUTPUT ON;
BEGIN
    package_showroom_sgbd.p_afiseaza_vanzari_angajat(1);
END;
/

--4.2
SET SERVEROUTPUT ON;
BEGIN
    package_showroom_sgbd.p_modifica_pret_masina(1, 10);
END;
/

--5.verificare existenta pachet
SELECT object_name, object_type, status
FROM user_objects
WHERE object_name = 'PACKAGE_SHOWROOM_SGBD';


--Cerinta G: triggeri
--1
CREATE OR REPLACE TRIGGER trg_status_masina_vanduta
AFTER INSERT ON SR_VANZARI
FOR EACH ROW
BEGIN
    UPDATE SR_MASINI
    SET status = 'VANDUTA'
    WHERE id_masina = :NEW.id_masina;
END;
/

SELECT id_masina, marca, model, status
FROM SR_MASINI
WHERE status = 'DISPONIBILA';
INSERT INTO SR_VANZARI
(id_vanzare, id_client, id_masina, id_angajat, data_vanzare, pret_final)
VALUES
(9001, 1, 1, 1, SYSDATE, 18000);
SELECT id_masina, marca, model, status
FROM SR_MASINI
WHERE id_masina = 1;
ROLLBACK;

--2.
CREATE OR REPLACE TRIGGER trg_verifica_suma_plata
BEFORE INSERT ON SR_PLATI
FOR EACH ROW
DECLARE
    v_pret_final  SR_VANZARI.pret_final%TYPE;
    v_total_plati NUMBER(10,2);
    v_rest        NUMBER(10,2);
BEGIN
    SELECT pret_final
    INTO v_pret_final
    FROM SR_VANZARI
    WHERE id_vanzare = :NEW.id_vanzare;

    SELECT NVL(SUM(suma), 0)
    INTO v_total_plati
    FROM SR_PLATI
    WHERE id_vanzare = :NEW.id_vanzare;

    v_rest := v_pret_final - v_total_plati;
    IF :NEW.suma > v_rest THEN RAISE_APPLICATION_ERROR(-20001, 'Suma introdusa depaseste restul de plata pentru aceasta vanzare.');
    END IF;
END;
/

SELECT 
    v.id_vanzare,
    v.pret_final,
    NVL(SUM(p.suma), 0) AS total_platit,
    v.pret_final - NVL(SUM(p.suma), 0) AS rest_de_plata
FROM SR_VANZARI v
LEFT JOIN SR_PLATI p ON p.id_vanzare = v.id_vanzare
WHERE v.id_vanzare = 1
GROUP BY v.id_vanzare, v.pret_final;
INSERT INTO SR_PLATI
(id_plata, id_vanzare, suma, metoda_plata, data_plata)
VALUES
(9001, 1, 999999, 'CARD', SYSDATE);
