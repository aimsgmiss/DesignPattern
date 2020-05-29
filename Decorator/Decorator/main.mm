//
//  main.m
//  Decorator
//
//  Created by xiang lin on 2020/5/25.
//  Copyright © 2020 xiang lin. All rights reserved.
//


#import <Foundation/Foundation.h>
#include <string>
#include <iostream>
using namespace::std;
class Hamburger{
public:
    Hamburger(){
    }
    ~Hamburger(){
    }
public:
    virtual float get_privice(){
        return 0.0f;
    }
    virtual std::string get_name(){
       return "";
    }
};

class ChickerHamburger:public Hamburger{
public:
    float get_privice(){
        return 11.0f;
    }
    std::string get_name(){
        return "鸡腿汉堡包";
    }
};

class BeefHamburger:public Hamburger{
public:
    float get_privice(){
        return 12.0f;
    }
    std::string get_name(){
        return "牛肉汉堡包";
    }
};

//调料
class Condiment:public Hamburger{
protected:
    Hamburger* _hamburger;
public:
    Condiment(){

    }
    Condiment(Hamburger* hamburger):_hamburger(hamburger){
    }
};

class Chilli: public Condiment{
    
public:
    Chilli(Hamburger* hamburger){
        this -> _hamburger = hamburger;
    }
    float get_privice(){
       return 2.0f + _hamburger -> get_privice();
    }
    std::string get_name(){
       return " 辣椒 + " + _hamburger -> get_name();
    }
};

class Cream: public Condiment{
    
public:
    Cream(Hamburger* hamburger){
       this -> _hamburger = hamburger;
    }
   float get_privice(){
       return 2.0f + _hamburger -> get_privice();
    }
   std::string get_name(){
       return " 奶油 + " + _hamburger -> get_name();
   }
};

class Egg: public Condiment{
public:
    Egg(Hamburger* hamburger){
      this -> _hamburger = hamburger;
    }
    
   float get_privice(){
       return 4.0f + _hamburger -> get_privice();
    }
    
   std::string get_name(){
       return " 鸡蛋 + " + _hamburger -> get_name();
   }
};

class essence: public Condiment{
public:
    essence(Hamburger* hamburger){
        this -> _hamburger = hamburger;
    }
   float get_privice(){
       return 2.0f + _hamburger -> get_privice();
    }
   std::string get_name(){
       return " 香精 + " + _hamburger -> get_name();
   }
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Hamburger* hamburger = new BeefHamburger();
        std::cout << hamburger -> get_name() << " 价格:" << hamburger -> get_privice() << std::endl;
        
        hamburger = new essence(hamburger);
        std::cout << hamburger -> get_name() << " 价格:" << hamburger -> get_privice() << std::endl;
        
        hamburger = new Egg(hamburger);
        std::cout << hamburger -> get_name() << " 价格:" << hamburger -> get_privice() << std::endl;
        
        hamburger = new Cream(hamburger);
        std::cout << hamburger -> get_name() << " 价格:" << hamburger -> get_privice() << std::endl;
        
        hamburger = new Chilli(hamburger);
        std::cout << hamburger -> get_name() << " 价格:" << hamburger -> get_privice() << std::endl;
        
        hamburger = new Egg(hamburger);
        std::cout << hamburger -> get_name() << " 价格:" << hamburger -> get_privice() << std::endl;
    }
    return 0;
}
