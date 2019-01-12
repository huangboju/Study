//
//  Clock.hpp
//  StudyC
//
//  Created by 黄伯驹 on 2018/11/28.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#ifndef Clock_hpp
#define Clock_hpp

#include <stdio.h>

class Clock {
public:
    Clock(int newH, int newM, int newS);
    
    Clock();
    
    ~Clock();
    
    void setTime();
    
    void showTime();
    
private:
    int hour, minute, second;
};

#endif /* Clock_hpp */
