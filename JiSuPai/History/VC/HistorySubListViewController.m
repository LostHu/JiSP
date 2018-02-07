//
//  HistorySubListViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/19.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "HistorySubListViewController.h"
#import "HistoryTableViewCell.h"
#import "HistoryTaskInfoViewController.h"

@interface HistorySubListViewController ()
@end

@implementation HistorySubListViewController

- (HistorySubListViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[HistorySubListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = hexColor(f5f8fa);
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.cusnavigationBar.titleLabel.text = @"子任务列表";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[HistorySubTableViewCell class] forCellReuseIdentifier:[HistorySubTableViewCell identify]];
    
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
    return [tableView fd_heightForCellWithIdentifier:[HistorySubTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
        TaskData* task = [self.viewModel.array objectAtIndex:indexPath.section];
        ((HistoryTableViewCell*)cell).data = task;
    }];
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistorySubTableViewCell *cell = (HistorySubTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[HistorySubTableViewCell identify] forIndexPath:indexPath];
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
    
    HistoryTaskInfoViewController* vc = [HistoryTaskInfoViewController new];
    vc.viewModel.data = task;
    vc.cusnavigationBar.titleLabel.text = task.orderno;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
