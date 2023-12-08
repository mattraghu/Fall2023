// C++ Experimentation

#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;

int main()
{
    /* Enter your code here. Read input from STDIN. Print output to STDOUT */
    vector<vector<int> *> a;

    // Lets set the first element to a vector of size 5 and set all elements to x
    int x = 7;
    // a.push_back(new vector<int>(5, x));
    vector<int> a_0 = vector<int>(5, x);

    // Set the first element to 10
    a_0[0] = 10;

    a.push_back(&a_0);

    // Print the first element
    cout << a[0]->at(0) << endl;

    // Another way
    cout << (*a[0])[0] << endl;

    // Lets add an empty vector to the second element of a
    vector<int> a_1;
    a.push_back(&a_1);

    // Lets add 5 elements to the second element of a
    for (int i = 3; i < 5; i++)
    {
        // a[1]->push_back(i);
        // How does this work?
        // a[1] is a pointer to a vector
        // -> is used instead of . because a[1] is a pointer
        // We could have also used
        // (*a[1]).push_back(i); // This is the same as a[1]->push_back(i);
        a_1.push_back(i); // This also works
    }

    // Print the second element
    cout << a[1]->at(0) << endl;

    return 0;
}
