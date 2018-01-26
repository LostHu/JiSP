//
//  LeaveTableViewCell.m
//  JiSuPai
//
//  Created by Lost on 2018/1/26.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "LeaveTableViewCell.h"

@implementation LeaveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel* nameLabel2 = [self.contentView viewWithTag:1980];
        if (nameLabel2) {
            nameLabel2.text = @"描述:";
        }
    }
    return self;
}

@end
