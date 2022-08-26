#include <iostream>
#include <stdlib.h>
#include <time.h> 
using namespace std; 
int main()
{ 
    int weather[10] = {0};
    srand((unsigned)time(NULL)); 
    for(int i = 0; i < 10;i++ ) {
        double res = rand()/double(RAND_MAX);
        cout<<res<<endl;
        if (res <= 0.3889)
            weather[i] = 0;
        else 
            weather[i] = 1;
    }
    for(int i = 0; i < 10; i++) {
        cout<<weather[i]<<" ";
    }
    return 0;
}

