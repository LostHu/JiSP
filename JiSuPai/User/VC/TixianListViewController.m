//
//  TixianListViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/21.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TixianListViewController.h"
#import "TiXianTableViewModel.h"
#import "TixianTableViewCell.h"

@interface TixianListViewController ()
@property (nonatomic, strong) TiXianTableViewModel* viewModel;
@end

@implementation TixianListViewController

- (TiXianTableViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TiXianTableViewModel alloc] init];
    }
    return _viewModel;
}

- (void)loadView
{
    [super loadView];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(NavigationBarHeight);
        make.left.bottom.right.centerX.equalTo(self.view);
    }];
    self.view.backgroundColor = hexColor(f5f8fa);
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.cusnavigationBar.titleLabel.text = @"提现记录";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[TixianTableViewCell class] forCellReuseIdentifier:[TixianTableViewCell identify]];
    
    
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
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (self.viewModel.bLast) {
            [self.tableView.footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    }];
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
    return [tableView fd_heightForCellWithIdentifier:[TixianTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
        TixianData* data = [self.viewModel.array objectAtIndex:indexPath.section];
        ((TixianTableViewCell*)cell).dateLabel.text = FormatStr(@"%@",data.createtime);
        ((TixianTableViewCell*)cell).sqjeLabel.text = FormatStr(@"申请金额：%.2f",data.shenqingjine);
        ((TixianTableViewCell*)cell).tixianLabel.text = FormatStr(@"提现金额：%.2f",data.tixianjine);
        ((TixianTableViewCell*)cell).descLabel.text = FormatStr(@"备注：%@",data.descrip);
        [((TixianTableViewCell*)cell).stateBtn setTitle:data.statusInCn forState:UIControlStateNormal];
    }];
    return 60;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TixianTableViewCell *cell = (TixianTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TixianTableViewCell identify] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = tableView.backgroundColor;
    TixianData* data = [self.viewModel.array objectAtIndex:indexPath.section];
    cell.dateLabel.text = FormatStr(@"%@",data.createtime);
    cell.sqjeLabel.text = FormatStr(@"申请金额：%.2f",data.shenqingjine);
    cell.tixianLabel.text = FormatStr(@"提现金额：%.2f",data.tixianjine);
    cell.descLabel.text = FormatStr(@"备注：%@",data.descrip);
    [cell.stateBtn setTitle:data.statusInCn forState:UIControlStateNormal];
    
//    @weakify(self);
//    [[[cell.delBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
//        @strongify(self);
//
//        [self.viewModel delFreeTime:data block:^(id data, BOOL isTodo) {
//            @strongify(self);
//            if (isTodo) {
//                [HUD showMsg:@"删除成功" type:HUDMsgType_Success];
//                [self.viewModel getFirstList:nil];
//            }
//        }];
//    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
