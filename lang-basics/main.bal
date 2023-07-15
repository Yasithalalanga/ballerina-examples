import ballerina/io;

// module-level variable
string greeting = "Hello";

public function main() {
    // local (function-level) variable
    string name = "Ballerina";
    io:println(greeting, " ", name);

    // Function to add two numbers
    int summation = add(10, 30);
    io:println("Sum of 10 & 30 :", summation);

    // Floating point number
    int n = 2;
    float x = 1.0;
    float y = x + <float>n;
    io:println("Float summation: ", y);


}

// Function to add two number
public function add(int x, int y) returns int {
    int sum = x + y;
    return sum;
}