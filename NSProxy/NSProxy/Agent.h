
#import <Foundation/Foundation.h>
#import "NSProvider.h"
NS_ASSUME_NONNULL_BEGIN

@interface Agent : NSProxy<NSPhoneProviderProtocol,NSBookProviderProtocol,NSComputerProviderProtocol,NSClothesProviderProtocol>

+ (instancetype)proxy;

- (void)registerObject:(id)target;
@end

NS_ASSUME_NONNULL_END
