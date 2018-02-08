//
//  FirstViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/13.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstListViewModel.h"
#import "FirstTableViewCell.h"

@interface FirstViewController ()
@property (nonatomic, strong) FirstListViewModel* viewModel;
@end

@implementation FirstViewController

- (FirstListViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[FirstListViewModel alloc] init];
    }
    return _viewModel;
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
    [self.cusnavigationBar.leftButton removeFromSuperview];
    self.cusnavigationBar.titleLabel.text = @"抢单列表";
    self.cusnavigationBar.bgView.backgroundColor = hexColor(556af6);
    self.cusnavigationBar.bottomLine.backgroundColor = hexColor(556af6);
    self.cusnavigationBar.titleLabel.textColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:[FirstTableViewCell identify]];
    
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
    
    [[RACObserve(self.viewModel, array) skip:0] subscribeNext:^(id x) {
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
    return 224;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstTableViewCell *cell = (FirstTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[FirstTableViewCell identify] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = tableView.backgroundColor;
    TaskData* task = [self.viewModel.array objectAtIndex:indexPath.section];
    cell.data = task;
    
    @weakify(self);
    [[[cell.okBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        HistoryTaskInfoViewController* vc = [HistoryTaskInfoViewController new];
        vc.viewModel.data = task;
        vc.preClass = @"FirstViewController";
        vc.sectionCount = 4;
        vc.cusnavigationBar.titleLabel.text = FormatStr(@"任务号%@",task.firstorderid);
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
