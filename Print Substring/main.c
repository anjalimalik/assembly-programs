
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

// Declaration
char* sub_string(char* in_string, int start_index, int end_index);

int main(){
    int start_index, end_index;
    char *in_string = (char*) malloc(1000*sizeof(char));
    char *out_string; 

    /* Code to recieve inputs from user */
    printf("Enter a string: ");
    scanf("%s", in_string);
    printf("Enter the start index: ");
    scanf("%d", &start_index);
    printf("Enter the end index: ");
    scanf("%d", &end_index);

    /* Code to print the sub-sring */
    out_string = sub_string(in_string, start_index, end_index);
    printf("The substring of the given string is '%s'\n", out_string);
    
    // free allocated memory
    free(in_string);

    return 0;
}
