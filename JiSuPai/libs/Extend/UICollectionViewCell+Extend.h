//
//  UICollectionViewCell+Extend.h
//  Football
//
//  Created by Lost on 16/11/18.
//  Copyright © 2016年 Lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (Extend)
NS_ASSUME_NONNULL_BEGIN
- (void)showBottomLineforColor:(UIColor *)color height:(CGFloat)height;
NS_ASSUME_NONNULL_END

//设置Key
+ (NSString * _Nonnull)identify;
@end
