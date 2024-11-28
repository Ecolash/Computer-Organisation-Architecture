#include <stdio.h>

int main()
{
    int array[] = {5, 2, 9, 3, 6}; // Array to be sorted
    int n = 5;                     // Size of the array
    int temp, i, j;

    for (i = 1; i < n; i++)
    {
        temp = array[i]; // Store current element in temp
        j = i - 1;       // Initialize j to i - 1

        // Inner loop: Shift elements of array[0..i-1], that are greater than temp, to one position ahead
        while (j >= 0 && array[j] > temp)
        {
            array[j + 1] = array[j]; // Move array[j] to array[j + 1]
            j--;
        }

        array[j + 1] = temp; // Insert temp at the correct position
    }

    // Print sorted array (optional, for verification)
    for (i = 0; i < n; i++)
    {
        printf("%d ", array[i]);
    }
    printf("\n");

    return 0;
}
