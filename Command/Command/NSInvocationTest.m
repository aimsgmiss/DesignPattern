//
//  NSInvocationTest.m
//  Command
//
//  Created by xiang lin on 2020/5/26.
//  Copyright © 2020 xiang lin. All rights reserved.
//

#import "NSInvocationTest.h"

@implementation NSInvocationTestA
- (void)testA:(NSString*) a b:(NSString*) b c:(NSString*) c d:(NSString*) d e:(NSString*) e f:(NSString*) f g:(NSString*) g{
    NSLog(@"function = %s,line = %d,a = %@,b = %@,c = %@,d = %@,e = %@,f = %@,g = %@",__FUNCTION__,__LINE__,a,b,c,d,e,f,g);
}
@end

@implementation NSInvocationTestB
- (int)testB:(NSString*) a b:(NSString*) b c:(NSString*) c d:(NSString*) d e:(NSString*) e f:(NSString*) f g:(NSString*) g{
    NSLog(@"function = %s,line = %d,a = %@,b = %@,c = %@,d = %@,e = %@,f = %@,g = %@",__FUNCTION__,__LINE__,a,b,c,d,e,f,g);
    return 1;
}
@end

@implementation NSInvocationTestC
- (float)testC:(NSString*) a b:(NSString*) b c:(NSString*) c d:(NSString*) d e:(NSString*) e f:(NSString*) f g:(NSString*) g{
    NSLog(@"function = %s,line = %d,a = %@,b = %@,c = %@,d = %@,e = %@,f = %@,g = %@",__FUNCTION__,__LINE__,a,b,c,d,e,f,g);
    return 1.230f;
}
@end

@implementation NSInvocationTestD
- (id)testD:(NSString*) a b:(NSString*) b c:(NSString*) c d:(NSString*) d e:(NSString*) e f:(NSString*) f g:(NSString*) g{
    NSLog(@"function = %s,line = %d,a = %@,b = %@,c = %@,d = %@,e = %@,f = %@,g = %@",__FUNCTION__,__LINE__,a,b,c,d,e,f,g);
    return @"testD";
}
@end

@implementation NSInvocationTestE
- (double)testE:(NSString*) a b:(NSString*) b c:(NSString*) c d:(NSString*) d e:(NSString*) e f:(NSString*) f g:(NSString*) g{
    NSLog(@"function = %s,line = %d,a = %@,b = %@,c = %@,d = %@,e = %@,f = %@,g = %@",__FUNCTION__,__LINE__,a,b,c,d,e,f,g);
    return 0.0023f;
}
@end

