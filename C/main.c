#include <stdio.h>

int main() 
{
	int n = 16;
	int A[] = {2,-2, 4,-4, 6,-6, 8,-8,-9, 9,-7, 7,-5, 5,-3, 3};
	int B[] = {8, 7, 6, 5, 4, 3, 2, 1,-1,-2,-3,-4,-5,-6,-7,-8};

	// Result arrays.
	int AM[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	int BM[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

	for (int i = 0; i < n; i++) 
	{
		for (int j = 0; j < n; j++) 
		{
			if (AM[i] < (A[i] * B[j])) AM[i] = A[i] * B[j];
			if (BM[i] < (B[i] * A[j])) BM[i] = B[i] * A[j];
		}
	}
} 
