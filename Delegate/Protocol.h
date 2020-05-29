//
//  Protocol.h
//  Delegate
//
//  Created by xiang lin on 2020/5/27.
//  Copyright © 2020 xiang lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#if !TARGET_OS_OSX
#import <UIKit/UIkit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IPlugin <NSObject>

@required
    - (void)didSelectedIndexPath:(NSInteger)row;
@optional

@end

@protocol IPluginBase <IPlugin>
@required
    - (void)didSelectedBaseIndexPath:(NSInteger)row;
@end

#pragma mark Login

@protocol LoginProtocol <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

- (void)userLoginWithUserName(NSString*)userName password:(NSString*)passwod;

@end

NS_ASSUME_NONNULL_END

#endif


