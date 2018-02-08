//
//  TaskInfoTableViewCell.m
//  JiSuPai
//
//  Created by Lost on 2018/1/14.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TaskInfoTableViewCell.h"
#import "MSSBrowseDefine.h"
#import "YYPhotoGroupView.h"


@implementation TaskInfoBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bgView.layer.cornerRadius = 8;
        [self.contentView addSubview:self.bgView];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(6, 6, 0, 6));
        }];
        
        [self.bgView addSubview:self.indexLabel];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.lineView];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(27);
            make.left.offset(5);
            make.right.offset(-5);
            make.height.mas_equalTo(@(0.5));
        }];
        
        self.titleLabel.text = @"title";
        self.indexLabel.layer.cornerRadius = 6;
        self.indexLabel.font = Font_System(8);
        self.indexLabel.clipsToBounds = YES;
        [self.indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(8);
            make.left.equalTo(self.lineView).offset(0);
            make.size.mas_equalTo(CGSizeMake(12, 12));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.indexLabel);
            make.left.equalTo(self.indexLabel.mas_right).offset(5);
        }];
    }
    return self;
}

- (UILabel*)newTitleLabel
{
    UILabel* label = [UILabel new];
    label.textColor = hexColor(a1a1a1);
    label.font = Font_System(10);
    return label;
}

- (UILabel*)newValueLabel
{
    UILabel* label = [UILabel new];
    label.textColor = hexColor(111111);
    label.font = Font_System(10);
    return label;
}

- (UILabel*)labelForTag:(NSInteger)tag
{
    return [self.bgView viewWithTag:tag];
}

- (UIView*)bgView
{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10;
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = hexColor(111111);
        _titleLabel.font = Font_System(10);
        _titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _titleLabel;
}

- (UILabel*)indexLabel
{
    if (!_indexLabel) {
        _indexLabel = [UILabel new];
        _indexLabel.text = @"0";
        _indexLabel.textColor = hexColor(ffffff);
        _indexLabel.font = Font_System(8);
        _indexLabel.backgroundColor = hexColor(587def);
        _indexLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _indexLabel;
}

- (UIView*)lineView
{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = hexColor(eeeeee);
    }
    return _lineView;
}

@end

#define AddTag 1768
#define BtnSize CGSizeMake(52, 52)
@implementation TaskInfoAddPhotoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.bgView addSubview:self.addBtn];
        
//        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.indexLabel.mas_centerX).offset(0);
//            make.top.equalTo(self.lineView).offset(10);
//            make.size.mas_equalTo(BtnSize);
//            make.bottom.offset(-10);
//        }];
        
//        [self.addBtn addTarget:self action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>]
    }
    return self;
}

- (void)setArray:(NSArray *)array
{
    _array = array;
    
    CGFloat gap_left = 12;
    CGFloat gap_top = 10;
    NSInteger line_count = 4;
    CGFloat gap = ((SCREEN_WIDTH-6*2-gap_left*2)-BtnSize.width*line_count)/line_count;
    CGFloat gap_line = 10;
    
    UIButton* lastView = nil;
    for (int i = 0; i<=array.count; i++) {
        NSInteger line_index = (i)/line_count*1.0;
        NSInteger col_index = i%line_count;
        
        if (i == array.count) {
            [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(gap_left+(BtnSize.width+gap)*col_index);
                make.top.equalTo(self.lineView.mas_bottom).offset(gap_top+(BtnSize.height+gap_line)*line_index);
                make.size.mas_equalTo(BtnSize);
                make.bottom.offset(-10);
            }];
            break;
        }
        
        NSString* url = [array objectAtIndex:i];
        NSInteger tag = AddTag+i;
        UIButton* card = [self.bgView viewWithTag:tag];
        if (!card) {
            card = [UIButton new];
            [card setBackgroundImage:ImageNamed(@"fatie_btn_add") forState:UIControlStateNormal];
//            card.backgroundColor = RandomColor;
            card.tag = tag;
            [card.imageView setContentMode:UIViewContentModeScaleAspectFill];
            [self.bgView addSubview:card];
            
            [card mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(gap_left+(BtnSize.width+gap)*col_index);
                make.top.equalTo(self.lineView.mas_bottom).offset(gap_top+(BtnSize.height+gap_line)*line_index);
                make.size.mas_equalTo(BtnSize);
            }];
            [card addTarget:self action:@selector(clickPhoto:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (![NSString isBlankString: url]) {
            
            [card setImageWithURL:URLStr(url) forState:UIControlStateNormal options:YYWebImageOptionProgressive];
        }
        
        lastView = card;
    }
//    if (lastView) {
//        [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.offset(-15);
//        }];
//    }
    
}

- (void)clickPhoto:(UIButton*)card
{
    UIImageView *fromView = card;
    
    NSMutableArray *items = [NSMutableArray new];
    for (NSUInteger i = 0, max = self.array.count; i < max; i++) {
        
        UIImageView *imageView = nil ;
        imageView = [self.bgView viewWithTag:i + AddTag];
        NSString *imageItem = self.array[i];
        
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        item.thumbView = imageView;
        item.largeImageURL = URLStr(imageItem);
        [items addObject:item];
    }
    
    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:items];
    [v presentFromImageView:fromView toContainer:[UIViewController topViewController].navigationController.view animated:YES completion:nil];
}

