//
//  UIView+Extend.m
//  GameBiBi
//
//  Created by Vison on 2017/7/19.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import "UIView+Extend.h"

@implementation UIView (Extend)

+(CAShapeLayer *)drawCornerView:(UIView *)view withCornerValue:(float)value
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}

+(CAShapeLayer *)drawCornerSize:(CGSize)size withCornerValue:(float)value
{
    CGRect viewBounds = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewBounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = viewBounds;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}


@end
