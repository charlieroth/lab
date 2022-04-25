#include <iostream>

void ifElseIf() {
    int Age;
    std::cout << "Enter your age: ";
    std::cin >> Age;

    if (Age <= 0) {
        std::cout << Age << " is not a valid age" << std::endl;
        return;
    }

    if (Age < 21) {
        std::cout << "You can not buy alcohol" << std::endl;
    } else if (Age >= 25) {
        std::cout << "You can rent a car and buy alcohol" << std::endl;
    } else {
        std::cout << "You can buy alcohol but not rent a car" << std::endl;
    }
}

void switchStatment() {
    int Age;
    std::cout << "Enter your age: ";
    std::cin >> Age;

    switch (Age) {
        case 10:
            std::cout << "You are 10 years old" << std::endl;
            break;
        case 20:
            std::cout << "You are 20 years old" << std::endl;
            break;
        case 30:
            std::cout << "You are 30 years old" << std::endl;
            break;
        default:
            std::cout << "You are " << Age << " years old" << std::endl;
            break;
    }
}

void forLoop() {
    for (int I = 5; I >= 0; I--) {
        std::cout << I << std::endl;
    }
    std::cout << "Lift off!" << std::endl;
}

int main(int argc, char *argv[]) {
    // ifElseIf();
    // switchStatment();
    forLoop();
    return 0;
}