- (UIButton*)addBtn
{
    if (!_addBtn) {
        _addBtn = [UIButton new];
        [_addBtn setBackgroundImage:ImageNamed(@"fatie_btn_add") forState:UIControlStateNormal];
    }
    return _addBtn;
}

@end

@implementation TaskInfoBasicTableViewCell
#define BasicTag 198
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        CGFloat line_gap = 18;
        UILabel* name1Label = [self newTitleLabel];
        name1Label.text = @"客户名称";
        [self.bgView addSubview:name1Label];
        
        [name1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView).offset(1);
            make.top.equalTo(self.lineView).offset(9);
        }];
        
        UILabel* value1Label = [self newValueLabel];
        value1Label.tag = BasicTag + 1;
        [self.bgView addSubview:value1Label];
        
        [value1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(100);
            make.centerY.equalTo(name1Label).offset(0);
        }];
        
        UILabel* name2Label = [self newTitleLabel];
        name2Label.text = @"发货人";
        [self.bgView addSubview:name2Label];
        
        [name2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap);
        }];
        
        UILabel* value2Label = [self newValueLabel];
        value2Label.tag = BasicTag + 2;
        [self.bgView addSubview:value2Label];
        
        [value2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name2Label).offset(0);
        }];
        
        UILabel* name3Label = [self newTitleLabel];
        name3Label.text = @"发货人电话";
        [self.bgView addSubview:name3Label];
        
        [name3Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap*2);
        }];
        
        UILabel* value3Label = [self newValueLabel];
        value3Label.tag = BasicTag + 3;
        [self.bgView addSubview:value3Label];
        
        [value3Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name3Label).offset(0);
        }];
        
        UILabel* name4Label = [self newTitleLabel];
        name4Label.text = @"要招车型";
        [self.bgView addSubview:name4Label];
        
        [name4Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap*3);
        }];
        
        UILabel* value4Label = [self newValueLabel];
        value4Label.tag = BasicTag + 4;
        [self.bgView addSubview:value4Label];
        
        [value4Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name4Label).offset(0);
        }];
        
        UILabel* name5Label = [self newTitleLabel];
        name5Label.text = @"计价方式";
        [self.bgView addSubview:name5Label];
        
        [name5Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap*4);
        }];
        
        UILabel* value5Label = [self newValueLabel];
        value5Label.tag = BasicTag + 5;
        [self.bgView addSubview:value5Label];
        
        [value5Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name5Label).offset(0);
        }];
        
        UILabel* name6Label = [self newTitleLabel];
        name6Label.text = @"单价";
        [self.bgView addSubview:name6Label];
        
        [name6Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap*5);
        }];
        
        UILabel* value6Label = [self newValueLabel];
        value6Label.tag = BasicTag + 6;
        [self.bgView addSubview:value6Label];
        
        [value6Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name6Label).offset(0);
        }];
        
        UILabel* name7Label = [self newTitleLabel];
        name7Label.text = @"总价";
        [self.bgView addSubview:name7Label];
        
        [name7Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap*6);
        }];
        
        UILabel* value7Label = [self newValueLabel];
        value7Label.textColor = hexColor(557df2);
        value7Label.tag = BasicTag + 7;
        [self.bgView addSubview:value7Label];
        
        [value7Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name7Label).offset(0);
        }];
        
        UILabel* name8Label = [self newTitleLabel];
        name8Label.text = @"司机要求";
        [self.bgView addSubview:name8Label];
        
        [name8Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap*7);
            make.bottom.offset(-6);
        }];
        
        UILabel* value8Label = [self newValueLabel];
        value8Label.tag = BasicTag + 8;
        [self.bgView addSubview:value8Label];
        
        [value8Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name8Label).offset(0);
        }];
        
    }
    return self;
}

