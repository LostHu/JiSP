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
        self.titleLabel.text = @"暂无出车计划";
        self.imageView.image = ImageNamed(@"暂无出车计划");
//        self.imageView.backgroundColor = RandomColor;
//        self.titleLabel.backgroundColor = RandomColor;
        
        self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height*0.8);
//        self.imageView.centerY = self.centerY;
        self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), frame.size.width, frame.size.height*0.2);
        
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
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = rgbfromHex(@"797979");
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"pic_blank"];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

@end
