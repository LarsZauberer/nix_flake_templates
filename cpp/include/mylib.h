#pragma once

#include <string>

namespace mylib {

class Calculator {
public:
    int add(int a, int b);
    int subtract(int a, int b);
    int multiply(int a, int b);
    double divide(int a, int b);
};

std::string greet(const std::string& name);

}