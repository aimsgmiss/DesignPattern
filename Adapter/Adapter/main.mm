
/**
 
 块在视图控制器中声明，让块能过捕获UI控件，同时将块作为参数传入到其他模块
 其他模块copy块，在任何时候，这样其他模块能够捕获到UI控件中最新的数据

 */
#import <iostream>
using namespace std;
class ITarget{
public:
    virtual void target() = 0;
};

class Adaptee{
public:
    void doSomething(){
        std::cout << "do something" <<std::endl;
    }
};

class Adapter: public ITarget{
private:
    Adaptee* mAdaptee;
public:
    Adapter(Adaptee* adaptee):mAdaptee(adaptee){}
    void target(){
        mAdaptee -> doSomething();
    }
};

int main(int argc, const char * argv[]) {
    ITarget* target = new Adapter(new Adaptee);
    target -> target();
    return 0;
}