- (void)setData:(TaskData *)data
{
    [self labelForTag:BasicTag+1].text = data.customername;
    [self labelForTag:BasicTag+2].text = data.fahuoren;
    [self labelForTag:BasicTag+3].text = data.fahuophone;
    [self labelForTag:BasicTag+4].text = data.cartypeInCn;
    [self labelForTag:BasicTag+5].text = data.jiesuanfsInCn;
    [self labelForTag:BasicTag+6].text = FormatStr(@"%ld",data.priceperone);
    [self labelForTag:BasicTag+7].text = FormatStr(@"大约%.2f",data.lastprice);
    [self labelForTag:BasicTag+8].text = data.driveryaoqiu;
}
@end

@implementation TaskInfoTableViewCell
#define InfoTag 300
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        CGFloat line_gap = 18;
        UILabel* name1Label = [self newTitleLabel];
        name1Label.text = @"线路名称";
        [self.bgView addSubview:name1Label];
        
        [name1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView).offset(1);
            make.top.equalTo(self.lineView).offset(9);
        }];
        
        UILabel* value1Label = [self newValueLabel];
        value1Label.tag = InfoTag + 1;
        [self.bgView addSubview:value1Label];
        
        [value1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(100);
            make.centerY.equalTo(name1Label).offset(0);
        }];
        
        UILabel* name2Label = [self newTitleLabel];
        name2Label.text = @"出发地点";
        [self.bgView addSubview:name2Label];
        
        [name2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap);
        }];
        
        UILabel* value2Label = [self newValueLabel];
        value2Label.tag = InfoTag + 2;
        [self.bgView addSubview:value2Label];
        
        [value2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name2Label).offset(0);
        }];
        
        UILabel* name3Label = [self newTitleLabel];
        name3Label.text = @"配送区域";
        [self.bgView addSubview:name3Label];
        
        [name3Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap*2);
        }];
        
        UILabel* value3Label = [self newValueLabel];
        value3Label.tag = InfoTag + 3;
        [self.bgView addSubview:value3Label];
        
        [value3Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name3Label).offset(0);
        }];
        
        UILabel* name4Label = [self newTitleLabel];
        name4Label.text = @"配送类型";
        [self.bgView addSubview:name4Label];
        
        [name4Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap*3);
        }];
        
        UILabel* value4Label = [self newValueLabel];
        value4Label.tag = InfoTag + 4;
        [self.bgView addSubview:value4Label];
        
        [value4Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name4Label).offset(0);
        }];
        
        UIView* line1 = [UIView new];
        line1.backgroundColor = self.lineView.backgroundColor;
        [self.bgView addSubview:line1];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.right.height.equalTo(self.lineView);
            make.top.equalTo(name4Label.mas_bottom).offset(5);
        }];
        
        UIView* line2 = [UIView new];
        line2.backgroundColor = self.lineView.backgroundColor;
        [self.bgView addSubview:line2];
        
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.right.height.equalTo(self.lineView);
            make.top.equalTo(line1.mas_bottom).offset(52);
        }];
        
        UILabel* name5Label = [self newTitleLabel];
        name5Label.font = Font_System(9);
        name5Label.text = @"司机数量";
        [self.bgView addSubview:name5Label];
        
        [name5Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.lineView.mas_right).multipliedBy(0.2);
            make.top.equalTo(line1).offset(14);
        }];
        
        UILabel* value5Label = [self newValueLabel];
