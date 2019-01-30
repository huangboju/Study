//
//  Clock.cpp
//  StudyC
//
//  Created by 黄伯驹 on 2018/11/28.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#include "Clock.hpp"

#include <iostream>

using namespace std;

Clock::Clock(int newH, int newM, int newS):
hour(newH), minute(newM), second(newS) {
    
}

Clock::Clock():Clock(0, 0, 0) {
    
}

Clock::~Clock() {
    
}

//Clock::Clock(const Clock &c) noexcept {
//    hour = c.hour;
//    minute = c.minute;
//    second = c.second;
//}

inline void Clock::showTime() {
    cout << hour << ":" << minute << ":" << second << endl;
}

void Clock::setTime() {
    
}
