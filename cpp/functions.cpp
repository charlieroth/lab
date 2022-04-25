#include <iostream>

// Call By Value
void change(int Data) {
    std::cout << "Call by value: change()" << std::endl;
    Data = 5;
}

// Call By Reference
void swap(int *X, int *Y) {
    std::cout << "Call by reference: swap()" << std::endl;
    int Temp = *X;
    *X = *Y;
    *Y = Temp;
}

int main(int argc, char* argv[]) {
    int Data = 10;
    std::cout << "Data = " << Data << std::endl;
    change(Data);
    std::cout << "Data = " << Data << std::endl;
    
    int Data2 = 20;
    swap(&Data, &Data2);
    std::cout << "Data = " << Data << std::endl;
    return 0;
}
