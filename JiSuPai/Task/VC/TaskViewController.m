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

@interface TaskViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) TaskListViewModel* viewModel;
@property (nonatomic,strong) TaskDateBarView* barView;
@property (nonatomic, strong) UIDatePicker* datePicker;
@property (nonatomic, strong) UIView* maskView;
@property (nonatomic, strong) UIToolbar *toolBar;
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
        make.left.right.centerX.equalTo(self.view);
        make.bottom.offset(-UITabBarHeight);
    }];
    self.view.backgroundColor = hexColor(f5f8fa);
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.cusnavigationBar.leftButton removeFromSuperview];
    self.cusnavigationBar.titleLabel.text = @"任务大厅";
    self.cusnavigationBar.bgView.backgroundColor = hexColor(556af6);
    self.cusnavigationBar.bottomLine.backgroundColor = hexColor(556af6);
    self.cusnavigationBar.titleLabel.textColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.maskView];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.maskView.hidden = YES;
    
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.datePicker];
    self.toolBar.hidden = YES;
    self.datePicker.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[TaskTableViewCell class] forCellReuseIdentifier:[TaskTableViewCell identify]];
    
    UITapGestureRecognizer *tapSuperGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDay)];
    tapSuperGesture.delegate = self;
    [self.barView.dayLabel addGestureRecognizer:tapSuperGesture];
    
    self.tableView.placeholderView.titleLabel.text = @"暂无出车计划";
    [self.barView.selBtn addTarget:self action:@selector(selectDay) forControlEvents:UIControlEventTouchUpInside];
    [self.barView.dateBtn addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSpace)];
    tapGesture.delegate = self;
    [self.maskView addGestureRecognizer:tapGesture];
    
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
    
    [[RACObserve(self.viewModel, resultArray) skip:0] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (self.viewModel.bLast) {
            [self.tableView.footer endRefreshingWithNoMoreData];
        }
    }];
    
    [self.tableView.header beginRefreshing];
    
    [RACObserve(self.viewModel, date) subscribeNext:^(id x) {
        @strongify(self);
        if (x && [x isKindOfClass:[NSDate class]]) {
            if ([(NSDate*)x isEqualToDate:AllDate]) {
                self.barView.titleLabel.text = @"所有";
            }
            else
                self.barView.titleLabel.text = [LostTimer parseDate:[((NSDate*)x) timeIntervalSince1970]];
        }
    }];
}

- (void)selectDay
{
   @weakify(self);
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *tomorrowAction = [UIAlertAction actionWithTitle:@"明天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        self.barView.dayLabel.text = @"明天";
        self.viewModel.date = [[NSDate date] dateByAddingDays:1];
    }];
    UIAlertAction* todayAction = [UIAlertAction actionWithTitle:@"今天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        self.barView.dayLabel.text = @"今天";
        self.viewModel.date = [NSDate date];
    }];
    UIAlertAction* yesterdayAction = [UIAlertAction actionWithTitle:@"昨天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        self.barView.dayLabel.text = @"昨天";
        self.viewModel.date = [[NSDate date] dateByAddingDays:-1];
    }];
    UIAlertAction* beforeYesterdayAction = [UIAlertAction actionWithTitle:@"前天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        self.barView.dayLabel.text = @"前天";
        self.viewModel.date = [[NSDate date] dateByAddingDays:-2];
    }];
    UIAlertAction* allDayAction = [UIAlertAction actionWithTitle:@"所有" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.barView.dayLabel.text = @"所有";
        self.viewModel.date = AllDate;
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
    self.maskView.hidden = NO;
    [self.toolBar setHidden:NO];
    CGRect rect_tool_bar = self.toolBar.frame;
    rect_tool_bar.origin.y = SCREEN_HEIGHT - 210.f - 40.f;
    [self.toolBar setFrame:rect_tool_bar];
    [self showViewWithAnimation:self.toolBar YPostion:self.toolBar.frame.origin.y];//动画显示
    
    [self.datePicker setHidden:NO];
    CGRect rect_date_picker = self.datePicker.frame;
    rect_date_picker.origin.y = SCREEN_HEIGHT - 210.f;
    [self.datePicker setFrame:rect_date_picker];
    [self showViewWithAnimation:self.datePicker YPostion:self.datePicker.frame.origin.y];//动画显示
}

