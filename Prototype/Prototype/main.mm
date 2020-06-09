//
//  main.m
//  Prototype
//
//  Created by xiang lin on 2020/6/8.
//  Copyright © 2020 xiang lin. All rights reserved.
//

/**
 
 原型模式：使用原型实例指定创建对象的种类，并通过复制这个原型创建新的对象
 
 Objective-C 实现原型模式应用场景:
 Cocoa Touch框架为Object的派生类提供了实现深复制的协议
 NSObject的子类需要实现NSCopying协议及方法 - (id)copyWithZone:(nullable NSZone *)zone
 否则发送copy消息引发异常。
 1、

 */

#import <iostream>
#import <string>
class IPrototype{
public:
    std::string  _otherthing;
public:
    virtual IPrototype* clone()  = 0;
    virtual void print()  = 0;
};

class PrototyeRoot1:public IPrototype{
protected:
    int         _age;
    std::string _name;
public:
    PrototyeRoot1(){}
    PrototyeRoot1(int age,std::string name,std::string otherthing){
        _age = age;
        _name = name;
        _otherthing = otherthing;
    }
    
    IPrototype* clone(){
        PrototyeRoot1* copyObj = new PrototyeRoot1();
        copyObj -> _age = _age;
        copyObj -> _name = _name;
        copyObj -> _otherthing = _otherthing;
        return copyObj;
    }
    
    void print(){
        std::cout << "age:" << _age << " name:" << _name << " otherthing:" << _otherthing << std::endl;
    }
};

class PrototyeRoot2:public IPrototype{
protected:
    int         _age;
    std::string _name;
    std::string _address;
    int         _telphone;
public:
    PrototyeRoot2(){}
    PrototyeRoot2(int age,std::string name,std::string address,int telphone,std::string otherthing){
        _age = age;
        _name = name;
        _telphone = telphone;
        _address = address;
        otherthing = otherthing;
    }
    
    IPrototype* clone(){
        PrototyeRoot2* copyObj = new PrototyeRoot2();
        copyObj -> _age = _age;
        copyObj -> _name = _name;
        copyObj -> _address = _address;
        copyObj -> _telphone = _telphone;
        copyObj -> _otherthing = _otherthing;
        return copyObj;
    }
    
    void print(){
        std::cout << "age:" << _age << " name:" << _name << " address:" << _address << " telphone:" << _telphone << " otherthing:" << _otherthing << std::endl;
    }
};

//client 充当客户端
int main(int argc, const char * argv[]) {
    // insert code here...
    IPrototype* prototypeObj = new PrototyeRoot1(15,"aimsgmiss","othering1");
    IPrototype* newPrototypeObj= prototypeObj -> clone();
    newPrototypeObj -> _otherthing = "拷贝而来做其他事,与之前不一样1";
    newPrototypeObj -> print();
    
    prototypeObj = new PrototyeRoot2(15,"jike","middle shcool",123455,"othering2");
    newPrototypeObj= prototypeObj -> clone();
    newPrototypeObj -> _otherthing = "拷贝而来做其他事，与之前不一样2";
    newPrototypeObj -> print();
    
    return 0;
}

