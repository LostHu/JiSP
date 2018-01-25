//
//  PhotoHeaderTableView.h
//  Lust
//
//  Created by Lost on 16/4/14.
//  Copyright © 2016年 Lost. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kGKNavbarHeight 0.f

@interface PhotoHeaderTableView : UITableView
@property (nonatomic,strong) UIImageView* photoView;
// 图片默认高度
@property (nonatomic,assign) CGFloat photoHeight;
// 是否开启毛玻璃效果
//@property (nonatomic,assign) BOOL glassEffect;

@property (nonatomic,assign) CGFloat scaleHeight;
@end
