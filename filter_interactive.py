def filter_list(items, rules): 
    """ Filtruje seznam položek podle definovaných pravidel
    
    Args:
        items: Seznam položek k filtrování
        rules: Funkce, která vrací True pro položky, které mají zůstat
    
    Returns:
        Seznam položek, které prošly pravidlem
    """
    return [item for item in items if rules(item)]

# Definice pravidel
def is_even(n):
    """Pravidlo pro sudá čísla"""
    return n % 2 == 0

def is_prime(n):
    """Pravidlo pro prvočísla"""
    if n <= 1:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True

def get_number_list():
    """Získá od uživatele seznam čísel a provede validaci"""
    while True:
        user_input = input("Zadejte seznam čísel oddělených čárkou: ")
        try:
            number_list = [int(x.strip()) for x in user_input.split(",")]
            return number_list
        except ValueError:
            print("Neplatný vstup! Zadejte pouze čísla oddělená čárkou")

def get_rule():
    """Získá od uživatele pravidlo filtrování"""
    rules = {
        "1": ("Sudá čísla", is_even),
        "2": ("Prvočísla", is_prime),
    }

    while True:
        print("\nVyberte pravidlo filtrování:")
        for key, (desc, _) in rules.items():
            print(f"{key}: {desc}")

        choice = input("Zadejte číslo pravidla: ").strip()

        if choice in rules:
            return rules[choice][1]
        else:
            print("Neplatná volba, zkuste to znovu.")

if __name__ == "__main__":
    print("Vítejte v programu pro filtrování čísel!")

    # Získání seznamu čísel
    cisla = get_number_list()

    # Výběr pravidla
    pravidlo = get_rule()

    # Filtrace a výstup výsledku
    vysledek = filter_list(cisla, pravidlo)
    print("\nVýsledný seznam po filtraci:", vysledek)