//        value5Label.font = Font_System(8);
        value5Label.textColor = hexColor(fcd55a);
        value5Label.tag = InfoTag + 5;
        [self.bgView addSubview:value5Label];
        
        [value5Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(name5Label);
            make.centerY.equalTo(name5Label).offset(15);
        }];
        
//        UILabel* name6Label = [self newTitleLabel];
//        name6Label.font = name5Label.font;
//        name6Label.text = @"配送点个数";
//        [self.bgView addSubview:name6Label];
//
//        [name6Label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.lineView).multipliedBy(1.5);
//            make.centerY.equalTo(name5Label);
//        }];
//
//        UILabel* value6Label = [self newValueLabel];
//        value6Label.tag = InfoTag + 6;
//        value6Label.font = value5Label.font;
//        value6Label.textColor = value5Label.textColor;
//        [self.bgView addSubview:value6Label];
//
//        [value6Label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(name6Label);
//            make.centerY.equalTo(value5Label);
//        }];
        
        UILabel* name7Label = [self newTitleLabel];
        name7Label.font = name5Label.font;
        name7Label.text = @"到岗时间";
        [self.bgView addSubview:name7Label];
        
        [name7Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.lineView);
            make.centerY.equalTo(name5Label);
        }];
        
        UILabel* value7Label = [self newValueLabel];
        value7Label.tag = InfoTag + 7;
        value7Label.font = value5Label.font;
        value7Label.textColor = value5Label.textColor;
        [self.bgView addSubview:value7Label];
        
        [value7Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(name7Label);
            make.centerY.equalTo(value5Label);
        }];
        
        UILabel* name8Label = [self newTitleLabel];
        name8Label.font = name5Label.font;
        name8Label.text = @"预计完成时间";
        [self.bgView addSubview:name8Label];
        
        [name8Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.lineView.mas_right).multipliedBy(0.8);
            make.centerY.equalTo(name7Label);
        }];
        
        UILabel* value8Label = [self newValueLabel];
        value8Label.tag = InfoTag + 8;
        value8Label.font = value5Label.font;
        value8Label.textColor = value5Label.textColor;
        [self.bgView addSubview:value8Label];
        
        [value8Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(name8Label);
            make.centerY.equalTo(value5Label);
        }];
        
        UILabel* name9Label = [self newTitleLabel];
        name9Label.text = @"配送日期";
        name9Label.tag = InfoTag + 99;
        [self.bgView addSubview:name9Label];
        
        [name9Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(line2).offset(6);
        }];
        
        UILabel* value9Label = [self newValueLabel];
        value9Label.tag = InfoTag + 9;
        [self.bgView addSubview:value9Label];
        
        [value9Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name9Label).offset(0);
        }];
        
        UILabel* name10Label = [self newTitleLabel];
        name10Label.tag = InfoTag+100;
        name10Label.text = @"运单日期";
        [self.bgView addSubview:name10Label];
        
        [name10Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name9Label).offset(line_gap);
            make.bottom.offset(-6);
        }];
        
        UILabel* value10Label = [self newValueLabel];
        value10Label.tag = InfoTag + 10;
        [self.bgView addSubview:value10Label];
        
        [value10Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name10Label).offset(0);
        }];
    }
    return self;
}

- (void)hideYDRQ
{
    [[self labelForTag:InfoTag+99] mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-6);
    }];
    
    [self labelForTag:InfoTag+100].hidden = YES;
    [self labelForTag:InfoTag+10].hidden = YES;
}

