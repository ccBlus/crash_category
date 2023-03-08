//
//  NSObject+SelectorCrash.h
//  SDBusiness
//
//  Created by macbook on 2020/10/16.
//  Copyright © 2020 shengda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCUnrecognizedSelectorSolveObject : NSObject


@end

@interface NSObject (SelectorCrash)

+ (void)CC_enableSelectorProtector;

@end


