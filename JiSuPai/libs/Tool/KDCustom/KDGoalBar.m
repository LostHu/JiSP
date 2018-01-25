
#import "KDGoalBar.h"

@interface KDGoalBar()

@property (nonatomic, assign) CGFloat innerFloat;
@property (nonatomic, assign) CGFloat outerFloat;

@property (nonatomic, strong) UIColor *innerColor;
@property (nonatomic, strong) UIColor *outerColor;

@end

@implementation KDGoalBar

#pragma Init & Setup
- (id)init
{
	if ((self = [super init]))
	{
		[self setup];
	}
    
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		[self setup];
	}
    
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{
        _innerFloat = 32.5;
        _outerFloat = 42.5;
        
        _innerColor = rgbfromHex(@"ff6e21");
        _outerColor = [UIColor colorWithHexColorString:@"ffc29e"];
		[self setup];
	}
    
	return self;
}

- (id)initWithFrame:(CGRect)frame
              inner:(CGFloat)inner
              outer:(CGFloat)outer
         innerColor:(UIColor *)innerColor
         outerColor:(UIColor *)outerColor
{
    if ((self = [super initWithFrame:frame]))
    {
        _innerFloat = inner;
        _outerFloat = outer;
        _innerColor = innerColor;
        _outerColor = outerColor;

        [self setup];
    }
    
    return self;
}


-(void)layoutSubviews {
//    CGRect frame = self.frame;
//    int percent = percentLayer.percent * 100;
//    [self.percentLabel setText:[NSString stringWithFormat:@"%i", percent]];
////    self.percentLabel.text = @"抢";
//
//    
//    CGRect labelFrame = self.percentLabel.frame;
//    labelFrame.origin.x = frame.size.width / 2 - self.percentLabel.frame.size.width / 2;
//    labelFrame.origin.y = frame.size.height / 2 - self.percentLabel.frame.size.height / 2;
//    self.percentLabel.frame = labelFrame;
    
    [super layoutSubviews];
}

-(void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = NO;
    
    _percentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_percentLabel setTextColor:rgbfromHex(@"333333")];
    _percentLabel.textAlignment = NSTextAlignmentCenter;
    [_percentLabel setBackgroundColor:[UIColor clearColor]];
    _percentLabel.font = Font_System(22);
    _percentLabel.numberOfLines = 0;
    [self addSubview:_percentLabel];
    
    [self.percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_centerX).offset(5.8);
        make.center.equalTo(self);
    }];
    
    thumbLayer = [CALayer layer];
    thumbLayer.contentsScale = [UIScreen mainScreen].scale;
    thumbLayer.contents = (id) thumb.CGImage;
    thumbLayer.frame = CGRectMake(self.frame.size.width / 2 - thumb.size.width/2, 0, thumb.size.width, thumb.size.height);
    thumbLayer.hidden = YES;
    
    percentLayer = [KDGoalBarPercentLayer layer];
    [percentLayer setinnerRadius:_innerFloat andouterRadius:_outerFloat innerColor:_innerColor outerColor:_outerColor];
    percentLayer.contentsScale = [UIScreen mainScreen].scale;
    percentLayer.percent = 0;
    percentLayer.frame = self.bounds;
    percentLayer.masksToBounds = NO;
    [percentLayer setNeedsDisplay];
    
    [self.layer addSublayer:percentLayer];
    [self.layer addSublayer:thumbLayer];
}

#pragma mark - Touch Events
- (void)moveThumbToPosition:(CGFloat)angle {
    CGRect rect = thumbLayer.frame;
    NSLog(@"%@",NSStringFromCGRect(rect));
    CGPoint center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    angle -= (M_PI/2);
    NSLog(@"%f",angle);

    rect.origin.x = center.x + 75 * cosf(angle) - (rect.size.width/2);
    rect.origin.y = center.y + 75 * sinf(angle) - (rect.size.height/2);
    
    NSLog(@"%@",NSStringFromCGRect(rect));

    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    
    thumbLayer.frame = rect;
    
    [CATransaction commit];
}
#pragma mark - Custom Getters/Setters
- (void)setPercent:(float)floatPercent animated:(BOOL)animated {
    
    percentLayer.percent = floatPercent;
    [self setNeedsLayout];
    [percentLayer setNeedsDisplay];
    
    [self moveThumbToPosition:floatPercent * (2 * M_PI) - (M_PI/2)];
    
}

- (void)dealloc{
//    [percentLabel release];
//    [super dealloc];
}

@end
