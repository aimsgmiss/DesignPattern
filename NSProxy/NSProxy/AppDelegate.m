//
//  AppDelegate.m
//  NSProxy
//
//  Created by xiang lin on 2020/5/27.
//  Copyright © 2020 xiang lin. All rights reserved.
//

#import "AppDelegate.h"
#import "Agent.h"
#import "NSProvider.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //实体对象在自己的模块向代理中心注册当前实体，为了便于添加，这里统一在代理中实现
    // 在单独的模块可以接管当前app的生命周期，在每个模块的applicationDidFinishLaunching
    // 单独注册,这样代理就不会被污染
    // NSBookProvider 模块
    [[Agent proxy] registerObject:[NSBookProvider new]];
    // NSComputerProvider 模块
    [[Agent proxy] registerObject:[NSComputerProvider new]];
    // NSPhoneProvider 模块
    [[Agent proxy] registerObject:[NSPhoneProvider new]];
    // NSClothesProvider 模块
    [[Agent proxy] registerObject:[NSClothesProvider new]];
        
    // 1、初始化代理商
    Agent *agent = [Agent proxy];
    // 2.1、向代理商买华为手机
    [agent buyHuaWeiPhone];
    // 2.2、向代理商mac
    [agent buyMac];
    // 2.3、向代理商买书
    [agent buyBook];
    // 2.4、向代理商iphone手机
    [agent buyIphone];
    // 2.5、向代理商买华为电脑
    [agent buyHuaWeiComputer];
    // 2.6、向代理商买macbook
    [agent buyMacBook];
    // 2.7、向代理商买大尺寸衣服
    [agent buyBigclothes];
    // 2.7、向代理商买中号衣服
    [agent buyMiddleclothes];
    // 2.8、向代理商买小尺寸衣服
    [agent buyTinyclothes];

}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
