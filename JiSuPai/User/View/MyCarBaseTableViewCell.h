//
//  MyCarBaseTableViewCell.h
//  JiSuPai
//
//  Created by Lost on 2018/1/29.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCarBaseTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UILabel* indexLabel;
@property (nonatomic,strong) UIView* lineView;
@end


@interface MyCarPhotoTableViewCell : MyCarBaseTableViewCell
@property (nonatomic,strong) UIButton* sfz1Btn;
@property (nonatomic,strong) UIButton* sfz2Btn;

@property (nonatomic,strong) UILabel* infoLabel1;
@property (nonatomic,strong) UILabel* infoLabel2;
@end
