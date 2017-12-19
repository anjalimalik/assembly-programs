#include <stdio.h>
#include <stdlib.h>

//declarations
void printx(int);
void printd(int);

int myprintf(const char* format,...) {
    
    void* addr = &format + 1;
    int i = 0;
    
    //loop until end string literal is reached
    while(format[i] != '\0') {
        
        if (format[i] == '%') {
            i++; //increment for next char
            
            //check if a character
            if (format[i] == 'c') {
                char c = *(char*) addr;
                putchar(c);
                addr += 4;      //move to next
            } else if (format[i] == 's') { //check if a string
                
                char* s = *(char**) addr;
                int k = 0;
                
                // print each character until reached end character
                while (s[k] != '\0') { putchar(s[k++]); }
                addr += 4;  //move to next
            } else if (format[i] == 'x') { //check if hex
                int num = *(int*) addr;
                printx(num);            //call printx
                addr += 4;      //move to next
            } else if (format[i] == 'd') { //check if decimal
                int num = *(int*) addr;
                printd(num);            //call printd
                addr += 4;
            } else if (format[i] == '%') { //if %
                putchar('%'); //simply print %
                addr += 4;      //move to next
            }
        } else {
            putchar(format[i]); //simply keep printing
        }
        
        i++;
    }
    
    return 0;
}




