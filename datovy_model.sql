-- - Instrukce pro spuštění:
-- - Skript je napsán pro SQLite, ale je kompatibilní s většinou SQL databází
-- - Pro spuštění dotazů je nutné:
--    - Definovat hodnotu parametru :c v dotazu pro filtrování jistin
--    - Mít nahraná testovací data v tabulkách

-- - Poznámky:
-- - Všechny tabulky obsahují primární klíče
-- - Implementovány FK vztahy s ON DELETE CASCADE
-- - Email a telefon jsou unikátní identifikátory klienta
-- - Kardinalita:
--    - Klient 1:N Účet (jeden klient může mít více účtů)
--    - Účet 1:N Transakce (jeden účet má více transakcí)
--    - Účet 1:N Balance (jeden účet má více denních balancí)
--    - Typ transakce 1:N Transakce (jeden typ může mít více transakcí)


-- Číselník typů transakcí
CREATE TABLE typ_transakce (
    id_typ_transakce INTEGER PRIMARY KEY,
    nazev VARCHAR(50) NOT NULL,
    popis VARCHAR(200)
);

-- Tabulka klientů
CREATE TABLE klient (
    id_klient INTEGER PRIMARY KEY,
    jmeno VARCHAR(50) NOT NULL,
    prijmeni VARCHAR(50) NOT NULL,
    datum_narozeni DATE,
    email VARCHAR(254) UNIQUE,
    telefon VARCHAR(20) UNIQUE
);

-- Tabulka účtů
CREATE TABLE ucet (
    id_ucet INTEGER PRIMARY KEY,
    id_klient INTEGER NOT NULL,
    cislo_uctu VARCHAR(20) NOT NULL UNIQUE,
    mena VARCHAR(3) NOT NULL,
    datum_zalozeni DATE NOT NULL,
    stav VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_klient) REFERENCES klient(id_klient) ON DELETE CASCADE
);

-- Tabulka transakcí
CREATE TABLE transakce (
    id_transakce INTEGER PRIMARY KEY,
    id_ucet INTEGER NOT NULL,
    id_typ_transakce INTEGER NOT NULL,
    datum_cas TIMESTAMP NOT NULL,
    castka DECIMAL(15,2) NOT NULL,
    popis VARCHAR(200),
    FOREIGN KEY (id_ucet) REFERENCES ucet(id_ucet) ON DELETE CASCADE,
    FOREIGN KEY (id_typ_transakce) REFERENCES typ_transakce(id_typ_transakce)
);

-- Tabulka denních balancí
CREATE TABLE balance (
    id_balance INTEGER PRIMARY KEY,
    id_ucet INTEGER NOT NULL,
    datum DATE NOT NULL,
    jistina DECIMAL(15,2) NOT NULL,
    urok DECIMAL(15,2) NOT NULL,
    poplatky DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (id_ucet) REFERENCES ucet(id_ucet) ON DELETE CASCADE
);

-- Dotaz pro klienty s jistinou větší než c
SELECT DISTINCT k.id_klient, k.jmeno, k.prijmeni
FROM klient k
JOIN ucet u ON k.id_klient = u.id_klient
JOIN balance b ON u.id_ucet = b.id_ucet
WHERE strftime('%Y-%m-%d', datum) = strftime('%Y-%m-%d', date('now', 'start of month', '+1 month', '-1 day'))
GROUP BY k.id_klient, k.jmeno, k.prijmeni
HAVING SUM(b.jistina) > :c;

-- Dotaz pro 10 klientů s nejvyšší celkovou pohledávkou
SELECT k.id_klient, k.jmeno, k.prijmeni,
       SUM(b.jistina + b.urok + b.poplatky) as celkova_pohledavka
FROM klient k
JOIN ucet u ON k.id_klient = u.id_klient
JOIN balance b ON u.id_ucet = b.id_ucet
WHERE strftime('%Y-%m-%d', datum) = strftime('%Y-%m-%d', date('now', 'start of month', '+1 month', '-1 day'))
GROUP BY k.id_klient, k.jmeno, k.prijmeni
ORDER BY celkova_pohledavka DESC
LIMIT 10;