- (void)chooseDate:(UIDatePicker*)sender
{
    self.viewModel.date = self.datePicker.date;
    [self touchSpace];
}

- (void)touchSpace
{
    self.maskView.hidden = YES;
    [self hideViewWithAnimation:self.toolBar];
    [self hideViewWithAnimation:self.datePicker];
    [self.view endEditing:YES];
}

//显示动画
- (void)showViewWithAnimation:(UIView *)view YPostion:(float)yPosition
{
    CGRect rect_origin = view.frame;
    rect_origin.origin.y = SCREEN_HEIGHT;
    view.frame = rect_origin;
    //    view.alpha = 0.5f;
    
    @weakify(self);
    [UIView animateWithDuration:0.5f animations:^{
        @strongify(self);
        self.tabBarController.tabBar.hidden = YES;
        CGRect rect_current = view.frame;
        rect_current.origin.y = yPosition;
        view.frame = rect_current;
        //        view.alpha = 1.0f;
    } completion:^(BOOL finished){
        
    }];
}

//隐藏动画
- (void)hideViewWithAnimation:(UIView *)view
{
    @weakify(self);
    [UIView animateWithDuration:0.5f animations:^{
        CGRect rect_current = view.frame;
        rect_current.origin.y = SCREEN_HEIGHT;
        view.frame = rect_current;
    } completion:^(BOOL finished){
        @strongify(self);
        [view setHidden:YES];
        self.tabBarController.tabBar.hidden = NO;
    }];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)dealloc
{
    _toolBar = nil;
    _datePicker = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModel.resultArray.count;
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
    TaskData* task = [self.viewModel.resultArray objectAtIndex:indexPath.section];
    cell.data = task;
    
    @weakify(self);
    [[[cell.infoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        TaskInfoViewController* vc = [TaskInfoViewController new];
        vc.viewModel.data = task;
        vc.cusnavigationBar.titleLabel.text = task.orderno;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [[[cell.okBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self opTask:task];
    }];
    
    [[[cell.phoneBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        [CallManager callPhone:task.fahuophone];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)opTask:(TaskData*)task
{
    NSString* title = @"";
    
    if (task.orderstatus == 1) {
        title = @"确认抢单吗？";
    }
    if (task.orderstatus == 2) {
        title = @"确认取消订单吗？";
    }
    if (task.orderstatus == 3) {
        title = @"确认开始工作吗？";
    }
    if (task.orderstatus == 4) {
        title = @"确认完成工作吗？";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    @weakify(self);
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        if (task.orderstatus == 1) {
            [self.viewModel firstTask:task];
        }
        if (task.orderstatus == 2) {
            [self.viewModel cancelTask:task];
        }
        if (task.orderstatus == 3) {
            [self.viewModel startTask:task];
        }
        if (task.orderstatus == 4) {
            [self.viewModel endTask:task];
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (TaskDateBarView*)barView
{
    if (!_barView) {
        _barView = [TaskDateBarView new];
    }
    return _barView;
}


- (UIDatePicker*)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-210.f, SCREEN_WIDTH, 210.f)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.tag = 1009;
        
        NSDate *date = [NSDate date];
        _datePicker.date = date;
        _datePicker.minimumDate = [date dateByAddingMonths:-3];
        
        double birthDate = [date timeIntervalSince1970];
        NSLog(@"%.2f",birthDate);
        
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
//        [_datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

- (UIToolbar*)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.f, SCREEN_HEIGHT-210.f-40.f, SCREEN_WIDTH, 40.f)];
        _toolBar.barStyle = UIBarStyleDefault;
        _toolBar.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [_toolBar sizeToFit];
        
        UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(chooseDate:)];
        UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        NSArray *array = [NSArray arrayWithObjects:flexibleSpaceLeft, doneBtn, nil];
        [_toolBar setItems:array];
    }
    return _toolBar;
}
    


- (UIView*)maskView
{
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _maskView.userInteractionEnabled = YES;
    }
    return _maskView;
}
@end
