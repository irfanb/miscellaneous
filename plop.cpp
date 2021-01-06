#include <iostream>
#include <algorithm>
#include <functional>
#include <vector>

bool isOdd( const int num ) {
    return num % 2 != 0;
}

void populateVector( std::vector<int>& v ) {
    int in;
    std::cout << "Please enter 10 odd numbers" << std::endl;
    while ( v.size() < 10 ) {
        std::cout << "Please enter an odd number" << std::endl;
        std::cin >> in;
        if ( isOdd( in ) ) {
            v.push_back( in );
        } else {
            std::cout << in << " is not an odd number, try again" << std::endl;
        }
    }
}

int calculateAverage( const std::vector<int>& v ) {
    int average = 0;
    int sum = 0;
    for ( const int& n : v ) {
        sum += n;
    }
    average = sum / v.size();
    return average;
}

int main() {
    std::vector<int> v;
    populateVector( v );
    int average = calculateAverage( v );
    int numberOfItemsLargerThanTheAverage = std::count_if( v.begin(), v.end(), [average]( int n ){ return n > average; } );
    std::cout << "Average is " << average << std::endl;
    std::cout << "Number of items greater than average is " << numberOfItemsLargerThanTheAverage << std::endl;
    return 0;
}
