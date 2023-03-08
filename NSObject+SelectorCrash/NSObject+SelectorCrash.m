//
//  NSObject+SelectorCrash.m
//  SDBusiness
//
//  Created by macbook on 2020/10/16.
//  Copyright © 2020 shengda. All rights reserved.
//

#import "NSObject+SelectorCrash.h"
#import "NSObject+swizzle.h"
@implementation CCUnrecognizedSelectorSolveObject


+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod([self class], sel, (IMP)addMethod, "v@:");
    return YES;
}

id addMethod(id self, SEL _cmd) {
    NSLog(@"CC_CrashProtector: unrecognized selector: %@", NSStringFromSelector(_cmd));
    return 0;
}

@end
@implementation NSObject (SelectorCrash)



+ (void)CC_enableSelectorProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSObject *object = [[NSObject alloc] init];
        //防止对象方法崩溃
        [object CC_instanceSwizzleMethod:@selector(forwardingTargetForSelector:) replaceMethod:@selector(CC_forwardingTargetForSelector:)];
        //防止类方法崩溃
        [NSObject CC_classSwizzleMethod:@selector(forwardingTargetForSelector:) replaceMethod:@selector(CC_forwardingTargetForSelector:)];
    });
}

//防止对象方法崩溃
- (id)CC_forwardingTargetForSelector:(SEL)aSelector {
    if (class_respondsToSelector([self class], @selector(forwardInvocation:))) {
        // 获取 NSObject 的消息转发方法
        IMP impOfNSObject = class_getMethodImplementation([NSObject class], @selector(forwardInvocation:));
        // 获取 当前类 的消息转发方法
        IMP imp = class_getMethodImplementation([self class], @selector(forwardInvocation:));
        // 判断当前类本身是否实现第二步：接收者重定向
        if (imp != impOfNSObject) {
            //NSLog(@"class has implemented invocation");
            return nil;
        }
    }
    
    CCUnrecognizedSelectorSolveObject *solveObject = [CCUnrecognizedSelectorSolveObject new];
    return solveObject;
}

//防止类方法崩溃
+ (id)CC_forwardingTargetForSelector:(SEL)aSelector {
    if (class_respondsToSelector([self class], @selector(forwardInvocation:))) {
        // 获取 NSObject 的消息转发方法
        IMP impOfNSObject = class_getMethodImplementation([NSObject class], @selector(forwardInvocation:));
        // 获取 当前类 的消息转发方法
        IMP imp = class_getMethodImplementation([self class], @selector(forwardInvocation:));
        // 判断当前类本身是否实现第二步：接收者重定向
        if (imp != impOfNSObject) {
            //NSLog(@"class has implemented invocation");
            return nil;
        }
    }
    
    CCUnrecognizedSelectorSolveObject *solveObject = [CCUnrecognizedSelectorSolveObject new];
    return solveObject;
}


@end
