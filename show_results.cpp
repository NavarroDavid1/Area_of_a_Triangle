#include <iostream>
#include <iomanip>

extern "C" {
    void show_results(double side1, double side2, double side3, double area);
}

void show_results(double side1, double side2, double side3, double area) {
    std::cout << "The area of a triangle with sides "
              << std::fixed << std::setprecision(10)
              << side1 << ", " << side2 << ", and " << side3
              << " is " << area << " square units.\n";
}
