
/* Autor : Wiktoria Krajcer
 Nazwa funkcji : MergeSortFuncCpp
 Funkcja ta realizuje czêœæ algorytmu sortowania przez scalanie, która scala dwa posortowane podci¹gi
 w jeden posortowany podci¹g
 Input:
 arrayOfNumbers - tablica z liczbami do posortowania
 temporaryArray - tablica tymczasowa
 leftIndex - indeks pierwszego elementu tablicy(pierwszego elementu m³odszego podci¹gu)
 middleIndex - indeks srodkowego elementu tablicy(pierwszego elementu starszego podci¹gu)
 rightIndex - indeks ostatniego elementu tablicy(ostatniego elementu starszego podci¹gu)
 Output: brak - operacje s¹ wykonywane na oryginalne tablicy
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

		//sortowanie (scalanie) dwóch podci¹gów
		while (i <= middleIndex && j <= rightIndex) //sprawdzenie, czy zosta³y jeszcze liczby do porównania
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
			k++; //inkrementacja indeksu k - czyli elementu bie¿¹cego 
		}

		//przepisanie pozosta³ych liczb do tablicy wynikowej
		while (i <= middleIndex) //sprawdzenie, czy zosta³y jeszcze liczby do wpisania
		{
			arrayOfNumbers[k] = temporaryArray[i]; //przepisanie elementu o indeksie i do tablicy wynikowej
			i++; //inkrementacja indeksu i
			k++; //inkrementacja indeksu k
		}
	}
}

