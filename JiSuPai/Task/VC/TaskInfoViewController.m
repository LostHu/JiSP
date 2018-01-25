//
//  TaskInfoViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/14.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TaskInfoViewController.h"

@interface TaskInfoViewController ()

@end

@implementation TaskInfoViewController
{
    NSArray* _arrayTitle;
}
- (TaskInfoViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TaskInfoViewModel alloc] init];
    }
    return _viewModel;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = hexColor(f5f8fa);
    self.tableView.backgroundColor = self.view.backgroundColor;
//    self.cusnavigationBar.titleLabel.text = @"任务详情";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _arrayTitle = @[@"上传照片",@"基本信息",@"任务信息",@"货物信息及搬运信息",@"补充说明"];
    
    [self.tableView registerClass:[TaskInfoAddPhotoTableViewCell class] forCellReuseIdentifier:[TaskInfoAddPhotoTableViewCell identify]];
    [self.tableView registerClass:[TaskInfoBasicTableViewCell class] forCellReuseIdentifier:[TaskInfoBasicTableViewCell identify]];
    [self.tableView registerClass:[TaskInfoTableViewCell class] forCellReuseIdentifier:[TaskInfoTableViewCell identify]];
    [self.tableView registerClass:[TaskInfoCargoTableViewCell class] forCellReuseIdentifier:[TaskInfoCargoTableViewCell identify]];
    [self.tableView registerClass:[TaskInfoAdditionalTableViewCell class] forCellReuseIdentifier:[TaskInfoAdditionalTableViewCell identify]];
    
    [self.tableView reloadData];
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 10;
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView* view = [UIView new];
//    view.backgroundColor = [UIColor clearColor];
//
//    return view;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoAddPhotoTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
        }];
    }
    if (indexPath.row == 1) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoBasicTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
        }];
    }
    if (indexPath.row == 2) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
        }];
    }
    if (indexPath.row == 3) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoCargoTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
        }];
    }
    if (indexPath.row == 4) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoAdditionalTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
            ((TaskInfoAdditionalTableViewCell*)cell).contentLabel.text = str;
        }];
    }
    return 176;
}
NSString* str = @"What game you like best in your life? What game \
you like best in your life?What game you like best in your life?What game you like best in your life?What game you like best in your life?... \
you like best in your life...";
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TaskInfoAddPhotoTableViewCell *cell = (TaskInfoAddPhotoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoAddPhotoTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        
        return cell;
    }
    if (indexPath.row == 1) {
        TaskInfoBasicTableViewCell *cell = (TaskInfoBasicTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoBasicTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        cell.data = self.viewModel.data;
        
        return cell;
    }
    if (indexPath.row == 2) {
        TaskInfoTableViewCell *cell = (TaskInfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        cell.data = self.viewModel.data;
        
        return cell;
    }
    if (indexPath.row == 3) {
        TaskInfoCargoTableViewCell *cell = (TaskInfoCargoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoCargoTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        cell.data = self.viewModel.data;
        
        return cell;
    }
    if (indexPath.row == 4) {
        TaskInfoAdditionalTableViewCell *cell = (TaskInfoAdditionalTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoAdditionalTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        ((TaskInfoAdditionalTableViewCell*)cell).contentLabel.text = self.viewModel.data.descrip;
        
        return cell;
    }
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //    TopicDetailViewController* vc = [TopicDetailViewController new];
    //    [self.navigationController pushViewController:vc animated:YES];
}

@end
