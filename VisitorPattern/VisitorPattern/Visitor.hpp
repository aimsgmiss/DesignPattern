//
//  Visitor.hpp
//  VisitorPattern
//
//  Created by xiang lin on 2020/5/25.
//  Copyright © 2020 xiang lin. All rights reserved.
//

#ifndef Visitor_hpp
#define Visitor_hpp
#import <Foundation/Foundation.h>
#include <stdio.h>
class Engine;
class Manager;

class Visitor{
public:
    virtual void visitor(Engine* engine) = 0;
    virtual void visitor(Manager* manager) = 0;
};

class CTOVisitor:public Visitor{
public:
    void visitor(Engine* engine);
    void visitor(Manager* manager);
};

class CEOVisitor:public Visitor{
public:
    void visitor(Engine* engine);
    void visitor(Manager* manager);
};

class CFOVisitor:public Visitor{
public:
    void visitor(Engine* engine);
    void visitor(Manager* manager);
};

#endif /* Visitor_hpp */
