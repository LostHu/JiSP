//
//  NoDataView.h
//  GameBiBi
//
//  Created by Lost on 2017/12/26.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDataView : UIView<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIImageView* imageView;

@property (nonatomic, copy) void(^reloadClickBlock)(void);
@end
