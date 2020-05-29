

//
/**
 
 命令模式：
 将请求封装成对象，然后对对象进行参数化，这样可以做到请求，撤销操作；
 1、c++版本：遥控器控制空调
    1.1、空调充当接受者receiver;
    1.2、遥控器充当invoker;
    1.3、遥控器按下开，关，加大温度，降低温度充当具体的命令;
 我们使用遥控器以命令的形式控制空凋的各种状态；
 2、NSInvocation充当具体的命令，我们参数化根据NSInvocation提供的
 各个属性进行设置，在外部调用的时候，设置Target-action,Target即我们具体对象对应receiver,
 action对应我们的具体动作如selector,具体命令需要在NSInvocation对象中封装，具体应用在JS和Native
 调用中，可以根据不同的类，函数返回值，参数名称，参数个数不限制
 
 */
#import <Foundation/Foundation.h>
#import <iostream>
#import "NSInvocationTest.h"
// receiver
class AirConditioning{
public:
    void turnOn(){
        NSLog(@"AirConditioning turnOn");
    }
    
    void turnOff(){
        NSLog(@"AirConditioning turnOff");
    }
    
    void ChangeTemperature(int temperature){
        NSLog(@"AirConditioning ChangeTemperature:%d",temperature);
    }
};

class ICommand{
protected:
    AirConditioning* _air;
public:
    virtual void execute(){
        
    }
    
    virtual void execute(int temperature){
           
    }
    
    virtual ~ICommand(){
        std::cout<<"~ICommand() invoke"<<std::endl;
    }
};

class CommandTurnOn:public ICommand{
public:
    CommandTurnOn(AirConditioning* air){
        _air = air;
    }
    void execute() {
        if (_air) {
            _air -> turnOn();
        }
    }
};

class CommandTurnOff:public ICommand{
public:
    CommandTurnOff(AirConditioning* air){
        _air = air;
    }
    void execute() {
        if (_air) {
            _air -> turnOff();
        }
    }
};

class CommandChangeTemperature:public ICommand{
public:
   CommandChangeTemperature(AirConditioning* air){
        _air = air;
    }
    void execute(int temperature){
        if (_air) {
           _air -> ChangeTemperature(temperature);
        }
    }
};

// invoker
class RemoteController{
private:
    CommandTurnOn*               _commandTurnOn;
    CommandTurnOff*              _commandTurnOff;
    CommandChangeTemperature*    _commandChangeTemperature;
public:
    RemoteController(CommandTurnOn* on,CommandTurnOff* off,CommandChangeTemperature* temp){
        _commandTurnOn = on;
        _commandTurnOff = off;
        _commandChangeTemperature = temp;
    }
    
    void turnOn(){
        if (_commandTurnOn) {
            _commandTurnOn -> execute();
        }
    }
    
    void turnOff(){
        if (_commandTurnOff) {
            _commandTurnOff -> execute();
        }
    }
    
    void ChangeTemperature(int temperature){
        if (_commandChangeTemperature) {
           _commandChangeTemperature -> execute(temperature);
        }
    }
};

static id callSelector(NSString* className,NSString* selectorName,NSArray* parmeters){
    
    Class cls = NSClassFromString(className);
    id target = [[cls alloc] init];
    SEL selector = NSSelectorFromString(selectorName);
    NSMethodSignature* methodSignature = [target methodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setSelector:selector];
    [invocation setTarget:target];
    [parmeters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [invocation setArgument:&obj atIndex:idx + 2];
    }];
    [invocation invoke];
    
    char returnType[255];
    strcpy(returnType,[methodSignature methodReturnType]);
    switch (returnType[0]) {
        case 'v':
            
            break;
        case 'i':
        {
            int returnInt;
            [invocation getReturnValue:&returnInt];
            return @(returnInt);
        }
        case 'f':
        {
            float returnfloat;
            [invocation getReturnValue:&returnfloat];
            return @(returnfloat);
        }
        case '@':
        {
            id returnId;
            [invocation getReturnValue:&returnId];
            return returnId;
        }
        case 'd':
        {
            double returnDouble;
            [invocation getReturnValue:&returnDouble];
            return @(returnDouble);
        }
        default:
            //todo
            break;
         
    }
    id ret;

    return ret;
}

// client
int main(int argc, const char * argv[]) {
    @autoreleasepool {
    //C++ 命令模式
    AirConditioning* air = new AirConditioning();
    CommandTurnOn* commandTurnOn = new CommandTurnOn(air);
    CommandTurnOff* commandTurnOff = new CommandTurnOff(air);
    CommandChangeTemperature* commandChangeTemperature = new CommandChangeTemperature(air);
    RemoteController* invoker = new RemoteController(commandTurnOn,commandTurnOff,commandChangeTemperature);
    invoker -> turnOn();
    invoker -> turnOff();
    invoker -> ChangeTemperature(26);
    invoker -> ChangeTemperature(20);

    //Objective-C 命令模式之NSInvocation
    callSelector(@"NSInvocationTestA",@"testA:b:c:d:e:f:g:",@[@"aaa",@"bbb",@"ccc",@"ddd",@"ggg",@"ffff",@"SGGG"]);
    id retObjInt = callSelector(@"NSInvocationTestB",@"testB:b:c:d:e:f:g:",@[@"aaa",@"bbb",@"ccc",@"ddd",@"ggg",@"ffff",@"SGGG"]);
    id retObjFloat = callSelector(@"NSInvocationTestC",@"testC:b:c:d:e:f:g:",@[@"aaa",@"bbb",@"ccc",@"ddd",@"ggg",@"ffff",@"SGGG"]);
    id retObjId  = callSelector(@"NSInvocationTestD",@"testD:b:c:d:e:f:g:",@[@"aaa",@"bbb",@"ccc",@"ddd",@"ggg",@"ffff",@"SGGG"]);
    id retObjDouble  = callSelector(@"NSInvocationTestE",@"testE:b:c:d:e:f:g:",@[@"aaa",@"bbb",@"ccc",@"ddd",@"ggg",@"ffff",@"SGGG"]);
    NSLog(@"%@,%@,%@,%@",retObjInt,retObjFloat,retObjId,retObjDouble);
        
    }
    return 0;
}
