//
//  main.m
//  Prototype
//
//  Created by xiang lin on 2020/6/8.
//  Copyright © 2020 xiang lin. All rights reserved.
//

/**
 建造者模式：将一个复杂对象的构建与它的表现分离，使得同样的构建过程可以创建不同的表现
 构建过程分为:客户-指导-生成器 Client - Director - Builder
 */

#import <iostream>
#import <string>
//最终产品
class IHouse{
public:
    virtual ~IHouse(){}
protected:
    int _foundationCount;
    int _cementFrameCount;
    int _brickCount;
    int _wattsCout;
    int _pipeCount;
    int _windowCount;
public:
    virtual void setfoundationCount(int count) = 0;
    
    virtual void setCementFrameCount(int count) = 0;
    
    virtual void setBrickCount(int count) = 0;
    
    virtual void setWattsCout(int count) = 0;
    
    virtual void setPipeCount(int count) = 0;
    
    virtual void setWindowCount(int count) = 0;
};

//别墅
class Villa:public IHouse{
    void setfoundationCount(int count){
        _foundationCount = count;
        std::cout << "构建别墅地基个数:" << _foundationCount <<std::endl;
    }
    void setCementFrameCount(int count){
        _cementFrameCount = count;
        std::cout << "构建别墅水泥构建个数:" << _cementFrameCount <<std::endl;
    }
    void setBrickCount(int count){
        _brickCount = count;
        std::cout << "构建别墅砖的个数:" << _brickCount <<std::endl;
    }
    void setWattsCout(int count){
        _wattsCout = count;
        std::cout << "构建别墅瓦片数:" << _wattsCout <<std::endl;
    }
    void setPipeCount(int count){
        _pipeCount = count;
        std::cout << "构建别墅管道个数:" << _pipeCount <<std::endl;
    }
    void setWindowCount(int count){
        _windowCount = count;
        std::cout << "构建别墅窗子个数:" << _windowCount <<std::endl;
    }
};

//民房
class PrivateHouse:public IHouse{
    void setfoundationCount(int count){
        
    }
    void setCementFrameCount(int count){
       
    }
    void setBrickCount(int count){
        
    }
    void setWattsCout(int count){
      
    }
    void setPipeCount(int count){
       
    }
    void setWindowCount(int count){
     
    }
};

//建造者接口
class IBuilder{
public:
    virtual ~IBuilder(){}
public:
    //地基
    virtual void buildFoundation() = 0;
    //水泥框架
    virtual void buildCementFramework() = 0;
    //墙
    virtual void buildWall() = 0;
    //砖
    virtual void buildBrick() = 0;
    //瓦
    virtual void buildWatts() = 0;
    //管道
    virtual void buildPipe() = 0;
    //窗户
    virtual void buildWindow() = 0;

    virtual IHouse* getBuildResult() = 0;
};

//别墅构造
class ViallaBuilder:public IBuilder{
private:
    IHouse*     _house;
public:
    ViallaBuilder(IHouse* house){
        _house = house;
    }
public:
    void buildFoundation(){
        std::cout << "开始构建别墅地基" << std::endl;
        _house -> setfoundationCount(1);
    }
      //水泥框架
    void buildCementFramework(){
        std::cout << "开始构建别墅水泥框架" << std::endl;
         _house -> setCementFrameCount(20);
    }
      //墙
    void buildWall(){
        std::cout << "开始构建别墅墙" << std::endl;
         _house -> setWattsCout(90);
    }
      //砖
    void buildBrick(){
        std::cout << "开始构建别墅砖" << std::endl;
        _house -> setBrickCount(29900);
    }
      //瓦
    void buildWatts(){
        std::cout << "开始构建别墅瓦" << std::endl;
        _house -> setWattsCout(5000);
    }
      //管道
    void buildPipe(){
        std::cout << "开始构建别墅管道" << std::endl;
        _house -> setPipeCount(100);
    }
      //窗户
    void buildWindow(){
        std::cout << "开始构建别墅窗户" << std::endl;
        _house -> setCementFrameCount(20);
    }
    
    IHouse* getBuildResult(){
        return _house;
    }
};

//民房建造者
class PrivateHouseBuilder:public IBuilder{
private:
    IHouse*     _house;
public:
    PrivateHouseBuilder(IHouse* house){
        _house = house;
    }
public:
    void buildFoundation(){
        std::cout << "构建民房地基" << std::endl;
    }
      //水泥框架
    void buildCementFramework(){
        std::cout << "构建民房水泥框架" << std::endl;
    }
      //墙
    void buildWall(){
        std::cout << "构建民房墙" << std::endl;
    }
      //砖
    void buildBrick(){
        std::cout << "构建民房砖" << std::endl;
    }
      //瓦
    void buildWatts(){
        std::cout << "构建民房瓦" << std::endl;
    }
      //管道
    void buildPipe(){
        std::cout << "构建民房管道" << std::endl;
    }
      //窗户
    void buildWindow(){
        std::cout << "构建民房窗户" << std::endl;
    }
    
    IHouse* getBuildResult(){
        return _house;
    }
};

//指导者
class Director{
public:
    IHouse* constructorVialla(IBuilder* builder){
        builder -> buildFoundation();
        builder -> buildCementFramework();
        builder -> buildWall();
        builder -> buildBrick();
        builder -> buildWatts();
        builder -> buildPipe();
        builder -> buildWindow();
        return builder -> getBuildResult();
    }
    
    IHouse* constructorPrivateHouse(IBuilder* builder){
        builder -> buildFoundation();
        builder -> buildCementFramework();
        builder -> buildWall();
        builder -> buildBrick();
        builder -> buildWatts();
        builder -> buildPipe();
        builder -> buildWindow();
        return builder -> getBuildResult();
    }
};
//client 充当客户端
int main(int argc, const char * argv[]) {
    // insert code here...
    Director* director = new Director();
    
    IBuilder* viallaBuilder = new ViallaBuilder(new Villa());
    IHouse* viallaHouse = director -> constructorVialla(viallaBuilder);
    
    IBuilder* privateHouseBuilder = new PrivateHouseBuilder(new PrivateHouse());
    IHouse* privateHouseHouse =  director -> constructorPrivateHouse(privateHouseBuilder);

    return 0;
}

