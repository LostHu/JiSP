//
//  MeViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/13.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "MeViewController.h"
#import "MeViewModel.h"
#import "MeHeadTableViewCell.h"
#import "MeGameTableViewCell.h"
#import "HistoryViewController.h"
#import "FeedbackViewController.h"
#import "SettingViewController.h"
#import "TixianListViewController.h"
#import "CustomerFeedbackViewController.h"
#import "MyCarViewController.h"
#import "EditPasswordViewController.h"
#import "FreeTimeViewController.h"
#import "LeaveViewController.h"

@interface MeViewController ()
@property (nonatomic,strong) MeViewModel* viewModel;
@end

@implementation MeViewController

- (MeViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[MeViewModel alloc] init];
    }
    return _viewModel;
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = hexColor(556af6);
    self.tableView.backgroundColor = hexColor(efefef);
    
    [self.cusnavigationBar.leftButton removeFromSuperview];
    self.cusnavigationBar.bgView.backgroundColor = hexColor(556af6);
    self.cusnavigationBar.bottomLine.backgroundColor = hexColor(556af6);
    self.cusnavigationBar.titleLabel.text = @"个人中心";
    self.cusnavigationBar.titleLabel.textColor = [UIColor whiteColor];
    
    [self.cusnavigationBar.rightButton setImage:ImageNamed(@"tab_icon_wo") forState:UIControlStateNormal];
    [self.cusnavigationBar.rightButton addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[MeHeadTableViewCell class] forCellReuseIdentifier:[MeHeadTableViewCell identify]];
    [self.tableView registerClass:[MeHeadExtractTableViewCell class] forCellReuseIdentifier:[MeHeadExtractTableViewCell identify]];
    [self.tableView registerClass:[MeDefaultTableViewCell class] forCellReuseIdentifier:[MeDefaultTableViewCell identify]];
    [self.tableView registerClass:[MeColourfulTableViewCell class] forCellReuseIdentifier:[MeColourfulTableViewCell identify]];
    
    @weakify(self);
    [RACObserve(self.viewModel, userData) subscribeNext:^(id x) {
        @strongify(self);
        if (x && [x isKindOfClass:[UserData class]]) {
            [self.tableView reloadData];
        }
    }];
    
    [[UserManager sharedInstance] getUserDatafromNetWork];
}

- (void)setting
{
    SettingViewController* vc = [SettingViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
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
        if (indexPath.row == 0) {
            return 148;
        }
        if (indexPath.row == 1) {
            return 44;
        }
    }
    if (indexPath.section == 1) {
        return 40;
    }
    if (indexPath.section == 3) {
        return 186;
    }
    return 40;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MeHeadTableViewCell *cell = (MeHeadTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[MeHeadTableViewCell identify] forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = hexColor(556af6);
            cell.titleLabel.text = FormatStr(@"%@(%@)", self.viewModel.userData.username,self.viewModel.userData.statusInCn);
            cell.infoLabel.text = FormatStr(@"已加入%ld天，已完成%ld单",self.viewModel.userData.days,self.viewModel.userData.ordercount);
                        
            return cell;
        }
        if (indexPath.row == 1) {
            MeHeadExtractTableViewCell *cell = (MeHeadExtractTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[MeHeadExtractTableViewCell identify] forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UserData* user = self.viewModel.userData;
            [cell updateBtn:cell.edBtn title:@"已提取" count:user.yitixian];
            [cell updateBtn:cell.ingBtn title:@"提取中" count:user.tixianzhong];
            [cell updateBtn:cell.canBtn title:@"可提取" count:user.lastprice];
            [cell updateBtn:cell.confirmBtn title:@"待确认" count:user.daiqueren];
            
            return cell;
        }
    }
    if (indexPath.section == 1) {
        MeDefaultTableViewCell *cell = (MeDefaultTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[MeDefaultTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor whiteColor];
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"提现记录";
            cell.gapLineView.hidden = NO;
        }
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"申请提现";
            cell.gapLineView.hidden = NO;
        }
        if (indexPath.row == 2) {
            cell.titleLabel.text = @"历史订单";
        }
        return cell;
    }
    if (indexPath.section == 2) {
        MeDefaultTableViewCell *cell = (MeDefaultTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[MeDefaultTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.titleLabel.text = @"意见反馈";
        
        return cell;
    }
    if (indexPath.section == 3) {
        MeColourfulTableViewCell *cell = (MeColourfulTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[MeColourfulTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.arrayTitle = self.viewModel.arrayTabData;
        
        cell.selectIndex = ^(NSInteger index) {
            switch (index) {
                case 0:
                    [self navToMyCar];
                    break;
                case 1:
                    [self navToCustomerFeedback];
                    break;
                case 2:
                    
                    break;
                case 3:
                    
                    break;
                case 4:
                    [self navToFreeTime];
                    break;
                case 5:
                    
                    break;
                case 6:
                    [self navToLeave];
                    break;
                case 7:
                    [self navToEditPwd];
                    break;
                default:
                    break;
            }
        };
        
        return cell;
    }
    return nil;
}

- (void)navToLeave
{
    LeaveViewController* vc = [LeaveViewController new];
    vc.cusnavigationBar.titleLabel.text = @"我的请假";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navToEditPwd
{
    EditPasswordViewController* vc = [EditPasswordViewController new];
    vc.cusnavigationBar.titleLabel.text = @"修改密码";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navToMyCar
{
    MyCarViewController* vc = [MyCarViewController new];
    vc.cusnavigationBar.titleLabel.text = @"车辆信息";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navToCustomerFeedback
{
    CustomerFeedbackViewController* vc = [CustomerFeedbackViewController new];
    vc.cusnavigationBar.titleLabel.text = @"客户评价";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navToFreeTime
{
    FreeTimeViewController* vc = [FreeTimeViewController new];
    vc.cusnavigationBar.titleLabel.text = @"空闲时间";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认申请吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = @"请输入提现金额";
                textField.keyboardType = UIKeyboardTypeNumberPad;
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            }];
        
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField *textField = alertController.textFields.firstObject;
                NSString* value = textField.text;
            }];
        
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            TixianListViewController* vc = [TixianListViewController new];
            vc.cusnavigationBar.titleLabel.text = @"提现记录";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 2) {
            HistoryViewController* vc = [HistoryViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            FeedbackViewController* vc = [FeedbackViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }

}

@end
