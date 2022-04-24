using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;

namespace MergeSort
{
    public class SortingAlgorithm
    {
        [DllImport(@"C:\Users\Wiktoria\source\repos\MergeSort\x64\Release\MergeSortAsm.dll")]
        static extern int MergeSortFuncAsm(int[] array, int[] temp, int begin, int mid, int end);

        [DllImport(@"C:\Users\Wiktoria\source\repos\MergeSort\x64\Release\MergeSortCpp.dll")]
        static extern int MergeSortFuncCpp(int[] array, int[] temp, int begin, int mid, int end);

        public int[] TemporaryArray { get; set; }

        public void CallMergeSortByAssembler(int[] arrayOfNumbers, int leftIndex, int rightIndex)
        {
            
            if (rightIndex > leftIndex) //sprawdzenie, że tablica ma co najmniej 2 elementy
            {
                int middleIndex = (leftIndex + rightIndex) / 2; //wyznaczanie indeksu środka tablicy
                CallMergeSortByAssembler(arrayOfNumbers, leftIndex, middleIndex); //wywołanie dla lewej części tablicy
                CallMergeSortByAssembler(arrayOfNumbers, middleIndex + 1, rightIndex); //wywołanie dla prawej części tablicy
                MergeSortFuncAsm(arrayOfNumbers, TemporaryArray, leftIndex, middleIndex, rightIndex); //wywołanie sortowania
            }

        }

        public void CallMergeSortByCpp(int[] arrayOfNumbers, int leftIndex, int rightIndex)
        {

            if (rightIndex > leftIndex) //sprawdzenie, że tablica ma co najmniej 2 elementy
            {
                int middleIndex = (leftIndex + rightIndex) / 2; //wyznaczanie indeksu środka tablicy
                CallMergeSortByCpp(arrayOfNumbers, leftIndex, middleIndex); //wywołanie dla lewej części tablicy
                CallMergeSortByCpp(arrayOfNumbers, middleIndex + 1, rightIndex); //wywołanie dla prawej części tablicy
                MergeSortFuncCpp(arrayOfNumbers, TemporaryArray, leftIndex, middleIndex, rightIndex); //wywołanie sortowania
            }

        }
    }
}
