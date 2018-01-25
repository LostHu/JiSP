//
//  UINavigationController+ShouldPopOnBackButton.h
//  Football
//
//  Created by Lost on 16/3/2.
//  Copyright © 2016年 崔伟战. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (ShouldPopOnBackButton)<UINavigationBarDelegate>
-(void)initDeepStyle;
-(void)initLightStyle;
@end
