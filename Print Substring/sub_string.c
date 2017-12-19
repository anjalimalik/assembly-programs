
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

char* sub_string(char *in_string, int start_index, int end_index){
    start_index -= 1; // start index as in char array
    
    /* Code to extract the sub-string */
    // using strlen and strcpy functions 
    int n = strlen(in_string);
    char *out_string = (char*) malloc(n*sizeof(char));
    strncpy(out_string, in_string + start_index, end_index - start_index);
    
    return out_string;
}

