
#import <objc/runtime.h>
#import "Agent.h"

@interface Agent()
@property (nonatomic,strong) NSMutableArray* targets;
@end
@implementation Agent

+ (instancetype)proxy{
    static Agent* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       sharedInstance = [[Agent alloc] init];
    });
    return sharedInstance;
}

static NSArray* g_targetArray;
#pragma mark - init

- (instancetype)init{
    _targets = [NSMutableArray array];
    return self;
}
-(void)registerObject:(id)target{
    if (target) {
        [_targets addObject:target];
    }
}

#pragma mark - NSProxy override methods
- (void)forwardInvocation:(NSInvocation *)invocation{
    for (id target in _targets){
        if (target && [target respondsToSelector:invocation.selector]){
            [invocation invokeWithTarget:target];
        }
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    for (id target in _targets){
        if (target && [target respondsToSelector:sel]){
            return [target methodSignatureForSelector:sel];
        }
    }
    return [super methodSignatureForSelector:sel];
}

@end
