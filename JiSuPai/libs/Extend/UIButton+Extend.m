//
//  UIButton+Extend.m
//  QuickDate
//
//  Created by Lost on 15/12/14.
//  Copyright © 2015年 崔伟战. All rights reserved.
//

#import "UIButton+Extend.h"

@implementation UIButton (Extend)
- (void)centerImageAndTitle:(float)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(
                                            - (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(
                                            0.0, - imageSize.width, - (totalHeight - titleSize.height), 0.0);
}

- (void)centerImageAndTitle
{
    const int DEFAULT_SPACING = 6.0f;
    [self centerImageAndTitle:DEFAULT_SPACING];
}

// 深色背景图片style
- (void)deepSolidCornerStyle
{
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // 背景图片
    UIImage* bgImage = [UIColor imageWithColor:YZColor_Text_mainBlue size:CGSizeMake(10, 10)];
    UIImage* bgHighImage = [UIColor imageWithColor:rgbfromHex(@"5c6575") size:CGSizeMake(10, 10)];
    [self setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self setBackgroundImage:bgHighImage forState:UIControlStateHighlighted];
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
}

// 深色镂空边框
- (void)deepBorderHollowStyle
{
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    [self setTitleColor:YZColor_Text_mainBlue forState:UIControlStateNormal];
    UIImage* bgImage = [UIColor imageWithColor:YZColor_White size:CGSizeMake(10, 10)];
    UIImage* bgHighImage = [UIColor imageWithColor:rgbfromHex(@"dbdbdb") size:CGSizeMake(10, 10)];
    [self setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self setBackgroundImage:bgHighImage forState:UIControlStateHighlighted];
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 1;
    self.layer.borderColor = YZColor_Text_mainBlue.CGColor;
    
//    @weakify(self)
//    [RACObserve(self, highlighted) subscribeNext:^(id x) {
//        @strongify(self)
//        if ([x boolValue]) {
//            self.layer.borderColor = YZColor_Text_mainlight.CGColor;
//        }
//        else
//        {
//            self.layer.borderColor = YZColor_Text_mainBlue.CGColor;
//        }
//    }];
}

// 红色背景图片style
- (void)redSolidCornerStyle
{
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // 背景图片
    UIImage* bgImage = [UIColor imageWithColor:rgbfromHex(@"fc3342") size:CGSizeMake(10, 10)];
    UIImage* bgHighImage = [UIColor imageWithColor:rgbfromHex(@"fe6671") size:CGSizeMake(10, 10)];
    [self setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self setBackgroundImage:bgHighImage forState:UIControlStateHighlighted];
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
}

- (void)solidStyleforC:(UIColor*)normal H:(UIColor*)high font:(UIFont*)font corner:(CGFloat)corner
{
    self.titleLabel.font = font;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // 背景图片
    UIImage* bgImage = [UIColor imageWithColor:normal size:CGSizeMake(10, 10)];
    UIImage* bgHighImage = [UIColor imageWithColor:high size:CGSizeMake(10, 10)];
    [self setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self setBackgroundImage:bgHighImage forState:UIControlStateHighlighted];
    
    if (corner>0) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = corner;
    }
}

- (void)solidStyleforC:(UIColor*)normal D:(UIColor*)disable font:(UIFont*)font corner:(CGFloat)corner
{
    self.titleLabel.font = font;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // 背景图片
    UIImage* bgImage = [UIColor imageWithColor:normal size:CGSizeMake(10, 10)];
    UIImage* bgDissImage = [UIColor imageWithColor:disable size:CGSizeMake(10, 10)];
    [self setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self setBackgroundImage:bgDissImage forState:UIControlStateDisabled];
    
    if (corner>0) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = corner;
    }
}

