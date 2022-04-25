#include <iostream>

int main(int argc, char* argv[]) {
    int Num = 30;
    int *P = &Num;
    std::cout << "Address of 'Num' variable is: " << &Num << std::endl;
    std::cout << "Address of 'P' variable is: " << P << std::endl;
    std::cout << "Value of 'Num' variable is: " << Num << std::endl;
    std::cout << "Value of 'P' variable is: " << *P << std::endl;
    return 0;
}
