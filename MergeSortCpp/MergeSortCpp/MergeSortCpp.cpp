
/* Autor : Wiktoria Krajcer
 Nazwa funkcji : MergeSortFuncCpp
 Funkcja ta realizuje cz�� algorytmu sortowania przez scalanie, kt�ra scala dwa posortowane podci�gi
 w jeden posortowany podci�g
 Input:
 arrayOfNumbers - tablica z liczbami do posortowania
 temporaryArray - tablica tymczasowa
 leftIndex - indeks pierwszego elementu tablicy(pierwszego elementu m�odszego podci�gu)
 middleIndex - indeks srodkowego elementu tablicy(pierwszego elementu starszego podci�gu)
 rightIndex - indeks ostatniego elementu tablicy(ostatniego elementu starszego podci�gu)
 Output: brak - operacje s� wykonywane na oryginalne tablicy
*/

extern "C"
{
    __declspec(dllexport) void MergeSortFuncCpp(int* arrayOfNumbers, int* temporaryArray, int leftIndex, int middleIndex, int rightIndex)
	{
		//kopiowanie liczb do posortowania do tablicy tymczasowej
		for (int i = leftIndex; i <= rightIndex; i++)
		{
			temporaryArray[i] = arrayOfNumbers[i];
		}

		//przypisanie zmiennych
		int i = leftIndex;
		int j = middleIndex + 1;
		int k = leftIndex;

		//sortowanie (scalanie) dw�ch podci�g�w
		while (i <= middleIndex && j <= rightIndex) //sprawdzenie, czy zosta�y jeszcze liczby do por�wnania
		{
			if (temporaryArray[i] <= temporaryArray[j]) //sprawdzenie czy element o indeksie j jest wiekszy od elementu o indeksie i
			{
				arrayOfNumbers[k] = temporaryArray[i]; //jesli jest, to przepisanie elementu o indeksie i do tablicy wynikowej
				i++; //inkrementacja indeksu i
			}
			else
			{
				arrayOfNumbers[k] = temporaryArray[j]; //jesli nie jest, to przepisanie elementu o indeksie j do tablicy wynikowej
				j++; //inkrementacja indeksu j
			}
			k++; //inkrementacja indeksu k - czyli elementu bie��cego 
		}

		//przepisanie pozosta�ych liczb do tablicy wynikowej
		while (i <= middleIndex) //sprawdzenie, czy zosta�y jeszcze liczby do wpisania
		{
			arrayOfNumbers[k] = temporaryArray[i]; //przepisanie elementu o indeksie i do tablicy wynikowej
			i++; //inkrementacja indeksu i
			k++; //inkrementacja indeksu k
		}
	}
}

