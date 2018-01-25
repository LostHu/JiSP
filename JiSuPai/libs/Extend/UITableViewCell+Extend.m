//
//  UITableViewCell+Extend.m
//  Football
//
//  Created by Lost on 15/7/28.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "UITableViewCell+Extend.h"
#define ViewTag 9981

@implementation UITableViewCell (Extend)

- (void)showBottomLine
{
    [self showBottomLineforColor:YZColor_White_boldLine height:0.5];
}

- (UIView*)getBottomLineView
{
    return [self viewWithTag:ViewTag];
}

- (void)showBottomLineforColor:(UIColor *)color height:(CGFloat)height edge:(UIEdgeInsets)edge
{
    UIView* lineView = [self viewWithTag:ViewTag];
    if (!lineView) {
        lineView = [UIView new];
        [self addSubview:lineView];
    }
    
    lineView.backgroundColor = color;
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, edge)) {
            make.width.centerX.bottom.equalTo(self);
        }
        else
            make.centerX.bottom.equalTo(self);
        
        make.edges.mas_equalTo(edge);
        make.height.mas_equalTo(@(height));
    }];
}

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

- (void)showBottomLineforImage:(UIImage *)image height:(CGFloat)height
{
    UIImageView* lineView = [self viewWithTag:ViewTag];
    if (!lineView) {
        lineView = [UIImageView new];
        lineView.image = image;
        [self addSubview:lineView];
    }
    
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.bottom.equalTo(self);
        make.height.mas_equalTo(@(height));
    }];
}

- (void)showAccessoryViewforImage:(NSString*)imageName
{
    UIImage* image = [UIImage imageNamed:imageName];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    
    [self addSubview:imageView];
    [self setAccessoryView:imageView];
    [self.accessoryView setHidden:NO];
    
    [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.size.mas_equalTo(image.size);
        make.centerY.equalTo(self);
    }];
}

- (void)hideAccessoryView
{
    if (self.accessoryView) {
        [self.accessoryView setHidden:YES];
    }
}

- (void)setDefaultSelectionView
{
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithHexColorString:@"3B3B42"];
}

#pragma mark - 设置Key

+ (NSString * _Nonnull)identify {
    
    NSString *identify = NSStringFromClass(self);
    return identify;
}


@end
