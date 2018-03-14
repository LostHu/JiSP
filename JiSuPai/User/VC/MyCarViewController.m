//
//  MyCarViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/21.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "MyCarViewController.h"
#import "MyCarViewModel.h"
#import "MeGameTableViewCell.h"
#import "MyCarBaseTableViewCell.h"
#import "ZLPhotoActionSheet.h"
#import "ZLPhotoConfiguration.h"
#import <Photos/Photos.h>

#define PHOTOVIEW_MAX_COUNT 1


@interface MyCarViewController ()
@property (nonatomic, strong) MyCarViewModel* viewModel;
@property (nonatomic, strong) ZLPhotoActionSheet* actionSheet;
@property (nonatomic, strong) UIButton* selectBtn;
@end

@implementation MyCarViewController

{
//    UIButton* _selectBtn;
}

- (MyCarViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[MyCarViewModel alloc] init];
    }
    return _viewModel;
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = hexColor(556af6);
    self.tableView.backgroundColor = hexColor(efefef);
    
    UIButton* addBtn = [UIButton new];
    [addBtn blueSolidStyle];
    [addBtn setBackgroundImage:[UIImage imageWithColor:hexColor(5662f6)] forState:UIControlStateNormal];
    addBtn.layer.cornerRadius = 0;
    [addBtn setTitle:@"提交" forState:UIControlStateNormal];
    addBtn.titleLabel.font = Font_System(15);
    [self.view addSubview:addBtn];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@(44));
    }];
    
    [addBtn addTarget:self action:@selector(postDriverInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(NavigationBarHeight);
        make.bottom.equalTo(addBtn.mas_top);
        make.left.right.centerX.equalTo(self.view);
    }];
    
//    self.cusnavigationBar.bgView.backgroundColor = hexColor(556af6);
//    self.cusnavigationBar.bottomLine.backgroundColor = hexColor(556af6);
    self.cusnavigationBar.titleLabel.text = @"车辆认证";
//    self.cusnavigationBar.titleLabel.textColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[MeDefaultTableViewCell class] forCellReuseIdentifier:[MeDefaultTableViewCell identify]];
    [self.tableView registerClass:[MyCarPhotoTableViewCell class] forCellReuseIdentifier:[MyCarPhotoTableViewCell identify]];
    [self.tableView registerClass:[MyCarDriverPhotoTableViewCell class] forCellReuseIdentifier:[MyCarDriverPhotoTableViewCell identify]];
    
    @weakify(self);
    [RACObserve(self.viewModel, driverData) subscribeNext:^(id x) {
        @strongify(self);
        if (x && [x isKindOfClass:[DriverData class]]) {
            [self.tableView reloadData];
        }
    }];
    
    [self.viewModel getCarTypeList:^(id data, BOOL isTodo) {
    }];
    [self.viewModel getDriverInfo:^(id data, BOOL isTodo) {
    }];
    
    self.actionSheet.sender = self;
    [self.actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        @strongify(self);
        if (images && images.count > 0) {
            // 删除本次删除的图片
//            NSMutableArray* lastArrayAssets = [self getPhotoAssets];
//            if (lastArrayAssets.count > 0)
//            {
//                // 新的选择集合中不存在上次选择的图片，删除UI上的view
//                for (PHAsset* lastAsset in lastArrayAssets) {
//                    if (![assets containsObject:lastAsset]) {
//                        [self deletePhotoViewforAsset:lastAsset];
//                    }
//                }
//            }
//            // 更新后的图片选择集合
//            lastArrayAssets = [self getPhotoAssets];
//
//            // 添加新图片
            for (int i=0; i<images.count; i++) {
                UIImage* img = [images objectAtIndex:i];
//                PHAsset* newAsset = [assets objectAtIndex:i];

                if (self.selectBtn) {
                    [self.viewModel postDriverPhoto:img tag:self.selectBtn.tag block:^(id data, BOOL isTodo) {
                        @strongify(self);
                        if (isTodo) {
                            [self.selectBtn setBackgroundImage:img forState:UIControlStateNormal];
                        }
                        self.selectBtn = nil;
                    }];
                }
            }
        }
    }];
}

