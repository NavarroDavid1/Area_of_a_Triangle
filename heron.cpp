#include <iostream>
#include <iomanip>

// External assembly function declaration
extern "C" {
    double triangle();
}

int main() {
    std::cout << "Welcome to CIS/CSC-11, Area of a Triangle brought to you by C++/Assembly Student.\n";
    
    // Call the assembly manager function
    double the_area = triangle();
    
    // Print final result
    std::cout << std::fixed << std::setprecision(10);
    std::cout << "Heron received this number: " << the_area << ".\n";
    std::cout << "Have a nice day. The program will return control to the operating system.\n";
    
    return 0;
}
