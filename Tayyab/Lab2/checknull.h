
/*
    Name: checknull.h
    Author: Muhammad Tayyab
    Date: 10-7-2024
    Description: Defines inline functions to catch null pointers
*/

// Macro to check if a pointer is NULL
#define CHECKNULL(ptr) if(ptr==NULL)return(1)
// Macro to check if a pointer is NULL for functions returning void
#define CHECKNULLv(ptr) if(ptr==NULL)return