- (void)postDriverInfo
{
    [self.viewModel postDirverData:^(id data, BOOL isTodo) {
        if (isTodo) {
            [HUD showMsg:@"更新成功" type:HUDMsgType_Success];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)change
{
    // 缓存中是否有照片了，有的话弹确认框
    if ([self.viewModel checkPhoto:self.selectBtn.tag]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认重新上传照片吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        @weakify(self);
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            self.actionSheet.configuration.maxSelectCount = PHOTOVIEW_MAX_COUNT;
            [self.actionSheet showPhotoLibrary];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        self.actionSheet.configuration.maxSelectCount = PHOTOVIEW_MAX_COUNT;
        [self.actionSheet showPhotoLibrary];
    }
}

- (void)selectRegion
{
    @weakify(self);
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i<self.viewModel.arrayRegion.count; i++) {
        NSString* title = [self.viewModel.arrayRegion objectAtIndex:i];
        UIAlertAction* newAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            self.viewModel.driverData.region = title;
            [self.tableView reloadData];
        }];
        [alertController addAction:newAction];
    }
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

- (void)selectCarType
{
    @weakify(self);
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i<self.viewModel.arrayCarType.count; i++) {
        NSDictionary* dic = [self.viewModel.arrayCarType objectAtIndex:i];
        NSString* type = [dic.allKeys firstObject];
        NSString* title = [dic.allValues firstObject];
        UIAlertAction* newAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            self.viewModel.driverData.cartypeInCn = title;
            self.viewModel.driverData.cartype = [type integerValue];
            [self.tableView reloadData];
        }];
        [alertController addAction:newAction];
    }
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

