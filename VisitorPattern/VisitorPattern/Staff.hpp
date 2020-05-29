//
//  Staff.hpp
//  VisitorPattern
//
//  Created by xiang lin on 2020/5/25.
//  Copyright © 2020 xiang lin. All rights reserved.
//

#ifndef Staff_hpp
#define Staff_hpp

#include <stdio.h>
#include "Visitor.hpp"

class Staff{

public:
    int age;
public:
    Staff(){
    }
    
    ~Staff(){
    }
    
    virtual void accept(Visitor* visitor){
    }
};

class Engine:public Staff{
    
public:
    
    Engine(){
        age  = random() % 50;
    }
    
    ~Engine(){
    }
    
    inline void accept(Visitor* visitor){
        visitor -> visitor(this);
    }
    
    inline int getCodeLines(){
        return random() % 900000;
    }
    
    inline int kpi(){
        return random() % 10;;
    }
    
    inline int monthSalary(){
        return random() % 20000;
    }
};

class Manager:public Staff{
public:
    Manager(){
        age = random() % 50;
    }
    
    ~Manager(){
        
    }
    
    inline void accept(Visitor* visitor){
        visitor -> visitor(this);
    }
    
    inline int getProducts(){
        return random() % 50;
    }
    
    inline int kpi(){
        return random() % 50;
    }
    
    inline int monthSalary(){
        return random() % 50000;
    }
};


#endif /* Staff_hpp */
