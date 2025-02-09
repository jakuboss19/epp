def filter_list(items, rules):
    """ Filtruje seznam položek podle definovaných pravidel
    
    Args:
        items: Seznam položek k filtrování
        rules: Funkce, která vrací True pro položky, které mají zůstat
    
    Returns:
        Nový seznam položek, které prošly pravidlem
     """
    return [item for item in items if rules(item)]

# Příklad pravidla: ponechat pouze sudá čísla
def is_even(n):
    return n % 2 == 0

# Příklad pravidla: ponechat pouze prvočísla
def is_prime(n):
    if n <= 1:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True

if __name__ == "__main__":

    # Příklad seznamu
    items = [5, 10, 11, 12, 15, 20, 30, 33, 40, 101]

    # Použití filtrace
    filtered_items = filter_list(items, is_even)

    # Výstup 
    print(filtered_items)  

    # Použití filtrace seznamu bez uložení do proměnné
    print(filter_list([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 447, 15561], is_prime))





