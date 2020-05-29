
#import <Foundation/Foundation.h>
#import <set>
#import <iostream>
using namespace::std;

typedef enum : NSUInteger {
    kUIWindowEvent,
    kUIScrollerViewEvent,
    kTableViewEvent,
    kLabelViewEvent,
}KEvent;

class IUIView{
protected:
    std::string _name;
    KEvent      _event;
public:
    IUIView*    _nextHanlder;
public:
    virtual ~IUIView() {};
public:
    virtual void handler(KEvent event) = 0;
    virtual void addSubView(IUIView* view) = 0;
};

class UIView:public IUIView{

public:
    void handler(KEvent event){
        std::cout <<" 我是UIView基类，任何事件我都能处理" <<std::endl;
    };
    void addSubView(IUIView* view){
        if (!view) {
            return;
        }
        view -> _nextHanlder = this;
    }
    
    void nextHanlder(KEvent event){
        if (_nextHanlder) {
            _nextHanlder -> handler(event);
        }else{
            handler(event);
        }
    }
};

class UIWindow:public UIView{
public:
    void handler(KEvent event){
        if (event == kUIWindowEvent) {
            std::cout <<"我是窗口，我处理了这个事件" <<std::endl;
        }else{
            nextHanlder(event);
        }
    }
};

class UIScrollerView:public UIView{
public:
    void handler(KEvent event){
       if (event == kUIScrollerViewEvent) {
            std::cout <<"我是滚动视图，我处理了这个事件" <<std::endl;
        }else{
            nextHanlder(event);
        }
    }
};

class UILabel:public UIView{
public:
    void handler(KEvent event){
       if (event == kLabelViewEvent) {
            std::cout <<"我是标签，我处理了这个事件" <<std::endl;
        }else{
            nextHanlder(event);
        }
    }
};

class UITableView:public UIScrollerView{
public:
    void handler(KEvent event){
       if (event == kTableViewEvent) {
            std::cout <<"我是表格视图，我处理了这个事件" <<std::endl;
        }else{
            nextHanlder(event);
        }
    }
};

//合成部件视图，具备添加子视图的能力
int main(int argc, const char * argv[]) {
    @autoreleasepool {
    
        IUIView* window = new UIWindow();
        IUIView* scrollView = new UIScrollerView();
        window -> addSubView(scrollView);
        IUIView* tableView = new UITableView();
        scrollView -> addSubView(tableView);
        IUIView* label = new UILabel();
        tableView -> addSubView(label);

        //1、kUIWindowEvent,产生窗口事件
        label -> handler(kUIWindowEvent);
        //2、kUIScrollerViewEvent,产生滚动事件
        label -> handler(kUIScrollerViewEvent);
        //3、kTableViewEvent,产生表格事件
        label -> handler(kTableViewEvent);
        //4、kLabelViewEvent,产生标签事件
        label -> handler(kLabelViewEvent);

    }
    return 0;
}

/**

 */
