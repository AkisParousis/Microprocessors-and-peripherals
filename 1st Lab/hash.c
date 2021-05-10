#include <stdio.h>

char str[] = " Ar, PE 2!";

extern int hash(char* str);

int main (void){
	int out;
	out = hash(str);
	printf("%d",out);
	return 0;
}
