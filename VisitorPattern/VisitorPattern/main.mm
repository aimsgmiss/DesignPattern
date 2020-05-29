

#import <string>
#include <list>
#include "Visitor.hpp"
#include "Staff.hpp"
using namespace std;
class ObjectStructure{
  
public:
    static std::list<Staff*> getList(){
        std::list<Staff*> list;
        list.push_back(new Engine());
        list.push_back(new Manager());
        list.push_back(new Engine());
        list.push_back(new Engine());
        list.push_back(new Manager());
        list.push_back(new Engine());
        list.push_back(new Manager());
        return list;
    }
};
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Visitor* ctoVisitor = new CTOVisitor();
        Visitor* ceoVisitor = new CEOVisitor();
        Visitor* cfoVisitor = new CFOVisitor();
        std::list<Staff*> list = ObjectStructure::getList();
        NSLog(@"CTO 访问=======================");
        for (std::list<Staff*>::iterator iter = list.begin(); iter != list.end() ; iter++) {
            ((Staff*)*iter) -> accept(ctoVisitor);
        }
        NSLog(@"CEO 访问=======================");
        for (std::list<Staff*>::iterator iter = list.begin(); iter != list.end() ; iter++) {
            ((Staff*)*iter) -> accept(ceoVisitor);
        }
        NSLog(@"CFO 访问=======================");
        for (std::list<Staff*>::iterator iter = list.begin(); iter != list.end() ; iter++) {
           ((Staff*)*iter) -> accept(cfoVisitor);
        }
    }
    return 0;
}
