CREATE TABLE stand(
	cod_stand int IDENTITY(1,1) PRIMARY KEY,
	nume_vanzator varchar(30) NOT NULL,
	telefon int NOT NULL
);

CREATE TABLE articol(
	cod_articol int IDENTITY(1,1) PRIMARY KEY,
	denumire_articol varchar(30) NOT NULL,
	pret int NOT NULL,
	cantitate int NOT NULL,
	cod_stand int FOREIGN KEY REFERENCES stand(cod_stand)
);

CREATE TABLE furnizor(
	cod_furnizor int IDENTITY(1,1) PRIMARY KEY,
	nume_furnizor varchar(30) NOT NULL,
	adresa varchar(50) NOT NULL,
	telefon int NOT NULL
);

CREATE TABLE tranzactie(
	cod_tranzactie int IDENTITY(1,1) PRIMARY KEY,
	tip_tranzactie varchar(1) NOT NULL,
	cod_articol int FOREIGN KEY REFERENCES articol(cod_articol),
	nume_articol varchar(30) NOT NULL, 
	cod_furnizor int FOREIGN KEY REFERENCES furnizor(cod_furnizor),
	suma int NOT NULL,
	data_tranzactiei DATE NOT NULL DEFAULT GETDATE()
);

INSERT INTO stand VALUES ('vanzator_stand_1', 0700111222);
INSERT INTO stand VALUES ('vanzator_stand_2', 0700111223);

INSERT INTO articol VALUES('Mere', 3, 20, 1);
INSERT INTO articol VALUES('Pere', 3, 10, 1);
INSERT INTO articol VALUES('Banane', 3, 7, 1);

INSERT INTO articol VALUES('Mere', 3, 30, 2);
INSERT INTO articol VALUES('Pere', 3, 15, 2);
INSERT INTO articol VALUES('Banane', 3, 10, 2);

INSERT INTO furnizor VALUES('SC Mere SRL', 'Str. Merelor, nr. 100, loc. Merestii de Sus', 0700111224);
INSERT INTO furnizor VALUES('SC Pere Pentru Tine SRL', 'Str. Perelor, nr. 200, loc. Perarii de Jos', 0700111225);
INSERT INTO furnizor VALUES('SC Banana Land SRL', 'Str. Bananierilor, nr. 300, loc. Banana Voda', 0700111226);


INSERT INTO tranzactie VALUES('I', 1, 'Mere', 1, 40, '2021-06-01');
INSERT INTO tranzactie VALUES('I', 2, 'Pere', 2, 20, '2021-06-01');
INSERT INTO tranzactie VALUES('I', 3, 'Banane', 3, 14, '2021-06-01');

INSERT INTO tranzactie VALUES('I', 1, 'Mere', 1, 60, '2021-06-03');
INSERT INTO tranzactie VALUES('I', 2, 'Pere', 2, 30, '2021-06-03');
INSERT INTO tranzactie VALUES('I', 3, 'Banane', 3, 20, '2021-06-03');

INSERT INTO tranzactie VALUES('O', 1, 'Mere', 1, 12, '2021-06-01');
INSERT INTO tranzactie VALUES('O', 1, 'Mere', 1, 18, '2021-06-02');
INSERT INTO tranzactie VALUES('O', 2, 'Pere', 2, 9, '2021-06-01');
INSERT INTO tranzactie VALUES('O', 2, 'Pere', 2, 15, '2021-06-03');
INSERT INTO tranzactie VALUES('O', 3, 'Banane', 3, 12, '2021-06-02');
INSERT INTO tranzactie VALUES('O', 3, 'Banane', 3, 21, '2021-06-03');
INSERT INTO tranzactie VALUES('O', 3, 'Banane', 3, 12, '2021-06-04');

INSERT INTO tranzactie VALUES('O', 1, 'Mere', 1, 15, '2021-06-03');
INSERT INTO tranzactie VALUES('O', 1, 'Mere', 1, 21, '2021-06-05');
INSERT INTO tranzactie VALUES('O', 2, 'Pere', 2, 12, '2021-06-04');
INSERT INTO tranzactie VALUES('O', 2, 'Pere', 2, 18, '2021-06-05');
INSERT INTO tranzactie VALUES('O', 3, 'Banane', 3, 15, '2021-06-03');
INSERT INTO tranzactie VALUES('O', 3, 'Banane', 3, 24, '2021-06-05');
INSERT INTO tranzactie VALUES('O', 3, 'Banane', 3, 24, '2021-06-05');

/* Valoarea marfurilor de la un anumit stand | ex 2 */
SELECT SUM(pret * cantitate) FROM articol WHERE cod_stand = 1; 

/* Valoarea intrarilor la un moment dat | ex. 3*/
SELECT SUM(suma) FROM tranzactie WHERE tip_tranzactie = 'I' AND data_tranzactiei <= '2021-06-02';

/* Valoarea iesirilor la un moment dat | ex. 4*/
SELECT SUM(suma) FROM tranzactie WHERE tip_tranzactie = 'O' AND data_tranzactiei <= '2021-06-03';

/* Valoarea marfurilor in functie de furnizori | ex. 5*/
SELECT cod_furnizor, SUM(suma) as 'Valoare' FROM tranzactie WHERE tip_tranzactie = 'I' GROUP BY cod_furnizor;

/* Valoarea celui mai bine vandut articol | ex. 6*/
SELECT TOP 1 tranzactie.nume_articol, articol.pret, SUM(tranzactie.suma) AS Valoare_totala FROM tranzactie, articol WHERE tranzactie.tip_tranzactie = 'O' GROUP BY tranzactie.nume_articol, articol.pret;

/* Valoarea celui mai putin vandut articol | ex. 7*/
SELECT TOP 1 tranzactie.nume_articol, articol.pret, SUM(tranzactie.suma) AS Valoare_totala FROM tranzactie, articol WHERE tranzactie.tip_tranzactie = 'O' GROUP BY tranzactie.nume_articol, articol.pret ORDER BY Valoare_totala ASC;