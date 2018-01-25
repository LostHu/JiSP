//
//  BaseViewController.m
//  Football
//
//  Created by Vison_Cui on 15/9/10.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UINavigationControllerDelegate>

@end

@implementation BaseViewController

- (CustomNavigationBar *)cusnavigationBar {
    if (!_cusnavigationBar) {
        _cusnavigationBar = [[CustomNavigationBar alloc] init];
    }
    return _cusnavigationBar;
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = Color_Controller_Bg;
    
    [self.view addSubview:self.cusnavigationBar];
    [self.cusnavigationBar.leftButton setImage:[UIImage imageNamed:@"tab_back"] forState:UIControlStateNormal];
    [self.cusnavigationBar.leftButton addTarget:self action:@selector(popController) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // NO设置从navbar左下角0开始
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void)popController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [_cusnavigationBar removeFromSuperview];
    _cusnavigationBar = nil;
    
    DDLog(@"dealloc-basevc %@",self.className);
}

@end

@implementation BaseTableViewController

-(void)loadView
{
    [super loadView];
    
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview: self.tableView];
    
    self.tableView.top = NavigationBarHeight;
    self.tableView.left = self.view.left;
    self.tableView.width = SCREEN_WIDTH;
    self.tableView.height = SCREEN_HEIGHT-NavigationBarHeight;
}

- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
    }
    return _tableView;
}

@end

