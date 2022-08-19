#include <iostream>
#include "sha.h"

int main()
{
    char data[] = "Hello World!";
    string sha256 = SHA256(data);
    cout << sha256;
}