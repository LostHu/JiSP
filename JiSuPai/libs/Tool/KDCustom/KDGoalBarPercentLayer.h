

#import <QuartzCore/QuartzCore.h>

@interface KDGoalBarPercentLayer : CALayer

@property (nonatomic) CGFloat percent;

-(void)setinnerRadius:(CGFloat)iinnerRadius andouterRadius:(CGFloat)iouterRadius innerColor:(UIColor *)iinnerColor outerColor:(UIColor *)iouterColor;
@end
