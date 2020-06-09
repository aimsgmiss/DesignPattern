//
//  main.m
//  Strategy
//
//  Created by xiang lin on 2020/6/8.
//  Copyright © 2020 xiang lin. All rights reserved.
//
/**
 策略模式：把相关算法分离为不同的类，称为策略，这些算法可以相互替换，本模式使得算法可独立于使用它的客户而变化
 
 根据Objective-C编程之道iOS设计模式解析：对UITextField内容进行检验
 策略1：验证文本框的内容全为数字
 策略2：验证文本框内容全为字母
 策略3：验证文本框内容为数字+字母
 策略4：...
 .
 .
 .
 
 优点：
 策略类可以在其它模块重复使用，便于维护与扩充
 缺点：
 如果策略过多，可能导致策略类的数目庞大
 */

#import <string>
#import <iostream>
using namespace std;
class IStrategy{
public:
    ~IStrategy(){}
public:
   virtual bool doMethod(std::string str) const = 0;
};

class ByCarStrategy:public IStrategy{
public:
    bool doMethod(std::string str) const{
        std::cout << "选择坐汽车" << std::endl;
        return true;
    }
};

class ByBikeStrategy:public IStrategy{
public:
    bool doMethod(std::string str) const{
        std::cout << "选择骑自车" << std::endl;
        return true;
    }
};

class ByBoatStrategy:public IStrategy{
public:
    bool doMethod(std::string str) const{
        std::cout << "选择坐轮船" << std::endl;
        return true;
    }
};

class ByPlaneStrategy:public IStrategy{
public:
    bool doMethod(std::string str) const{
        std::cout << "选择坐飞机" << std::endl;
        return true;
    }
};

class BySpaceShipStrategy:public IStrategy{
public:
    bool doMethod(std::string str) const{
           std::cout << "选择坐飞船" << std::endl;
           return true;
       }
};

class Context{
private:
    IStrategy*  _strategy;
public:
    void chooseVehicle(){
        if (_strategy) {
            _strategy -> doMethod("strategy");
        }
    }
    void setStrategy(IStrategy* strategy){
        _strategy = strategy;
    }
};

int main(int argc, const char * argv[]) {
    
    Context* p = new Context();
    p -> setStrategy(new ByPlaneStrategy());
    p -> chooseVehicle();
    
    p -> setStrategy(new ByBoatStrategy());
    p -> chooseVehicle();
    
    p -> setStrategy(new BySpaceShipStrategy());
    p -> chooseVehicle();

    return 0;
}

