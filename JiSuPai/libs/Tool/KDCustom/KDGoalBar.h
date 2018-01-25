
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "KDGoalBarPercentLayer.h"


@interface KDGoalBar : UIView {
    UIImage * thumb;
    
    KDGoalBarPercentLayer *percentLayer;
    CALayer *thumbLayer;
          
}

@property (nonatomic, strong) UILabel *percentLabel;
@property (nonatomic, strong) UILabel *hundredLabel;

- (id)initWithFrame:(CGRect)frame
              inner:(CGFloat)inner
              outer:(CGFloat)outer
         innerColor:(UIColor *)innerColor
         outerColor:(UIColor *)outerColor;

- (void)setPercent:(float)floatPercent animated:(BOOL)animated;

@end
