//
//  WorkingViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/28.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "WorkingViewController.h"
#import "TaskInfoTableViewCell.h"
#import "ExceptionWorkingViewController.h"


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
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(NavigationBarHeight);
        make.left.right.centerX.equalTo(self.view);
        make.bottom.offset(-UITabBarHeight);
    }];
    
    self.view.backgroundColor = hexColor(f5f8fa);
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.cusnavigationBar.leftButton.hidden = YES;
    
    self.cusnavigationBar.bgView.backgroundColor = hexColor(556af6);
    self.cusnavigationBar.bottomLine.backgroundColor = hexColor(556af6);
    self.cusnavigationBar.titleLabel.textColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arrayTitle = @[@"基本信息",@"任务信息",@"货物信息及搬运信息",@"补充说明",@"照片",];
    
    [self.tableView registerClass:[TaskInfoAddPhotoTableViewCell class] forCellReuseIdentifier:[TaskInfoAddPhotoTableViewCell identify]];
    [self.tableView registerClass:[TaskInfoBasicTableViewCell class] forCellReuseIdentifier:[TaskInfoBasicTableViewCell identify]];
    [self.tableView registerClass:[TaskInfoTableViewCell class] forCellReuseIdentifier:[TaskInfoTableViewCell identify]];
    [self.tableView registerClass:[TaskInfoCargoTableViewCell class] forCellReuseIdentifier:[TaskInfoCargoTableViewCell identify]];
    [self.tableView registerClass:[TaskInfoAdditionalTableViewCell class] forCellReuseIdentifier:[TaskInfoAdditionalTableViewCell identify]];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.viewModelWoking getWorkingData:^(id data, BOOL isTodo) {
            
        }];
    }];
    
    @weakify(self);
    [RACObserve(self.viewModelWoking, data) subscribeNext:^(id x) {
        @strongify(self);
        if (x && [x isKindOfClass:[TaskData class]]) {
            [self.tableView.header endRefreshing];
            self.tableView.tableFooterView.hidden = NO;
            [self.tableView reloadData];
            self.cusnavigationBar.titleLabel.text = FormatStr(@"单号%@",((TaskData*)x).orderno);
        }
        else
        {
            self.cusnavigationBar.titleLabel.text = @"无配送任务";
        }
    }];
    
    UIView* footView = [UIView new];
    footView.backgroundColor = self.view.backgroundColor;
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    
    UIButton* exceptionBtn = [UIButton new];
    [exceptionBtn setTitle:@"异常上报" forState:UIControlStateNormal];
    [exceptionBtn solidStyleforC:hexColor(557ef4) D:[UIColor lightGrayColor] font:Font_System(12) corner:3];
    [exceptionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exceptionBtn addTarget:self action:@selector(navToExceptionPage) forControlEvents:UIControlEventTouchUpInside];

    [footView addSubview:exceptionBtn];
    [exceptionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footView);
        make.left.offset(5);
        make.right.offset(-5);
        make.height.mas_equalTo(@(26));
    }];
    
    self.tableView.tableFooterView = footView;
    self.tableView.tableFooterView.hidden = YES;
    
    [self.tableView.header beginRefreshing];
    [RACObserve(self.viewModelWoking, arrayPhotos) subscribeNext:^(id x) {
        @strongify(self);
        if (x && [x isKindOfClass:[NSArray class]]) {
            [self.tableView reloadData];
        }
    }];
    
    [self.viewModel getOrderPhoto:nil];
}

- (void)navToExceptionPage
{
    ExceptionWorkingViewController* vc = [ExceptionWorkingViewController new];
    vc.viewModel = self.viewModelWoking;
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
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModelWoking.data) {
        return 5;
    }
    return 0;
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
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoBasicTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
        }];
    }
    if (indexPath.row == 1) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
        }];
    }
    if (indexPath.row == 2) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoCargoTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
        }];
    }
    if (indexPath.row == 3) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoAdditionalTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
            ((TaskInfoAdditionalTableViewCell*)cell).contentLabel.text = self.viewModelWoking.data.descrip;;
        }];
    }
    if (indexPath.row == 4) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoAddPhotoTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
            ((TaskInfoAddPhotoTableViewCell*)cell).array = self.viewModelWoking.arrayPhotos;
        }];
    }
    return 176;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TaskInfoBasicTableViewCell *cell = (TaskInfoBasicTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoBasicTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        cell.data = self.viewModelWoking.data;
        
        return cell;
    }
    if (indexPath.row == 1) {
        TaskInfoTableViewCell *cell = (TaskInfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        cell.data = self.viewModelWoking.data;
        
        return cell;
    }
    if (indexPath.row == 2) {
        TaskInfoCargoTableViewCell *cell = (TaskInfoCargoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoCargoTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        cell.data = self.viewModelWoking.data;
        
        return cell;
    }
    if (indexPath.row == 3) {
        TaskInfoAdditionalTableViewCell *cell = (TaskInfoAdditionalTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoAdditionalTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        ((TaskInfoAdditionalTableViewCell*)cell).contentLabel.text = self.viewModelWoking.data.descrip;
        
        return cell;
    }
    if (indexPath.row == 4) {
        TaskInfoAddPhotoTableViewCell *cell = (TaskInfoAddPhotoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoAddPhotoTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        ((TaskInfoAddPhotoTableViewCell*)cell).array = self.viewModelWoking.arrayPhotos;
        
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
