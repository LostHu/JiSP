//
//  LeaveViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/26.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "LeaveViewController.h"
#import "LeaveTableViewCell.h"
#import "LeaveViewModel.h"
#import "AddLeaveViewController.h"

@interface LeaveViewController ()
@property (nonatomic, strong) UIButton* addBtn;
@property (nonatomic, strong) LeaveViewModel* viewModel;
@end

@implementation LeaveViewController

- (LeaveViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[LeaveViewModel alloc] init];
    }
    return _viewModel;
}

- (void)loadView
{
    [super loadView];
    
    UIButton* addBtn = [UIButton new];
//    [addBtn blueSolidStyle];
    addBtn.tag = 1001;
    [addBtn solidStyleforC:hexColor(5662f6) D:[UIColor lightGrayColor] font:Font_System(14) corner:0];
    addBtn.layer.cornerRadius = 0;
    [addBtn setTitle:@"申请请假" forState:UIControlStateNormal];
    [self.view addSubview:addBtn];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@(44));
    }];
    
    [addBtn addTarget:self action:@selector(addFreeTime) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(NavigationBarHeight);
        make.bottom.equalTo(addBtn.mas_top);
        make.left.right.centerX.equalTo(self.view);
    }];
    self.view.backgroundColor = hexColor(f5f8fa);
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.cusnavigationBar.titleLabel.text = @"我的请假";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewSafeAreaInsetsDidChange {
    [[self.view viewWithTag:1001] mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-self.view.safeAreaInsets.bottom);
    }];
    [super viewSafeAreaInsetsDidChange];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[LeaveTableViewCell class] forCellReuseIdentifier:[LeaveTableViewCell identify]];
    
    
    [self.addBtn addTarget:self action:@selector(addFreeTime) forControlEvents:UIControlEventTouchUpInside];
    
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
}

- (void)addFreeTime
{
    AddLeaveViewController* vc = [AddLeaveViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView.header beginRefreshing];
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
    return 60;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeaveTableViewCell *cell = (LeaveTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[LeaveTableViewCell identify] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = tableView.backgroundColor;
    LeaveData* data = [self.viewModel.array objectAtIndex:indexPath.section];
    cell.dateLabel.text = FormatStr(@"%@-%@",data.startdate,data.enddate);
    cell.timeLabel.text = FormatStr(@"%@",data.descrip);
    
    @weakify(self);
    [[[cell.delBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.viewModel delLeave:data block:^(id data, BOOL isTodo) {
            @strongify(self);
            if (isTodo) {
                [HUD showMsg:@"删除成功" type:HUDMsgType_Success];
                [self.viewModel getFirstList:nil];
            }
        }];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIButton*)addBtn
{
    if (!_addBtn) {
        _addBtn = [UIButton new];
    }
    return _addBtn;
}

@end
