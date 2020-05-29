//
//  Visitor.cpp
//  VisitorPattern
//
//  Created by xiang lin on 2020/5/25.
//  Copyright © 2020 xiang lin. All rights reserved.
//

#include "Visitor.hpp"
#include "Staff.hpp"
 void CTOVisitor::visitor(Engine* engine){
    NSLog(@"工程师 年龄：%d,代码数：%d",engine -> age,engine -> getCodeLines());
 }

 void CTOVisitor::visitor(Manager* manager){
    NSLog(@"经理 年龄：%d,产品数：%d",manager -> age,manager -> getProducts());
}

void CEOVisitor::visitor(Engine* engine){
    NSLog(@"工程师 年龄：%d,kpi：%d",engine -> age,engine -> kpi());
}

void CEOVisitor::visitor(Manager* manager){
    NSLog(@"经理 年龄：%d,kpi:%d",manager -> age,manager -> kpi());
}

void CFOVisitor::visitor(Engine* engine){
    NSLog(@"工程师 年龄：%d,月薪：%d",engine -> age,engine -> monthSalary());
}

void CFOVisitor::visitor(Manager* manager){
    NSLog(@"经理 年龄：%d,月薪:%d",manager -> age,manager -> monthSalary());
}
