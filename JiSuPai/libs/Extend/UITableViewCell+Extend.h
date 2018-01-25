//
//  UITableViewCell+Extend.h
//  Football
//
//  Created by Lost on 15/7/28.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Extend)
NS_ASSUME_NONNULL_BEGIN
/**
 *  获取底边分割线View，主要用于布局
 *
 *  @return 分割线View
 */
- (UIView*)getBottomLineView;
// 增加默认下划线
- (void)showBottomLine;
- (void)showBottomLineforColor:(UIColor *)color height:(CGFloat)height;
- (void)showBottomLineforImage:(UIImage *)image height:(CGFloat)height;
- (void)showBottomLineforColor:(UIColor *)color height:(CGFloat)height edge:(UIEdgeInsets)edge;
// 增加定制右箭头
- (void)showAccessoryViewforImage:(NSString*)imageName;
- (void)hideAccessoryView;
- (void)setDefaultSelectionView;

//设置Key
+ (NSString *)identify;
NS_ASSUME_NONNULL_END
@end