- (void)editInfo:(NSIndexPath*)indexPath
{
    MeDefaultTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        NSString* title = FormatStr(@"修改%@",cell.titleLabel.text);
        NSString* value = cell.infoLabel.text;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.text = value;
            textField.placeholder = FormatStr(@"请输入%@",cell.titleLabel.text);
//            textField.keyboardType = UIKeyboardTypeNumberPad;
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *textField = alertController.textFields.firstObject;
            NSString* newValue = textField.text;
            if (![newValue isEqualToString:value]) {
                if (indexPath.row == 0) {
                    self.viewModel.driverData.username = newValue;
                }
                if (indexPath.row == 3) {
                    self.viewModel.driverData.carno = newValue;
                }
                if (indexPath.row == 4) {
                    self.viewModel.driverData.sfzno = newValue;
                }
                if (indexPath.row == 5) {
                    self.viewModel.driverData.jzno = newValue;
                }
                [self.tableView reloadData];
            }
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    }
    if (section == 1) {
        return 4;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 36;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [UIView new];
    view.backgroundColor = tableView.backgroundColor;
    UILabel* titleLabel = [UILabel new];
    NSString* title = @"请完善以下信息";
    NSString* info = @"带*为必填项目";
    NSRange rangeTitle = NSMakeRange(0, title.length);
    NSRange rangeInfo = NSMakeRange(title.length, info.length);
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:FormatStr(@"%@%@",title,info)];
    [str setFont:Font_System(13) range:rangeTitle];
    [str setColor:[UIColor grayColor] range:rangeTitle];
    [str setFont:Font_System(10) range:rangeInfo];
    [str setColor:[UIColor redColor] range:rangeInfo];
    titleLabel.attributedText = str;
    [view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(12);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 8;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 3) {
            return 270;
        }
        return 160;
    }
    return 40;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MeDefaultTableViewCell *cell = (MeDefaultTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[MeDefaultTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor whiteColor];
        
//        [cell.iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            
//        };
        
        cell.infoLabel.font = Font_System(12);
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"姓名";
            cell.gapLineView.hidden = NO;
            cell.infoLabel.text = self.viewModel.driverData.username;
            cell.iconView.image = ImageNamed(@"车牌号");
        }
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"区域";
            cell.gapLineView.hidden = NO;
            cell.infoLabel.text = self.viewModel.driverData.region;
            cell.iconView.image = ImageNamed(@"车型");
        }
        if (indexPath.row == 2) {
            cell.titleLabel.text = @"车型";
            cell.gapLineView.hidden = NO;
            cell.infoLabel.text = self.viewModel.driverData.cartypeInCn;
            cell.iconView.image = ImageNamed(@"车型");
        }
        if (indexPath.row == 3) {
            cell.titleLabel.text = @"车牌号";
            cell.gapLineView.hidden = NO;
            cell.infoLabel.text = self.viewModel.driverData.carno;
            cell.iconView.image = ImageNamed(@"车牌号");
        }
        if (indexPath.row == 4) {
            cell.titleLabel.text = @"身份证";
            cell.gapLineView.hidden = NO;
            cell.infoLabel.text = self.viewModel.driverData.sfzno;
            cell.iconView.image = ImageNamed(@"车牌号");
        }
        if (indexPath.row == 5) {
            cell.titleLabel.text = @"驾驶证";
            cell.gapLineView.hidden = NO;
            cell.infoLabel.text = self.viewModel.driverData.jzno;
            cell.iconView.image = ImageNamed(@"车牌号");
        }
        return cell;
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row < 3) {
            MyCarPhotoTableViewCell *cell = (MyCarPhotoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[MyCarPhotoTableViewCell identify] forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor whiteColor];
            
            cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
            cell.titleLabel.text = [self.viewModel.arrayTitle objectAtIndex:indexPath.row];
            
            if (indexPath.row == 0) {
                cell.infoLabel1.text = @"点击上传身份证正面照";
                cell.infoLabel2.text = @"点击上传身份证反面照";
            }
            if (indexPath.row == 1) {
                cell.infoLabel1.text = @"车牌号清晰，车头完整";
                cell.infoLabel2.text = @"点击上传";
                cell.sfz1Btn.enabled = NO;
                [cell.sfz1Btn setImage:ImageNamed(@"车头") forState:UIControlStateDisabled];
            }
            if (indexPath.row == 2) {
                cell.infoLabel1.text = @"车辆侧面完整";
                cell.infoLabel2.text = @"点击上传";
                cell.sfz1Btn.enabled = NO;
                [cell.sfz1Btn setImage:ImageNamed(@"车辆侧面") forState:UIControlStateDisabled];
            }
            cell.sfz1Btn.tag = indexPath.row*10+1;
            cell.sfz2Btn.tag = indexPath.row*10+2;
            NSString* url1 = [self.viewModel getPhotoUrl:[self.viewModel getKeyforTag:cell.sfz1Btn.tag]];
            NSString* url2 = [self.viewModel getPhotoUrl:[self.viewModel getKeyforTag:cell.sfz2Btn.tag]];
            [cell.sfz1Btn setBackgroundImageWithURL:URLStr(url1) forState:UIControlStateNormal placeholder:ImageNamed(@"+")];
            [cell.sfz2Btn setBackgroundImageWithURL:URLStr(url2) forState:UIControlStateNormal placeholder:ImageNamed(@"+")];
            
            @weakify(self);
            @weakify(cell);
            [[[cell.sfz1Btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
                @strongify(self);
                @strongify(cell);
                self.selectBtn = cell.sfz1Btn;
                [self change];
            }];
            [[[cell.sfz2Btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
                @strongify(self);
                @strongify(cell);
                self.selectBtn = cell.sfz2Btn;
                [self change];
            }];
            
            return cell;
        }
        else
        {
            MyCarDriverPhotoTableViewCell *cell = (MyCarDriverPhotoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[MyCarDriverPhotoTableViewCell identify] forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor whiteColor];
            
            cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
            cell.titleLabel.text = [self.viewModel.arrayTitle objectAtIndex:indexPath.row];

            cell.infoLabel1.text = @"点击上传行驶证";
            cell.infoLabel2.text = @"点击上传驾驶证";
            cell.infoLabel3.text = @"点击上传通行证";
            
            cell.sfz1Btn.tag = indexPath.row*10+1;
            cell.sfz2Btn.tag = indexPath.row*10+2;
            cell.sfz3Btn.tag = indexPath.row*10+3;
            
            NSString* url1 = [self.viewModel getPhotoUrl:[self.viewModel getKeyforTag:cell.sfz1Btn.tag]];
            NSString* url2 = [self.viewModel getPhotoUrl:[self.viewModel getKeyforTag:cell.sfz2Btn.tag]];
            NSString* url3 = [self.viewModel getPhotoUrl:[self.viewModel getKeyforTag:cell.sfz3Btn.tag]];
            [cell.sfz1Btn setBackgroundImageWithURL:URLStr(url1) forState:UIControlStateNormal placeholder:ImageNamed(@"+")];
            [cell.sfz2Btn setBackgroundImageWithURL:URLStr(url2) forState:UIControlStateNormal placeholder:ImageNamed(@"+")];
            [cell.sfz3Btn setBackgroundImageWithURL:URLStr(url3) forState:UIControlStateNormal placeholder:ImageNamed(@"+")];
            
            @weakify(self);
            @weakify(cell);
            [[[cell.sfz1Btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
                @strongify(self);
                @strongify(cell);
                self.selectBtn = cell.sfz1Btn;
                [self change];
            }];
            [[[cell.sfz2Btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
                @strongify(self);
                @strongify(cell);
                self.selectBtn = cell.sfz2Btn;
                [self change];
            }];
            [[[cell.sfz3Btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
                @strongify(self);
                @strongify(cell);
                self.selectBtn = cell.sfz3Btn;
                [self change];
            }];
            
            return cell;
        }
        
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            [self selectRegion];
        }
        else if (indexPath.row == 2) {
            [self selectCarType];
        }
        else
        {
            [self editInfo:indexPath];
        }
    }
    
}

- (ZLPhotoActionSheet*)actionSheet
{
    if (!_actionSheet) {
        _actionSheet = [ZLPhotoActionSheet new];
//        _actionSheet.configuration.allowEditImage = YES;
//        _actionSheet.configuration = ((ZLPhotoConfiguration*)[ZLPhotoConfiguration defaultPhotoConfiguration]);
        _actionSheet.configuration.allowTakePhotoInLibrary = NO;    // 不允许相册内拍照
        _actionSheet.configuration.allowSelectOriginal = NO;    // 不允许原图
        //        _actionSheet.configuration.allowMixSelect = NO;     // 不允许同时选择视频和图片
        //        _actionSheet.configuration.allowSelectVideo = NO;   // 不允许视频
        //        _actionSheet.configuration.allowSelectGif = NO;     // 不允许选择gif
    }
    return _actionSheet;
}

@end
