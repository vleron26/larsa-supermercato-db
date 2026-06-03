# Sistema di Gestione Supermercato

## Descrizione

Progetto di database realizzato per l'anno formativo 2025-2026.

Il database è progettato per gestire una catena di supermercati e consente l'amministrazione di clienti, prodotti, dipendenti, ordini e scorte di magazzino.

## Funzionalità

- Gestione dei supermercati e delle sedi
- Gestione dei clienti e dei punti fedeltà
- Gestione dei prodotti
- Gestione dei dipendenti
- Registrazione degli ordini
- Controllo delle scorte di magazzino
- Utilizzo di viste (VIEW) per il monitoraggio dei dati
- Utilizzo di trigger per automatizzare alcune operazioni
- Utilizzo di transazioni per garantire l'integrità dei dati

## Struttura del Database

Il database è composto dalle seguenti tabelle:

- supermercato
- cliente
- prodotto
- dipendente
- ordine
- riga_ordine
- scorta

## Oggetti Avanzati

### View

- vista_ordini
- vista_scorte_critiche
- vista_clienti_attivi

### Trigger

- trg_punti_fedelta
- trg_aggiorna_scorta
- trg_check_prezzo

## Tecnologie Utilizzate

- SQL Server
- T-SQL

## Autore

Vleron Ajdari

