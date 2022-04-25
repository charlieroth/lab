#include <iostream>

void printMax(int Arr[5]) {
    int Max = Arr[0];
    for (int I = 0; I < 5; I++) {
        if (Max < Arr[I]) Max = Arr[I];
    }
    std::cout << "max num in array: " << Max << std::endl;
}

int main(int argc, char *argv[]) {
    int Arr[5] = {0, 10, 20, 30, 40};
    for (int I : Arr) {
        std::cout << I << std::endl;
    }
    printMax(Arr);
    return 0;
}
