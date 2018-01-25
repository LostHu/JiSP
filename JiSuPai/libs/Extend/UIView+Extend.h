//
//  UIView+Extend.h
//  GameBiBi
//
//  Created by Vison on 2017/7/19.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extend)

+(CAShapeLayer *)drawCornerView:(UIView *)view withCornerValue:(float)value;

+(CAShapeLayer *)drawCornerSize:(CGSize)size withCornerValue:(float)value;

@end
