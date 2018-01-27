//
//  WorkingViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/28.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "WorkingViewController.h"
#import "WorkingViewModel.h"

@interface WorkingViewController ()
@property (nonatomic, strong) WorkingViewModel* viewModelWoking;
@end

@implementation WorkingViewController

- (WorkingViewModel *)viewModelWoking
{
    if (!_viewModelWoking) {
        _viewModelWoking = [[WorkingViewModel alloc] init];
    }
    return _viewModelWoking;
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
    
    self.arrayTitle = @[@"上传照片",@"基本信息",@"任务信息",@"货物信息及搬运信息",@"补充说明"];
    
    
    @weakify(self);
    [RACObserve(self.viewModelWoking, data) subscribeNext:^(id x) {
        @strongify(self);
        if (x && [x isKindOfClass:[TaskData class]]) {
            [self.tableView reloadData];
            self.cusnavigationBar.titleLabel.text = FormatStr(@"单号%@",((TaskData*)x).orderno);
        }
    }];
    
    [self.viewModelWoking getWorkingData:^(id data, BOOL isTodo) {
        
    }];
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
            ((TaskInfoAdditionalTableViewCell*)cell).contentLabel.text = self.viewModel.data.descrip;;
        }];
    }
    return 176;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TaskInfoAddPhotoTableViewCell *cell = (TaskInfoAddPhotoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoAddPhotoTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [self.arrayTitle objectAtIndex:indexPath.row];
        
        return cell;
    }
    if (indexPath.row == 1) {
        TaskInfoBasicTableViewCell *cell = (TaskInfoBasicTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoBasicTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [self.arrayTitle objectAtIndex:indexPath.row];
        cell.data = self.viewModelWoking.data;
        
        return cell;
    }
    if (indexPath.row == 2) {
        TaskInfoTableViewCell *cell = (TaskInfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [self.arrayTitle objectAtIndex:indexPath.row];
        cell.data = self.viewModelWoking.data;
        
        return cell;
    }
    if (indexPath.row == 3) {
        TaskInfoCargoTableViewCell *cell = (TaskInfoCargoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoCargoTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [self.arrayTitle objectAtIndex:indexPath.row];
        cell.data = self.viewModelWoking.data;
        
        return cell;
    }
    if (indexPath.row == 4) {
        TaskInfoAdditionalTableViewCell *cell = (TaskInfoAdditionalTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoAdditionalTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [self.arrayTitle objectAtIndex:indexPath.row];
        ((TaskInfoAdditionalTableViewCell*)cell).contentLabel.text = self.viewModelWoking.data.descrip;
        
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
