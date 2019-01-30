//
//  main.cpp
//  StudyC
//
//  Created by xiAo_Ju on 2018/11/17.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#include <iostream>
#include <cmath>
#include "MyStruct.cpp"
#include "Clock.hpp"

#include "CombinationSumII.cpp"

using namespace std;

const float PI = 3.14;

const double TINY_VALUE = 1e-10;

void doWhile() {
    int i = 1, sum = 0;
    
    do {
        sum += i;
        i += 1;
    } while (i <= 10);
    
    cout << sum << endl;
}

void shapeArea() {
    int iType;
    float radius, a, b, area = 0.0;
    
    cout << "图形的类型为？（1.圆形 2.长方形 3.正方形）：";
    cin >> iType;
    switch (iType) {
        case 1:
            cout << "圆的半径为：";
            cin >> radius;
            area = radius * radius * PI;
            break;
        case 2:
            cout << "长方形的宽：";
            cin >> a;
            cout << "长方形的长：";
            cin >> b;
            area = a * b;
            break;
        case 3:
            cout << "正方形的边长：";
            cin >> a;
            area = a * a;
            break;
    }
    cout << "面积为：" << area << endl;
}

double arctan(double x) {
    double sqr = x * x;
    double e = x;
    double r = 0;
    int i = 1;
    while (e / i > 1e-15) {
        double f = e / i;
        r = (i % 4 == 1) ? r + f : r - f;
        e = e * sqr;
        i += 2;
    }
    
    return r;
}

double tsin(double x) {
    double g = 0;
    double t = x;
    int n = 1;
    do {
        g += t;
        n += 1;
        t = -t * x * x / (2 * n - 1) / (2 * n - 2);
    } while (fabs(t) >= TINY_VALUE);
    return g;
}

void calculate() {
    double a = 16 * arctan(1/5.0);
    double b = 4 * arctan(1/239.0);
    
    cout << a - b << endl;
}

bool symm(unsigned n) {
    unsigned i = n;
    unsigned m = 0;
    while (i > 0) {
        m = m * 10 + i % 10;
        i /= 10;
    }
    return m == n;
}

int common(int n, int k) {
    if (k > n) {
        return 0;
    } else if (n == k || k == 0) {
        return 1;
    } else {
        return common(n - 1, k) + common(n - 1, k - 1);
    }
}

void move(char src, char dest) {
    cout << src << "->" << dest << endl;
}

void hanoi(int n, char src, char medium, char dest) {
    if (n == 1) {
        move(src, dest);
    } else {
        hanoi(n - 1, src, medium, dest);
        move(src, dest);
        hanoi(n - 1, medium, src, dest);
    }
}

void swap(int &a, int &b) {
    int t = a;
    a = b;
    b = t;
}

int sumOfSquare(int a, int b) {
    return a * a + b * b;
}

double sumOfSquare(double a, double b) {
    return a * a + b * b;
}

int fib(int n) {
    if (n == 1 || n == 2) {
        return 1;
    }
    return fib(n - 2) + fib(n - 1);
}

int main(int argc, const char * argv[]) {
    // insert code here...
//    int radius;
//    cout << "请输入:\n";
//    cin >> radius;
//    cout << "结果为:" << radius;
    
//    doWhile();
    
//    MyTimeStruct myTime = {2018, 11, 24, 16, 3, 0};
    
//    cout << myTime.year << endl;
    
//    shapeArea();
    
//    calculate();
    
    hanoi(3, 'A', 'B', 'C');
    
    int a = 5, b = 10;
    swap(a, b);
    cout << a << b << endl;
    
    
    cout << sumOfSquare(5, 6) << endl;
    
    cout << sumOfSquare(5.2, 6.1) << endl;
    
    cout << fib(5) << endl;
    
    Clock c(0, 0, 0);
    
    Clock c2;
    c2.setTime()
    c.showTime();
    
    return 0;
}
