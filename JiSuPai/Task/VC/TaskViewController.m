//
//  TaskViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/13.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskTableViewCell.h"
#import "TaskInfoViewController.h"
#import "TaskDateBarView.h"
#import "TaskListViewModel.h"

@interface TaskViewController ()
@property (nonatomic,strong) TaskListViewModel* viewModel;
@property (nonatomic,strong) TaskDateBarView* barView;
@end

@implementation TaskViewController

- (TaskListViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TaskListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)loadView
{
    [super loadView];
    
    self.barView.backgroundColor = hexColor(ffffff);
    [self.view addSubview:self.barView];
    [self.barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.cusnavigationBar.mas_bottom);
        make.height.mas_equalTo(@(36));
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.barView.mas_bottom);
        make.left.right.bottom.centerX.equalTo(self.view);
    }];
    self.view.backgroundColor = hexColor(f5f8fa);
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.cusnavigationBar.leftButton removeFromSuperview];
    self.cusnavigationBar.titleLabel.text = @"任务大厅";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[TaskTableViewCell class] forCellReuseIdentifier:[TaskTableViewCell identify]];
    
    
    [self.barView.selBtn addTarget:self action:@selector(selectDay) forControlEvents:UIControlEventTouchUpInside];
    [self.barView.dateBtn addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [RACObserve(self.viewModel, date) subscribeNext:^(id x) {
        @strongify(self);
        if (x && [x isKindOfClass:[NSDate class]]) {
            self.barView.timeStamp = [((NSDate*)x) timeIntervalSince1970];
        }
    }];
}

- (void)selectDay
{
   @weakify(self);
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *tomorrowAction = [UIAlertAction actionWithTitle:@"明天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        self.viewModel.date = [[NSDate date] dateByAddingDays:1];
    }];
    UIAlertAction* todayAction = [UIAlertAction actionWithTitle:@"今天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        self.viewModel.date = [NSDate date];
    }];
    UIAlertAction* yesterdayAction = [UIAlertAction actionWithTitle:@"昨天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        self.viewModel.date = [[NSDate date] dateByAddingDays:-1];
    }];
    UIAlertAction* beforeYesterdayAction = [UIAlertAction actionWithTitle:@"前天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        self.viewModel.date = [[NSDate date] dateByAddingDays:-2];
    }];
    UIAlertAction* allDayAction = [UIAlertAction actionWithTitle:@"所有" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:tomorrowAction];
    [alertController addAction:todayAction];
    [alertController addAction:yesterdayAction];
    [alertController addAction:beforeYesterdayAction];
    [alertController addAction:allDayAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

- (void)selectDate
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
    return 160;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskTableViewCell *cell = (TaskTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskTableViewCell identify] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = tableView.backgroundColor;
    TaskData* task = [self.viewModel.array objectAtIndex:indexPath.section];
    cell.data = task;
    //    cell.arrayVoteData = self.viewModel.array;
    
    @weakify(self);
    [[cell.infoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        TaskInfoViewController* vc = [TaskInfoViewController new];
        vc.viewModel.data = task;
        vc.cusnavigationBar.titleLabel.text = task.orderno;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    TaskData* task = [self.viewModel.array objectAtIndex:indexPath.section];
}

- (TaskDateBarView*)barView
{
    if (!_barView) {
        _barView = [TaskDateBarView new];
    }
    return _barView;
}

@end
