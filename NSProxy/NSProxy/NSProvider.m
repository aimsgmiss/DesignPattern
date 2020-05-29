//
//  NSProvider.m
//  NSProxy
//
//  Created by xiang lin on 2020/5/27.
//  Copyright © 2020 xiang lin. All rights reserved.
//

#import "NSProvider.h"
#import "Agent.h"
@implementation Provider

@end

@implementation NSBookProvider

- (void)buyBook{
    NSLog(@"buyBook:%s,%d",__FUNCTION__,__LINE__);
}
@end

@implementation NSPhoneProvider
- (void)buyIphone{
    NSLog(@"buyIphone:%s,%d",__FUNCTION__,__LINE__);
}
- (void)buyHuaWeiPhone{
    NSLog(@"buyHuaWeiPhone:%s,%d",__FUNCTION__,__LINE__);
}
@end

@implementation NSComputerProvider
- (void)buyMac{
    NSLog(@"buyMac:%s,%d",__FUNCTION__,__LINE__);
}
- (void)buyMacBook{
    NSLog(@"buyMacBook:%s,%d",__FUNCTION__,__LINE__);
}
- (void)buyHuaWeiComputer{
    NSLog(@"buyHuaWeiComputer:%s,%d",__FUNCTION__,__LINE__);
}
@end

@implementation NSClothesProvider
- (void)buyBigclothes{
    NSLog(@"buyBigclothes:%s,%d",__FUNCTION__,__LINE__);
}

- (void)buyMiddleclothes{
    NSLog(@"buyMiddleclothes:%s,%d",__FUNCTION__,__LINE__);
}

- (void)buyTinyclothes{
    NSLog(@"buyTinyclothes:%s,%d",__FUNCTION__,__LINE__);
}
@end
