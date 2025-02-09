Popis fungování souborů algo.py a filter_interactive.py

# algo.py 

# Popis:
Tento skript filtruje seznam čísel na základě definovaných pravidel (například vybere pouze sudá čísla nebo pouze prvočísla)

# Spuštění:
Nutnost nainstalovaneho Pythonu verze min 3.x

Uložit soubor s názvem algo.py

V terminalu nebo cmd zadat příkaz python algo.py

Výstup zobrazí vyfiltrované hodnoty pro sudá čísla a prvočísla

# Fungování algoritmu:
Skript obsahuje funkci filter_list(items, rules), která ze seznamu čísel odstraní hodnoty, které neodpovídají danému pravidlu

Definovaná pravidla jsou:

is_even(n): vrací True, pokud je číslo sudé

is_prime(n): vrací True, pokud je číslo prvočíslo

Skript pracuje s pevně zadanými daty a zobrazí výsledek filtrace

Při úpravě lze zadat seznam přímo jako první parametr, například print(filter_list([1,2,3,5,9], is_even))

Při úpravě lze definovat novou funkci a tu zadat jako druhý parametr funkce filter_list


# filter_interactive.py

# Popis:
Toto je interaktivní verze, je vyžádán vstup a volba jednoho ze dvou pravidel

# Spuštění:
Nutnost nainstalovaneho Pythonu verze min 3.x

Uložit soubor s názvem filter_interactive.py

V terminalu nebo cmd zadat příkaz python filter_interactive.py

Zadat vyžadované vstupy
