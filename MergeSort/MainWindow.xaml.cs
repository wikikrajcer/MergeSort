using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Windows;

namespace MergeSort
{

    public partial class MainWindow : Window
    {
        private SortingAlgorithm mergeSort;
        public string InputFilePath { get; set; }
        public string OutputFilePath { get; set; }
        public MainWindow()
        {
            InitializeComponent();
            WindowCheckBox.IsChecked = true;
            AsmCheckBox.IsChecked = true;
            mergeSort = new SortingAlgorithm();
        }

        public int[] ReadDataFromFile()
        {
            string numbersToSortInString = File.ReadAllText(InputFilePath);
            int[] numbersToSort = ConvertStringIntoIntArray(numbersToSortInString);
            return numbersToSort;
        }

        public void SaveDataToFile(int[] sortedNumbers)
        {
            using StreamWriter streamWriter = File.CreateText(OutputFilePath);
            streamWriter.WriteLine(ConvertArrayIntoString(sortedNumbers));

        }

        public string ConvertArrayIntoString(int[] sortedNumbers)
        {
            string sortedNumbersInString = "";
            foreach (int number in sortedNumbers)
            {
                if (sortedNumbersInString == "")
                    sortedNumbersInString = number + "";
                else
                    sortedNumbersInString = sortedNumbersInString + " " + number;
            }
            return sortedNumbersInString;
        }

        public bool CheckFormat(string[] numbersInStringArray)
        {

            foreach (string number in numbersInStringArray)
            {
                if (number.Any(c => c < '0' || c > '9') || number == null || number == "")
                    return false;
                else
                    continue;
            }
            return true;
        }

        public int[] ConvertStringIntoIntArray(string numbersInString)
        {
            string[] numbersInStringArray = numbersInString.Split(" ").ToArray();
            if (CheckFormat(numbersInStringArray) != true)
                return null;
            else
                return numbersInStringArray.Select(int.Parse).ToArray();
        }

        public string ConvertTimeFormat(Stopwatch timeToConvert)
        {
           // if (timeToConvert.ElapsedMilliseconds == 0)
                return (timeToConvert.Elapsed.TotalMilliseconds * 1000000).ToString() + " ns";
           // else
             //   return timeToConvert.ElapsedMilliseconds.ToString() + " ms";
        }


        private void SortButtonClick(object sender, RoutedEventArgs e)
        {

            int[] numbersToSortArray;
            int length;
            Stopwatch executionTime = new Stopwatch();

            if (FileCheckBox.IsChecked == true)
            {
                if (InputFilePath == null || OutputFilePath == null)
                    MessageBox.Show("Nie wybrano pliku!");
                else
                {
                    numbersToSortArray = ReadDataFromFile();
                    if (numbersToSortArray != null)
                    {
                        length = numbersToSortArray.Length;

                        if (AsmCheckBox.IsChecked == true || BothCheckBox.IsChecked == true)
                        {
                            executionTime = Stopwatch.StartNew();
                            mergeSort.TemporaryArray = new int[numbersToSortArray.Length];
                            mergeSort.CallMergeSortByAssembler(numbersToSortArray, 0, length - 1);
                            executionTime.Stop();
                            AsemblerResultTextBox.Text = ConvertTimeFormat(executionTime);
                        }
                        if (CppCheckBox.IsChecked == true || BothCheckBox.IsChecked == true)
                        {

                            executionTime = Stopwatch.StartNew();
                            mergeSort.TemporaryArray = new int[numbersToSortArray.Length];
                            mergeSort.CallMergeSortByCpp(numbersToSortArray, 0, length - 1);
                            executionTime.Stop();
                            CppResultTextBox.Text = ConvertTimeFormat(executionTime);
                        }
                        executionTime.Reset();
                        SaveDataToFile(numbersToSortArray);
                    }
                    else
                        MessageBox.Show("Niepoprawny format danych wejściowych!");
                }
            }

            else if (WindowCheckBox.IsChecked == true)
            {
                string numbersToSortInString = NumbersToSortTextBox.Text;
                numbersToSortArray = ConvertStringIntoIntArray(numbersToSortInString);
                if (numbersToSortArray != null)
                {
                    length = numbersToSortArray.Length;
                    if (AsmCheckBox.IsChecked == true || BothCheckBox.IsChecked == true)
                    {
                        executionTime = Stopwatch.StartNew();
                        mergeSort.TemporaryArray = new int[numbersToSortArray.Length];
                        mergeSort.CallMergeSortByAssembler(numbersToSortArray, 0, length - 1);
                        executionTime.Stop();
                        AsemblerResultTextBox.Text = ConvertTimeFormat(executionTime);
                    }
                    if (CppCheckBox.IsChecked == true || BothCheckBox.IsChecked == true)
                    {
                        executionTime = Stopwatch.StartNew();
                        mergeSort.TemporaryArray = new int[numbersToSortArray.Length];
                        mergeSort.CallMergeSortByCpp(numbersToSortArray, 0, length - 1);
                        executionTime.Stop();
                        CppResultTextBox.Text = ConvertTimeFormat(executionTime);
                    }

                    SortedNumbersTextBox.Text = ConvertArrayIntoString(numbersToSortArray);

                    executionTime.Reset();
                }
                else
                {
                    MessageBox.Show("Niepoprawny format danych wejściowych!");
                    NumbersToSortTextBox.Clear();
                    SortedNumbersTextBox.Clear();
                }
            }
        }

        private void InputFileButtonClick(object sender, RoutedEventArgs e)
        {
            Microsoft.Win32.OpenFileDialog dialog = new Microsoft.Win32.OpenFileDialog
            {
                FileName = "Input",
                DefaultExt = ".txt",
                Filter = "Pliki tekstowe (.txt)|*.txt"
            };

            bool? result = dialog.ShowDialog();

            if (result == true)
            {
                InputFilePath = dialog.FileName;
                InputFileLabel.Content = InputFilePath;
                InputFileLabel.Opacity = 0.8;
            }
        }

        private void OutputFileButtonClick(object sender, RoutedEventArgs e)
        {
            Microsoft.Win32.OpenFileDialog dialog = new Microsoft.Win32.OpenFileDialog
            {
                FileName = "Input",
                DefaultExt = ".txt",
                Filter = "Text documents (.txt)|*.txt"
            };

            bool? result = dialog.ShowDialog();

            if (result == true)
            {
                OutputFilePath = dialog.FileName;
                OutputFileLabel.Content = OutputFilePath;
                OutputFileLabel.Opacity = 0.8;
            }
        }

        private void FileChecked(object sender, RoutedEventArgs e)
        {
            InputFileButton.IsEnabled = true;
            OutputFileButton.IsEnabled = true;
            NumbersToSortTextBox.IsReadOnly = true;
            NumbersToSortTextBox.Clear();
            SortedNumbersTextBox.Clear();
        }
        private void WindowChecked(object sender, RoutedEventArgs e)
        {
            InputFileButton.IsEnabled = false;
            OutputFileButton.IsEnabled = false;
            NumbersToSortTextBox.IsReadOnly = false;
        }
    }
}
