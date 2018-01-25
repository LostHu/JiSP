//
//  MeHeadTableViewCell.h
//  JiSuPai
//
//  Created by Lost on 2018/1/15.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeHeadTableViewCell : UITableViewCell
//@property (nonatomic,strong) UIButton* editBtn;
@property (nonatomic,strong) UIImageView* photoView;
@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UILabel* infoLabel;
@end

@interface MeHeadExtractTableViewCell : UITableViewCell
@property (nonatomic,strong) UIButton* edBtn;
@property (nonatomic,strong) UIButton* ingBtn;
@property (nonatomic,strong) UIButton* canBtn;
@property (nonatomic,strong) UIButton* confirmBtn;
- (void)updateBtn:(UIButton*)btn title:(NSString*)title count:(CGFloat)count;
@end