- (void)setData:(TaskData *)data
{
    [self labelForTag:InfoTag+1].text = data.xianlu;
    [self labelForTag:InfoTag+2].text = data.fahuoaddress;
    [self labelForTag:InfoTag+3].text = data.peisongquyu;
    [self labelForTag:InfoTag+4].text = data.peisongtypeInCn;
    
    [self labelForTag:InfoTag+5].text = data.drivernum;
//    [self labelForTag:InfoTag+6].text = FormatStr(@"%ld",data.priceperone);
    [self labelForTag:InfoTag+7].text = data.daogangtime;
    [self labelForTag:InfoTag+8].text = data.costhour;
    
    [self labelForTag:InfoTag+9].text = FormatStr(@"%@到%@",data.startdate,data.enddate);
    [self labelForTag:InfoTag+10].text = data.orderdate;
}

@end

@implementation TaskInfoCargoTableViewCell
#define CargoTag 400
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        CGFloat line_gap = 18;
        UILabel* name1Label = [self newTitleLabel];
        name1Label.text = @"货物类型";
        [self.bgView addSubview:name1Label];
        
        [name1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView).offset(1);
            make.top.equalTo(self.lineView).offset(9);
        }];
        
        UILabel* value1Label = [self newValueLabel];
        value1Label.tag = CargoTag + 1;
        [self.bgView addSubview:value1Label];
        
        [value1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(100);
            make.centerY.equalTo(name1Label).offset(0);
        }];
        
        UILabel* name2Label = [self newTitleLabel];
        name2Label.text = @"货物数量";
        [self.bgView addSubview:name2Label];
        
        [name2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap);
        }];
        
        UILabel* value2Label = [self newValueLabel];
        value2Label.tag = CargoTag + 2;
        [self.bgView addSubview:value2Label];
        
        [value2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name2Label).offset(0);
        }];
        
        UILabel* name3Label = [self newTitleLabel];
        name3Label.text = @"货物总体积";
        [self.bgView addSubview:name3Label];
        
        [name3Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap*2);
        }];
        
        UILabel* value3Label = [self newValueLabel];
        value3Label.tag = CargoTag + 3;
        [self.bgView addSubview:value3Label];
        
        [value3Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name3Label).offset(0);
        }];
        
        UILabel* name4Label = [self newTitleLabel];
        name4Label.text = @"货物总重量";
        [self.bgView addSubview:name4Label];
        
        [name4Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap*3);
        }];
        
        UILabel* value4Label = [self newValueLabel];
        value4Label.tag = CargoTag + 4;
        [self.bgView addSubview:value4Label];
        
        [value4Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name4Label).offset(0);
        }];
        
        UILabel* name5Label = [self newTitleLabel];
        name5Label.text = @"其他服务";
        [self.bgView addSubview:name5Label];
        
        [name5Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name1Label);
            make.top.equalTo(name1Label).offset(line_gap*4);
            make.bottom.offset(-6);
        }];
        
        UILabel* value5Label = [self newValueLabel];
        value5Label.tag = CargoTag + 5;
        [self.bgView addSubview:value5Label];
        
        [value5Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(value1Label);
            make.centerY.equalTo(name5Label).offset(0);
        }];
        
    }
    return self;
}

- (void)setData:(TaskData *)data
{
    [self labelForTag:CargoTag+1].text = data.huowutype;
    [self labelForTag:CargoTag+2].text = FormatStr(@"%ld",data.huowunum);
    [self labelForTag:CargoTag+3].text = data.cubeInCn;
    [self labelForTag:CargoTag+4].text = data.tonInCn;
    [self labelForTag:CargoTag+5].text = data.otherservice;
}
@end

@implementation TaskInfoAdditionalTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView* ccView = [UIView new];
        ccView.backgroundColor = hexColor(f6f6f5);
        [self.bgView addSubview:ccView];
        
        [ccView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView).offset(8);
            make.left.offset(24);
            make.right.offset(-24);
            make.bottom.offset(-8);
        }];
        
        [self.bgView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(28);
            make.right.offset(-28);
            make.top.equalTo(ccView).offset(8);
            make.bottom.offset(-16);
        }];
    }
    return self;
}
- (UILabel*)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = hexColor(818181);
        _contentLabel.font = Font_System(11);
        _contentLabel.numberOfLines = 0;
        _contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH-34*2;
    }
    return _contentLabel;
}
@end
