//
//  BaseViewController.h
//  Football
//
//  Created by Vison_Cui on 15/9/10.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationBar.h"

@interface BaseViewController : UIViewController

@property (nonatomic, retain) CustomNavigationBar *cusnavigationBar;
- (void)popController;

@end

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong, null_resettable) UITableView* tableView;

@end
