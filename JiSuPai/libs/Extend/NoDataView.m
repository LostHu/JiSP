//
//  NoDataView.m
//  GameBiBi
//
//  Created by Lost on 2017/12/26.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        self.titleLabel.text = @"NO DATA";
        self.imageView.backgroundColor = RandomColor;
        self.titleLabel.backgroundColor = RandomColor;
        
        self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height*0.7);
        self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), frame.size.width, frame.size.height*0.3);
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tap
{
    if (self.reloadClickBlock) {
        self.reloadClickBlock();
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = rgbfromHex(@"3a3a3a");
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"chuqin_con_tong"];
    }
    return _imageView;
}

@end
