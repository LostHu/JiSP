//
//  PhotoHeaderTableView.m
//  Lust
//
//  Created by Lost on 16/4/14.
//  Copyright © 2016年 Lost. All rights reserved.
//

#import "PhotoHeaderTableView.h"

@interface PhotoHeaderTableView ()
//@property (nonatomic, strong) UIView * bbView;
@property (nonatomic, strong) RACDisposable *handler;
@property (nonatomic, strong) RACDisposable *handlerHeight;
@end

@implementation PhotoHeaderTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _scaleHeight = 0.0;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.photoView];
        [self sendSubviewToBack:self.photoView];
        
        
//        @weakify(self)
        
        
//        _glassEffect = NO;
        
        // 毛玻璃效果
//        [_photoView addSubview: self.bbView];
//        [self.bbView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//        }];
//
        // 监测滑动距离
        [self trackContentSize];
    }
    return self;
}

//- (void)setGlassEffect:(BOOL)glassEffect
//{
//    _glassEffect = glassEffect;
//    self.bbView.hidden = _glassEffect;
//}

- (UIImageView*)photoView
{
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.clipsToBounds = YES;
    }
    return _photoView;
}

//-(UIView *)bbView
//{
//    if (!_bbView) {
//        UIView *BlurView;
//        double version = [[UIDevice currentDevice].systemVersion doubleValue];
//        if (version >= 8.0f) {
//            
//            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//            BlurView = [[UIVisualEffectView alloc] initWithEffect:blur];
//            ((UIVisualEffectView *)BlurView).frame = self.bounds;
//            
//        }else if(version >= 7.0f){
//            
//            BlurView = [[UIToolbar alloc] initWithFrame:self.bounds];
//            ((UIToolbar *)BlurView).barStyle = UIBarStyleBlack;
//            
//        }else{
//            
//            BlurView = [[UIView alloc] initWithFrame:self.bounds];
//            [BlurView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.9f]];
//        }
//        BlurView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
//        _bbView = BlurView;
//        _bbView.alpha = 0.9;
//    }
//    return _bbView;
//}

- (void)dealloc
{
//    [_handlerHeight dispose];
    [_handler dispose];
    _photoView.image = nil;
    [_photoView removeFromSuperview];
    _photoView = nil;
}

- (void)trackContentSize
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    @weakify(self)
    _handler = [[RACObserve(self, contentOffset) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        if (x) {
            CGPoint contentOffset = [x CGPointValue];
            [self changeConstraintsWithOffsetY:contentOffset.y headerHeight:self.photoHeight];
        }
    }];
    
    _handlerHeight = [[RACObserve(self, photoHeight) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        if (x && [x isKindOfClass:[NSNumber class]]) {
            [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.width.top.equalTo(self);
                make.height.mas_equalTo(@([x floatValue]));
            }];
        }
    }];
}

- (void)changeContentSize:(float)offsetY headerHeight:(float)headerHeight
{
    
}

-(void)changeConstraintsWithOffsetY:(float)offsetY headerHeight:(float)headerHeight
{
//    CGFloat scrollOffsetY = headerHeight-offsetY;
//    DDLog(@"--------------------------| %.1f,%.1f",offsetY,headerHeight);
    // 往上推
//    if (offsetY > -_scaleHeight) {
//        //        [self.bgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        //            make.top.equalTo(self.mas_top).offset(-offsetY);
//        //            make.centerX.width.equalTo(self);
//        //            make.height.mas_equalTo(@(headerHeight));
//        //        }];
//    }
//    else
    {
        // 往下拉 Stretch the header view if neccessary
        if (offsetY < NavigationBarHeight) {
            CGFloat delta = offsetY < 0 ? ABS(offsetY-NavigationBarHeight) : NavigationBarHeight-offsetY;
            CGFloat height = headerHeight + delta ;
//            CGFloat scale = height/headerHeight;
//            DDLog(@"%.1f,%.1f",delta,height);
//            _photoView.transform = CGAffineTransformMakeScale(scale, scale);
        @weakify(self);
            [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.centerX.width.equalTo(self);
//                make.height.mas_equalTo(@(_photoHeight));
                
//                make.centerX.top.equalTo(self);
//                make.width.mas_equalTo(@(SCREEN_WIDTH*scale));
//                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*scale, headerHeight*scale));
                make.height.mas_equalTo(@(height));
                make.top.equalTo(self).offset(-delta);
//                make.bottom.equalTo(self.mas_bottom);
                
//                make.height.mas_equalTo(@(headerHeight+delta));
//                make.top.equalTo(self.mas_top).offset(-delta);
            }];
        } else {
            [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.width.top.equalTo(self);
                make.height.mas_equalTo(@(headerHeight));

//                make.top.equalTo(self).offset(offsetY);
            }];
        }
    }
}

@end
