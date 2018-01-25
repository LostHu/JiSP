//
//  UICollectionViewCell+Extend.m
//  Football
//
//  Created by Lost on 16/11/18.
//  Copyright © 2016年 Lost. All rights reserved.
//

#import "UICollectionViewCell+Extend.h"
#define ViewTag 9981

@implementation UICollectionViewCell (Extend)
- (void)showBottomLineforColor:(UIColor *)color height:(CGFloat)height
{
    UIView* lineView = [self viewWithTag:ViewTag];
    if (!lineView) {
        lineView = [UIView new];
        [self addSubview:lineView];
    }
    
    lineView.backgroundColor = color;
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.bottom.equalTo(self);
        make.height.mas_equalTo(@(height));
    }];
}

#pragma mark - 设置Key

+ (NSString * _Nonnull)identify {
    
    NSString *identify = NSStringFromClass(self);
    return identify;
}

@end
