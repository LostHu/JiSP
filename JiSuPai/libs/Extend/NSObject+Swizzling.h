//
//  NSObject+Swizzling.h
//  GameBiBi
//
//  Created by Lost on 2017/12/26.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Swizzling)
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                         bySwizzledSelector:(SEL)swizzledSelector;
@end
