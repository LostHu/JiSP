//
//  SettingViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/21.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "SettingViewController.h"
#import "MeGameTableViewCell.h"
#import "LogInViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = hexColor(556af6);
    self.tableView.backgroundColor = hexColor(efefef);
    
    self.cusnavigationBar.titleLabel.text = @"设置";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[MeDefaultTableViewCell class] forCellReuseIdentifier:[MeDefaultTableViewCell identify]];
}

- (void)setting
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
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
    return 50;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MeDefaultTableViewCell *cell = (MeDefaultTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[MeDefaultTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor whiteColor];
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"分享";
            cell.gapLineView.hidden = NO;
        }
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"退出";
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
        }
        if (indexPath.row == 1) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认退出账号吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            @weakify(self);
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                @strongify(self);
                [[UserManager sharedInstance] clearUserData];
                [self.navigationController popToRootViewControllerAnimated:NO];
                [YZRoutes showLoginPage];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];

            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    
}

- (void)navToLogin
{
    [[UserManager sharedInstance] clearUserData];
    [self.navigationController popToRootViewControllerAnimated:NO];
    LogInViewController* vc = [LogInViewController new];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}

@end
