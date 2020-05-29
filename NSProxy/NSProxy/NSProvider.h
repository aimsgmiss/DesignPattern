//
//  NSProvider.h
//  NSProxy
//
//  Created by xiang lin on 2020/5/27.
//  Copyright © 2020 xiang lin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Provider : NSObject

@end

#pragma mark NSBookProviderProtocol
@protocol NSBookProviderProtocol <NSObject>
- (void)buyBook;
@end

@interface NSBookProvider : Provider<NSBookProviderProtocol>

@end

#pragma mark NSPhoneProviderProtocol
@protocol NSPhoneProviderProtocol <NSObject>
- (void)buyIphone;
- (void)buyHuaWeiPhone;
@end

@interface NSPhoneProvider : Provider<NSPhoneProviderProtocol>

@end

#pragma mark NSComputerProviderProtocol
@protocol NSComputerProviderProtocol <NSObject>
- (void)buyMac;
- (void)buyMacBook;
- (void)buyHuaWeiComputer;
@end

@interface NSComputerProvider : Provider<NSComputerProviderProtocol>

@end

#pragma mark NSClothesProviderProtocol
@protocol NSClothesProviderProtocol <NSObject>
- (void)buyBigclothes;
- (void)buyMiddleclothes;
- (void)buyTinyclothes;
@end

@interface NSClothesProvider : Provider<NSClothesProviderProtocol>

@end
NS_ASSUME_NONNULL_END
