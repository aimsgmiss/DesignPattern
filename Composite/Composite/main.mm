

#import <Foundation/Foundation.h>
#import <set>
#import <iostream>

using namespace::std;
class IUIView{
protected:
    std::string _name;
public:
    virtual ~IUIView() {};
public:
    virtual void insert(IUIView* view) = 0;
    virtual void remove(IUIView* view) = 0;
    virtual void drawRect(float x,float y,float width,float height) = 0;
};

//叶子视图，不具备添加子视图的能力
class LeafView:public IUIView{
    
public:
    virtual ~LeafView(){}
    LeafView(std::string name){
        _name = name;
    }
    void insert(IUIView* view){

    }
    void remove(IUIView* view){

    }
    void drawRect(float x,float y,float width,float height){
        std::cout <<" LeafView drawRect name:"<< _name <<std::endl;
    }
};

//合成部件视图，具备添加子视图的能力
class ComponentView:public IUIView{
private:
    std::set<IUIView*> _set;
public:
    virtual ~ComponentView(){}
    ComponentView(std::string name){
        _name = name;
    }
    void insert(IUIView* view){
        if (!view) {
            return;
        }
        _set.insert(view);
    }
    void remove(IUIView* view){
        if (!view) {
            return;
        }
        _set.erase(view);
    }
    void drawRect(float x,float y,float width,float height){
        
        for (std::set<IUIView*>::iterator iter = _set.begin(); iter != _set.end();++iter) {
            ((IUIView*)(*iter)) -> drawRect(x, y, width, height);
        }
        std::cout <<" ComponentView drawRect name:" << _name <<std::endl;
    }
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        IUIView* rootView = new ComponentView("rootView");
        
        IUIView* componentView1 = new ComponentView("componentView1");
        IUIView* componentView2 = new ComponentView("componentView2");
        
        IUIView* leafView1_1 = new LeafView("leafView1_1");
        IUIView* leafView1_2 = new LeafView("leafView1_2");
        IUIView* leafView2_1 = new LeafView("leafView2_1");
        IUIView* leafView2_2 = new LeafView("leafView2_2");
        
        rootView -> insert(componentView1);
        rootView -> insert(componentView2);
        componentView1 -> insert(leafView1_1);
        componentView1 -> insert(leafView1_2);
        componentView2 -> insert(leafView2_1);
        componentView2 -> insert(leafView2_2);
        componentView2 -> remove(leafView2_2);
        
        rootView -> drawRect(0, 0, 0, 0);
    }
    return 0;
}