- (void)borderHollowStyleforC:(UIColor*)normal H:(UIColor*)high font:(UIFont*)font border:(CGFloat)border
{
    self.titleLabel.font = font;
    [self setTitleColor:normal forState:UIControlStateNormal];
    [self setTitleColor:high forState:UIControlStateHighlighted];
    [self setTitleColor:high forState:UIControlStateDisabled];
    
    self.clipsToBounds = YES;
    
    if (border > 0) {
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = border;
        self.layer.borderColor = normal.CGColor;
        @weakify(self)
        [RACObserve(self, highlighted) subscribeNext:^(id x) {
            @strongify(self)
            if ([x boolValue]) {
                self.layer.borderColor = high.CGColor;
            }
            else
            {
                self.layer.borderColor = normal.CGColor;
            }
        }];
    }
}

- (void)borderHollowStyleforColor:(UIColor*)normal H:(UIColor*)high font:(UIFont*)font borderColor:(UIColor*)bColor border:(CGFloat)border
{
    self.titleLabel.font = font;
    [self setTitleColor:normal forState:UIControlStateNormal];
    [self setTitleColor:high forState:UIControlStateHighlighted];
    [self setTitleColor:high forState:UIControlStateDisabled];
    
    self.clipsToBounds = YES;
    
    if (border > 0) {
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = border;
        self.layer.borderColor = bColor.CGColor;
        @weakify(self)
        [RACObserve(self, highlighted) subscribeNext:^(id x) {
            @strongify(self)
            if ([x boolValue]) {
                self.layer.borderColor = high.CGColor;
            }
            else
            {
                self.layer.borderColor = bColor.CGColor;
            }
        }];
    }
}

- (void)borderHollowStyleforC:(UIColor*)normal H:(UIColor*)high font:(UIFont*)font
{
    [self borderHollowStyleforC:normal H:high font:font border:0];
}

// 灰色实体按钮
- (void)graySolidStyle
{
    [self solidStyleforC:rgbfromHex(@"bebebe") H:rgbfromHex(@"cccccc") font:Font_System(17) corner:5];
}

// 蓝色实体按钮
- (void)blueSolidStyle
{
    [self solidStyleforC:YZColor_Text_mainBlue H:rgbfromHex(@"cccccc") font:Font_System(12) corner:5];
}

// 橙色实体按钮
- (void)orangeSolidStyle
{
    [self solidStyleforC:hexColor(eb6700) H:rgbfromHex(@"cccccc") font:Font_System(15) corner:5];
}

// 橙色镂空边框
- (void)orangeBorderHollowStyle
{
    [self borderHollowStyleforC:rgbfromHex(@"eb6700") H:rgbfromHex(@"d5d5d5") font:Font_System_Bold(12) border:1];
}

// 蓝色镂空边框
- (void)blueBorderHollowStyle
{
    [self borderHollowStyleforC:rgbfromHex(@"06b0ff") H:rgbfromHex(@"cccccc") font:Font_System(18) border:1];
}

// 蓝色镂空无边框
- (void)blueHollowStyle
{
    [self borderHollowStyleforC:rgbfromHex(@"06b0ff") H:rgbfromHex(@"cccccc") font:Font_System(18) border:0];
}

- (void)orangeNoBorderHollowStyle
{
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self setTitleColor:rgbfromHex(@"eb6700") forState:UIControlStateNormal];
    [self setTitleColor:rgbfromHex(@"cccccc") forState:UIControlStateHighlighted];
    
    if (self.layer.borderWidth > 0) {
        self.layer.borderWidth = 0;
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
    
    self.clipsToBounds = YES;
}

// 红色镂空无边框
- (void)redNoBorderHollowStyle
{
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setTitleColor:rgbfromHex(@"fc3342") forState:UIControlStateNormal];
    [self setTitleColor:rgbfromHex(@"fe6671") forState:UIControlStateHighlighted];
    
    if (self.layer.borderWidth > 0) {
        self.layer.borderWidth = 0;
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
    
    self.clipsToBounds = YES;
}
@end
