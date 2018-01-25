//
//  HistoryViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/13.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryListViewModel.h"
#import "HistoryTableViewCell.h"
#import "HistorySubListViewController.h"


@interface HistoryViewController ()
@property (nonatomic, strong) HistoryListViewModel* viewModel;
@end

@implementation HistoryViewController

- (HistoryListViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[HistoryListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)loadView
{
    [super loadView];
    
    //    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.barView.mas_bottom);
    //        make.left.right.bottom.centerX.equalTo(self.view);
    //    }];
    self.view.backgroundColor = hexColor(f5f8fa);
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.cusnavigationBar.leftButton removeFromSuperview];
    self.cusnavigationBar.titleLabel.text = @"历史订单";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[HistoryTableViewCell class] forCellReuseIdentifier:[HistoryTableViewCell identify]];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.viewModel getFirstList:^(id data, BOOL isTodo) {
        }];
    }];
    
    @weakify(self);
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel getData:^(id data, BOOL isTodo) {
        }];
    }];
    self.tableView.footer = footer;
    
    [[RACObserve(self.viewModel, array) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        //        self.tableView.emptyDataSetDelegate = self;
        //        self.tableView.emptyDataSetSource = self;
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (self.viewModel.bLast) {
            [self.tableView.footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    }];
    
    [self.tableView.header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModel.array.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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
    return [tableView fd_heightForCellWithIdentifier:[HistoryTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
        TaskData* task = [self.viewModel.array objectAtIndex:indexPath.section];
        ((HistoryTableViewCell*)cell).data = task;
    }];
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryTableViewCell *cell = (HistoryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[HistoryTableViewCell identify] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = tableView.backgroundColor;
    TaskData* task = [self.viewModel.array objectAtIndex:indexPath.section];
    cell.data = task;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TaskData* task = [self.viewModel.array objectAtIndex:indexPath.section];
    
    HistorySubListViewController* vc = [HistorySubListViewController new];
    vc.viewModel.taskData = task;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
