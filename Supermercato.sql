

-- Tabella: supermercato
CREATE TABLE supermercato (
    id_sede     INT PRIMARY KEY IDENTITY(1,1),
    nome        NVARCHAR(100) NOT NULL,
    sede        NVARCHAR(100) NOT NULL,
    indirizzo   NVARCHAR(200) NOT NULL
);

-- Tabella: cliente
CREATE TABLE cliente (
    id_cliente      INT PRIMARY KEY IDENTITY(1,1),
    nome            NVARCHAR(100) NOT NULL,
    cognome         NVARCHAR(100) NOT NULL,
    email           NVARCHAR(200) NOT NULL UNIQUE,
    punti_fedelta   INT DEFAULT 0
);

-- Tabella: prodotto
CREATE TABLE prodotto (
    id_prodotto INT PRIMARY KEY IDENTITY(1,1),
    nome        NVARCHAR(100) NOT NULL,
    categoria   NVARCHAR(100) NOT NULL,
    prezzo      DECIMAL(10,2) NOT NULL
);

-- Tabella: dipendente
CREATE TABLE dipendente (
    id_dipendente   INT PRIMARY KEY IDENTITY(1,1),
    nome            NVARCHAR(100) NOT NULL,
    cognome         NVARCHAR(100) NOT NULL,
    ruolo           NVARCHAR(100) NOT NULL,
    fk_sede         INT NOT NULL,

    FOREIGN KEY (fk_sede)
        REFERENCES supermercato(id_sede)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabella: ordine
CREATE TABLE ordine (
    id_ordine       INT PRIMARY KEY IDENTITY(1,1),
    data            DATE NOT NULL,
    fk_cliente      INT NOT NULL,
    fk_sede         INT NOT NULL,
    fk_dipendente   INT NOT NULL,

    FOREIGN KEY (fk_cliente)
        REFERENCES cliente(id_cliente),

    FOREIGN KEY (fk_sede)
        REFERENCES supermercato(id_sede),

    FOREIGN KEY (fk_dipendente)
        REFERENCES dipendente(id_dipendente)
);

-- Tabella: riga_ordine
CREATE TABLE riga_ordine (
    fk_ordine   INT NOT NULL,
    fk_prodotto INT NOT NULL,
    quantita    INT NOT NULL,
    prezzo      DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (fk_ordine, fk_prodotto),

    FOREIGN KEY (fk_ordine)
        REFERENCES ordine(id_ordine)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (fk_prodotto)
        REFERENCES prodotto(id_prodotto)
);

-- Tabella: scorta
CREATE TABLE scorta (
    fk_sede         INT NOT NULL,
    fk_prodotto     INT NOT NULL,
    quantita        INT NOT NULL,
    soglia_minima   INT NOT NULL,

    PRIMARY KEY (fk_sede, fk_prodotto),

    FOREIGN KEY (fk_sede)
        REFERENCES supermercato(id_sede)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (fk_prodotto)
        REFERENCES prodotto(id_prodotto)
);
GO


-- ============================================================
-- PARTE 2: INSERT
-- (IDENTITY_INSERT needed to force specific IDs)
-- ============================================================

SET IDENTITY_INSERT supermercato ON;
INSERT INTO supermercato (id_sede, nome, sede, indirizzo) VALUES
(1, 'Conad', 'Trieste', 'Via Roma 12'),
(2, 'Conad', 'Udine', 'Via Milano 45'),
(3, 'Conad', 'Trieste', 'Viale XX Settembre 20');
SET IDENTITY_INSERT supermercato OFF;
GO

SET IDENTITY_INSERT cliente ON;
INSERT INTO cliente (id_cliente, nome, cognome, email, punti_fedelta) VALUES
(1, 'Mario', 'Rossi', 'mario.rossi@email.com', 200),
(2, 'Luca', 'Bianchi', 'luca.bianchi@email.com', 50),
(3, 'Ron', 'Ajdari', 'ron.ajdari@email.com', 250),
(4, 'Anna', 'Ferrari', 'anna.ferrari@email.com', 120),
(5, 'Sara', 'Conti', 'sara.conti@email.com', 0),
(6, 'Giorgio', 'Martini', 'giorgio.martini@email.com', 380),
(7, 'Elena', 'Russo', 'elena.russo@email.com', 75);
SET IDENTITY_INSERT cliente OFF;
GO

SET IDENTITY_INSERT prodotto ON;
INSERT INTO prodotto (id_prodotto, nome, categoria, prezzo) VALUES
(1, 'Pasta Barilla', 'Alimentari', 1.99),
(2, 'Latte Intero Parmalat', 'Latticini', 1.49),
(3, 'Pane Integrale', 'Panetteria', 2.30),
(4, 'Acqua Naturale 1.5L', 'Bevande', 0.49),
(5, 'Detersivo Dash', 'Pulizia', 4.99),
(6, 'Mozzarella Galbani', 'Latticini', 1.89),
(7, 'Olio Extravergine', 'Alimentari', 5.50),
(8, 'Succo Arancia', 'Bevande', 1.79);
SET IDENTITY_INSERT prodotto OFF;
GO

SET IDENTITY_INSERT dipendente ON;
INSERT INTO dipendente (id_dipendente, nome, cognome, ruolo, fk_sede) VALUES
(1, 'Anna', 'Verdi', 'Cassiere', 1),
(2, 'Marco', 'Neri', 'Magazziniere', 2),
(3, 'Art', 'Ciao', 'Capoturno', 1),
(4, 'Giulia', 'Marini', 'Cassiere', 3),
(5, 'Paolo', 'Bruno', 'Magazziniere', 1),
(6, 'Chiara', 'Ricci', 'Capoturno', 2);
SET IDENTITY_INSERT dipendente OFF;
GO

SET IDENTITY_INSERT ordine ON;
INSERT INTO ordine (id_ordine, data, fk_cliente, fk_sede, fk_dipendente) VALUES
(1, '2026-05-11', 1, 1, 1),
(2, '2026-05-12', 2, 2, 2),
(3, '2026-05-13', 3, 1, 3),
(4, '2026-05-14', 4, 3, 4),
(5, '2026-05-15', 1, 1, 1),
(6, '2026-05-16', 6, 2, 6);
SET IDENTITY_INSERT ordine OFF;
GO

INSERT INTO riga_ordine (fk_ordine, fk_prodotto, quantita, prezzo) VALUES
(1, 1, 2, 1.99),
(1, 2, 1, 1.49),
(2, 3, 3, 2.30),
(2, 4, 6, 0.49),
(3, 5, 1, 4.99),
(3, 6, 2, 1.89),
(4, 7, 1, 5.50),
(4, 8, 4, 1.79),
(5, 1, 5, 1.99),
(5, 7, 2, 5.50),
(6, 2, 3, 1.49),
(6, 4, 12, 0.49);
GO

INSERT INTO scorta (fk_sede, fk_prodotto, quantita, soglia_minima) VALUES
(1, 1, 100, 20),
(1, 2, 60, 15),
(1, 3, 40, 10),
(1, 4, 200, 50),
(2, 1, 80, 20),
(2, 5, 30, 10),
(2, 6, 8, 15),
(3, 7, 50, 10),
(3, 8, 90, 20),
(3, 3, 12, 10);
GO


-- ============================================================
-- PARTE 3: VIEW
-- ============================================================

-- VIEW 1: riepilogo ordini con cliente e totale
CREATE OR ALTER VIEW vista_ordini AS
SELECT
    o.id_ordine,
    o.data,
    c.nome + ' ' + c.cognome                AS cliente,
    s.sede + ' - ' + s.indirizzo            AS sede,
    SUM(ro.quantita * ro.prezzo)            AS totale_ordine
FROM ordine o
JOIN cliente        c   ON o.fk_cliente     = c.id_cliente
JOIN supermercato   s   ON o.fk_sede        = s.id_sede
JOIN riga_ordine    ro  ON o.id_ordine      = ro.fk_ordine
GROUP BY o.id_ordine, o.data, c.nome, c.cognome, s.sede, s.indirizzo;
GO

-- VIEW 2: prodotti sotto la soglia minima
CREATE OR ALTER VIEW vista_scorte_critiche AS
SELECT
    s.fk_sede,
    sup.sede + ' - ' + sup.indirizzo        AS sede,
    p.nome                                  AS prodotto,
    p.categoria,
    s.quantita                              AS scorta_attuale,
    s.soglia_minima
FROM scorta         s
JOIN prodotto       p   ON s.fk_prodotto    = p.id_prodotto
JOIN supermercato   sup ON s.fk_sede        = sup.id_sede
WHERE s.quantita < s.soglia_minima;
GO

-- VIEW 3: clienti con punti fedeltà e numero ordini
CREATE OR ALTER VIEW vista_clienti_attivi AS
SELECT
    c.id_cliente,
    c.nome + ' ' + c.cognome               AS cliente,
    c.email,
    c.punti_fedelta,
    COUNT(o.id_ordine)                      AS numero_ordini
FROM cliente c
LEFT JOIN ordine o ON c.id_cliente = o.fk_cliente
GROUP BY c.id_cliente, c.nome, c.cognome, c.email, c.punti_fedelta;
GO

-- Uso delle VIEW:
-- SELECT * FROM vista_ordini;
-- SELECT * FROM vista_scorte_critiche;
-- SELECT * FROM vista_clienti_attivi;


-- ============================================================
-- PARTE 4: TRIGGER
-- ============================================================

-- TRIGGER 1: +10 punti fedeltà per ogni nuovo ordine
CREATE OR ALTER TRIGGER trg_punti_fedelta
ON ordine
AFTER INSERT
AS
BEGIN
    UPDATE cliente
    SET punti_fedelta = punti_fedelta + 10
    FROM cliente c
    INNER JOIN inserted i ON c.id_cliente = i.fk_cliente;
END;
GO

-- TRIGGER 2: riduce la scorta quando viene aggiunta una riga_ordine
CREATE OR ALTER TRIGGER trg_aggiorna_scorta
ON riga_ordine
AFTER INSERT
AS
BEGIN
    UPDATE scorta
    SET quantita = scorta.quantita - i.quantita
    FROM scorta
    INNER JOIN inserted i ON scorta.fk_prodotto = i.fk_prodotto
    INNER JOIN ordine o   ON o.id_ordine = i.fk_ordine
                         AND scorta.fk_sede = o.fk_sede;
END;
GO

-- TRIGGER 3: blocca inserimento prodotto con prezzo <= 0
CREATE OR ALTER TRIGGER trg_check_prezzo
ON prodotto
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE prezzo <= 0)
    BEGIN
        RAISERROR('Errore: il prezzo del prodotto deve essere maggiore di 0', 16, 1);
        ROLLBACK;
        RETURN;
    END

    INSERT INTO prodotto (nome, categoria, prezzo)
    SELECT nome, categoria, prezzo FROM inserted;
END;
GO


-- ============================================================
-- PARTE 5: TRANSAZIONI
-- ============================================================

-- TRANSAZIONE 1: nuovo ordine completo
BEGIN TRANSACTION;

    DECLARE @nuovo_ordine INT;

    INSERT INTO ordine (data, fk_cliente, fk_sede, fk_dipendente)
    VALUES ('2026-05-20', 3, 1, 1);

    SET @nuovo_ordine = SCOPE_IDENTITY();

    INSERT INTO riga_ordine (fk_ordine, fk_prodotto, quantita, prezzo)
    VALUES
        (@nuovo_ordine, 1, 2, 1.99),
        (@nuovo_ordine, 4, 3, 0.49);

COMMIT;
GO

-- TRANSAZIONE 2: aggiornamento prezzo prodotto
BEGIN TRANSACTION;

    UPDATE prodotto
    SET prezzo = 2.19
    WHERE id_prodotto = 1;

COMMIT;
GO