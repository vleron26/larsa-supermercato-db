# SQL – Database Supermercato

```sql
CREATE DATABASE supermercato;
USE supermercato;

-- =====================================
-- TABELLA SUPERMERCATO
-- =====================================

CREATE TABLE SUPERMERCATO (
    id_sede INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    sede VARCHAR(100) NOT NULL,
    indirizzo VARCHAR(200) NOT NULL
);

-- =====================================
-- TABELLA CLIENTE
-- =====================================

CREATE TABLE CLIENTE (
    id_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    punti_fedelta INT DEFAULT 0
);

-- =====================================
-- TABELLA DIPENDENTE
-- =====================================

CREATE TABLE DIPENDENTE (
    ID_dipendente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    Ruolo VARCHAR(50) NOT NULL,
    FK_Sede INT NOT NULL,

    CONSTRAINT fk_dipendente_sede
        FOREIGN KEY (FK_Sede)
        REFERENCES SUPERMERCATO(id_sede)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =====================================
-- TABELLA PRODOTTO
-- =====================================

CREATE TABLE PRODOTTO (
    ID_Prodotto INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Categoria VARCHAR(50) NOT NULL,
    Prezzo DECIMAL(10,2) NOT NULL
);

-- =====================================
-- TABELLA ORDINE
-- =====================================

CREATE TABLE ORDINE (
    ID_Ordine INT PRIMARY KEY AUTO_INCREMENT,
    Data DATE NOT NULL,
    FK_Cliente INT NOT NULL,
    FK_Sede INT NOT NULL,
    FK_Dipendente INT NOT NULL,

    CONSTRAINT fk_ordine_cliente
        FOREIGN KEY (FK_Cliente)
        REFERENCES CLIENTE(id_Cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_ordine_sede
        FOREIGN KEY (FK_Sede)
        REFERENCES SUPERMERCATO(id_sede)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_ordine_dipendente
        FOREIGN KEY (FK_Dipendente)
        REFERENCES DIPENDENTE(ID_dipendente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =====================================
-- TABELLA RIGA_ORDINE
-- =====================================

CREATE TABLE RIGA_ORDINE (
    FK_Ordine INT,
    FK_Prodotto INT,
    Quantita INT NOT NULL,
    Prezzo DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (FK_Ordine, FK_Prodotto),

    CONSTRAINT fk_rigaordine_ordine
        FOREIGN KEY (FK_Ordine)
        REFERENCES ORDINE(ID_Ordine)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_rigaordine_prodotto
        FOREIGN KEY (FK_Prodotto)
        REFERENCES PRODOTTO(ID_Prodotto)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =====================================
-- TABELLA SCORTA
-- =====================================

CREATE TABLE SCORTA (
    FK_Sede INT,
    FK_Prodotto INT,
    Quantita INT NOT NULL,
    Soglia_minima INT NOT NULL,

    PRIMARY KEY (FK_Sede, FK_Prodotto),

    CONSTRAINT fk_scorta_sede
        FOREIGN KEY (FK_Sede)
        REFERENCES SUPERMERCATO(id_sede)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_scorta_prodotto
        FOREIGN KEY (FK_Prodotto)
        REFERENCES PRODOTTO(ID_Prodotto)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =====================================
-- INSERT DI ESEMPIO
-- =====================================

INSERT INTO SUPERMERCATO (nome, sede, indirizzo)
VALUES
('Conad', 'Trieste', 'Via Roma 12'),
('Coop', 'Udine', 'Via Milano 45');

INSERT INTO CLIENTE (nome, cognome, email, punti_fedelta)
VALUES
('Mario', 'Rossi', 'mario@email.com', 120),
('Luca', 'Bianchi', 'luca@email.com', 50);

INSERT INTO DIPENDENTE (Nome, Cognome, Ruolo, FK_Sede)
VALUES
('Anna', 'Verdi', 'Cassiere', 1),
('Marco', 'Neri', 'Magazziniere', 2);

INSERT INTO PRODOTTO (Nome, Categoria, Prezzo)
VALUES
('Pasta Barilla', 'Alimentari', 1.99),
('Coca Cola', 'Bevande', 2.50);

INSERT INTO ORDINE (Data, FK_Cliente, FK_Sede, FK_Dipendente)
VALUES
('2026-05-11', 1, 1, 1);

INSERT INTO RIGA_ORDINE (FK_Ordine, FK_Prodotto, Quantita, Prezzo)
VALUES
(1, 1, 2, 1.99),
(1, 2, 1, 2.50);

INSERT INTO SCORTA (FK_Sede, FK_Prodotto, Quantita, Soglia_minima)
VALUES
(1, 1, 100, 20),
(1, 2, 80, 15);

-- =====================================
-- QUERY DI ESEMPIO
-- =====================================

-- Visualizzare tutti i clienti
SELECT *
FROM CLIENTE;

-- Visualizzare tutti i prodotti
SELECT *
FROM PRODOTTO;

-- Visualizzare gli ordini con il nome del cliente
SELECT
    ORDINE.ID_Ordine,
    ORDINE.Data,
    CLIENTE.nome,
    CLIENTE.cognome
FROM ORDINE
JOIN CLIENTE
    ON ORDINE.FK_Cliente = CLIENTE.id_Cliente;

-- Visualizzare i prodotti presenti in un ordine
SELECT
    ORDINE.ID_Ordine,
    PRODOTTO.Nome,
    RIGA_ORDINE.Quantita,
    RIGA_ORDINE.Prezzo
FROM RIGA_ORDINE
JOIN ORDINE
    ON RIGA_ORDINE.FK_Ordine = ORDINE.ID_Ordine
JOIN PRODOTTO
    ON RIGA_ORDINE.FK_Prodotto = PRODOTTO.ID_Prodotto;

-- Visualizzare le scorte di ogni supermercato
SELECT
    SUPERMERCATO.nome,
    PRODOTTO.Nome,
    SCORTA.Quantita
FROM SCORTA
JOIN SUPERMERCATO
    ON SCORTA.FK_Sede = SUPERMERCATO.id_sede
JOIN PRODOTTO
    ON SCORTA.FK_Prodotto = PRODOTTO.ID_Prodotto;

-- Aggiornare i punti fedeltà di un cliente
UPDATE CLIENTE
SET punti_fedelta = 200
WHERE id_Cliente = 1;

-- Eliminare un prodotto
DELETE FROM PRODOTTO
WHERE ID_Prodotto = 2;
```
