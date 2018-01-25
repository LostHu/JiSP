//
//  TaskDateBarView.h
//  JiSuPai
//
//  Created by Lost on 2018/1/13.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskDateBarView : UIView
@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UIButton* selBtn;
@property (nonatomic,strong) UIButton* dateBtn;
@property (nonatomic,assign) NSInteger timeStamp;
@end
