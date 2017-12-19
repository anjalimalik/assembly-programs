#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

#define READABLE_FILE "file_to_read.txt" /* File to be read during read operations */
#define BYTES_TO_READ_WRITE 819200 /* 800 KB */
#define MAX_BUFFER  1048576 /* 1 MB*/


/* Declare global variables for write operations here */
int fd_write = 1;

// with buffer
char* wp;			//  point to location in the buffer
int write_buf_size;		// stores size of the output buffer
char write_buf[MAX_BUFFER]; 	// output buffer
int write_count;

/* Declare global variables for read operations here */
int fd_read;			
char read_buf[MAX_BUFFER];	// input buffer
char* rp;			// point to the relevnat location in the buffer
int read_buf_size;		// size of the input buffer we use
int read_count;			// holds number of bytes read

char* count;

/* Function for write without buffer */
void mywritec(char ch){
    // write data out of a buffer
    write(1, &ch, 1);
}

/* Functions for write with buffer */
void mywritebufsetup(int n){
    // initialize the buffer

    // check if n is a positive number or equal to max buffer
    if((n>MAX_BUFFER) || (n < 0)){
        return;
    }
    
   // store n in write_buf_size
    write_buf_size = n;

   // initialize wp to point to the first byte of buffer
    wp = write_buf;
    write_count = 0;
}
void myputc(char ch){
    // write entire contents of the buffer
    
    // store ch in the location given by wp and increment wp
    *wp = ch; 
    wp++;
    
	
    //write_count++;
   // Only write when the buffer is full
    if (wp >= (write_buf + write_buf_size)) {
        write(1, write_buf, write_buf_size); // write the entire buffer
        wp = write_buf; // reset to initial location in the buffer
	write_count++;
    }
}
void mywriteflush(void){
	count = &write_buf[0];
    // force writing of the buffer, even if it is not full
    write(1, write_buf, (wp - count));
    //wp = write_buf;
}

/* Function for read without buffer */
int myreadc(void){
    //read what is in fd_read using pointer

    int chr;
    char* ptr = (char*)&chr;
    int c = read(fd_read, ptr, 1);
   
    if (c == 0) {
        return -1;
    }
    
   // return the character that was read in the low order byte of the integer return value
    return *ptr;
}

/* Functions for read with buffer */
void myreadbufsetup(int n){
   // initialize the read buffer
   // verify n
    if ((n>MAX_BUFFER) || (n < 0)) {
        return;
    }
   // initialize read_count to 0 because no bytes have been read yet
   // set read_buf_size to n
    read_buf_size = n;
    read_count = 0;
}

int mygetc(void){
    // read_count should be 0 or negative 
    if (read_count <= 0) {
	// set read_count to the number of bytes read
        read_count = read(fd_read, &read_buf, read_buf_size);
        rp = read_buf; // first occupied slot in the buffer
    }
    
   // if it's 0 after above code execution, we've reached end of file
    if (read_count == 0) {
        return -1;
    }
    
   // extract next character from buffer and increment rp, and decrement read_count
    int ptr = *rp++;
    read_count--;

    // return character extracted from the buffer
    return ptr;
}



/* Main function starts */
int main()
{
    clock_t begin, end;
    int option, n, temp;
    const char *a="Writing byte by byte\n";
    const char *b="Writing using buffers\n";
    unsigned long i, bytes_to_write = BYTES_TO_READ_WRITE, bytes_to_read = BYTES_TO_READ_WRITE;
    char ch;

    while(1)
    {
        printf("\n 1 - Write without buffering \n 2 - Write with buffering");
        printf("\n 3 - Read without buffering \n 4 - Read with buffering");
        printf(("\n 5 - Exit \n Enter the option: "));
        scanf("%d", &option);
        switch(option)
        {
            case 1: /* Write without buffer */
                begin = clock();
                for (i=0;i<bytes_to_write;i++)
                {
                    ch = a[i%strlen(a)];
                    mywritec(ch);
                }
                end = clock();
                printf("\n Time to write without buffering: %f secs\n",(double)(end - begin)/CLOCKS_PER_SEC);
                break;

            case 2:  /* Write with buffer */
                printf("\n Enter the buffer size in bytes: ");
                scanf("%d", &n);
                mywritebufsetup(n);
                begin = clock();
                for (i=0;i<bytes_to_write;i++)
                {
                    ch = b[i%strlen(b)];
                    myputc(ch);
                }
                mywriteflush();
                end = clock();
                printf("\n Time to write with buffering: %f secs\n",(double)(end - begin)/CLOCKS_PER_SEC);
                break;

            case 3:  /* Read without buffer */
                fd_read = open(READABLE_FILE, O_RDONLY);
                if(fd_read < 0)
                {
                    printf("\n Error opening the readable file \n");
                    return 1;
                }
                begin = clock();
                for (i=0;i<bytes_to_read;i++)
                {  /* you may need to modify this slightly to print the character received and also check for end of file */
                    if(myreadc() == -1)
                    {
                        printf("\n End of file \n");
                        break;
                    }
                }
                end = clock();
                if(close(fd_read))
                {
                    printf("\n Error while closing the file \n ");
                }
                printf("\n Time to read without buffering: %f secs\n",(double)(end - begin)/CLOCKS_PER_SEC);
                break;

            case 4:  /* Read with buffer */
                printf("\n Enter the buffer size in bytes: ");
                scanf("%d", &n);
                myreadbufsetup(n);
                fd_read = open(READABLE_FILE, O_RDONLY);
                if(fd_read < 0)
                {
                    printf("\n Error opening the readable file \n");
                    return 1;
                }
                begin = clock();
                for (i=0;i<bytes_to_read;i++)
                { /* you may need to modify this slightly to print the character received and also check for end of file */
                    
                    
                    if(mygetc() == -1)
                    {
                        printf("\n End of file \n");
                        break;
                    }
                }
                end = clock();
                if(close(fd_read))
                {
                    printf("\n Error while closing the file \n ");
                }
                printf("\n Time to read with buffering: %f secs\n",(double)(end - begin)/CLOCKS_PER_SEC);
                break;

            default:
                return 0;
        }
    }
}
