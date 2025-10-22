#include <gtest/gtest.h>
#include "mylib.h"

TEST(CalculatorTest, Addition) {
    mylib::Calculator calc;
    ASSERT_EQ(calc.add(2, 3), 5);
    ASSERT_EQ(calc.add(-1, 1), 0);
    ASSERT_EQ(calc.add(0, 0), 0);
}

TEST(CalculatorTest, Subtraction) {
    mylib::Calculator calc;
    ASSERT_EQ(calc.subtract(5, 3), 2);
    ASSERT_EQ(calc.subtract(0, 5), -5);
    ASSERT_EQ(calc.subtract(10, 10), 0);
}

TEST(CalculatorTest, Multiplication) {
    mylib::Calculator calc;
    ASSERT_EQ(calc.multiply(4, 5), 20);
    ASSERT_EQ(calc.multiply(-2, 3), -6);
    ASSERT_EQ(calc.multiply(0, 100), 0);
}

TEST(CalculatorTest, Division) {
    mylib::Calculator calc;
    ASSERT_DOUBLE_EQ(calc.divide(10, 2), 5.0);
    ASSERT_DOUBLE_EQ(calc.divide(7, 2), 3.5);
    ASSERT_THROW(calc.divide(5, 0), std::invalid_argument);
}

TEST(GreetTest, BasicGreeting) {
    ASSERT_EQ(mylib::greet("Alice"), "Hello, Alice!");
    ASSERT_EQ(mylib::greet(""), "Hello, !");
}
