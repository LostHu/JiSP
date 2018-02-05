//
//  YZTabViewController.m
//  GTarcade
//
//  Created by Lost on 2017/12/25.
//  Copyright © 2017年 VisonCui. All rights reserved.
//

#import "YZTabViewController.h"
#import "MeViewController.h"
#import "TaskViewController.h"
#import "HistoryViewController.h"
#import "FirstViewController.h"
#import "WorkingViewController.h"


@implementation YZTabItemData
@end

@implementation YZTabData

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSArray* arrayTitle = @[@"任务大厅",@"抢单列表",@"正在配送",@"个人中心"];
        NSArray *iocnNormalArray = @[@"任务大厅1",@"抢单列表1",@"完成列表1",@"个人中心1"];
        NSArray *iconSeclectArray = @[@"任务大厅2",@"抢单列表2",@"完成列表2",@"个人中心2"];
        
        _arrayTabData = [NSMutableArray new];
        for (int i = 0; i < arrayTitle.count; i++) {
            YZTabItemData* item = [YZTabItemData new];
            item.title = arrayTitle[i];
            item.imgNormal = iocnNormalArray[i];
            item.imgSelect = iconSeclectArray[i];
            [_arrayTabData addObject:item];
        }
    }
    return self;
}

@end

@interface YZTabViewController ()<UITabBarControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) YZTabData* tabData;
@end

#define kNavControllerTag 9987

@implementation YZTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabData = [YZTabData new];
    [self initTabItems];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)initTabItems
{
    NSMutableArray *controllerArray = [[NSMutableArray alloc] init];
    
    TaskViewController *firstVC = [[TaskViewController alloc] init];
    [controllerArray addObject:firstVC];
    
    FirstViewController *secondController = [[FirstViewController alloc] init];
    [controllerArray addObject:secondController];
    
    WorkingViewController *thirdController = [[WorkingViewController alloc] init];
    [controllerArray addObject:thirdController];
    
    MeViewController *fourController = [[MeViewController alloc] init];
    [controllerArray addObject:fourController];
    
    [self setupViewControllers:controllerArray];
}

- (void)setupViewControllers:(NSMutableArray * _Nonnull)controllerArray {
    
    UIEdgeInsets insets = UIEdgeInsetsMake(1, 0, -1, 0);
    NSMutableArray *navigationCsArray = [[NSMutableArray alloc] initWithCapacity:controllerArray.count];
    
    for (NSInteger itemIndex = 0; itemIndex < controllerArray.count; itemIndex ++) {
        YZTabItemData* itemData = [self.tabData.arrayTabData objectAtIndex:itemIndex];
        
        BaseViewController* vc = controllerArray[itemIndex];
        vc.cusnavigationBar.titleLabel.text = itemData.title;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        navigationController.navigationBarHidden = YES;
        navigationController.delegate = self;
        navigationController.view.tag = kNavControllerTag + itemIndex;
        
        UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:itemData.title
                                                              image:[ImageNamed(itemData.imgNormal)
                                                                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                      selectedImage:[ImageNamed(itemData.imgSelect)
                                                                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [barItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
        navigationController.tabBarItem = barItem;
        
        [navigationController.tabBarItem setImageInsets:insets];
        [navigationCsArray addObject:navigationController];
    }
    
    //设置tabbar的颜色
    [self.tabBar setBarTintColor:rgba(255, 255, 255, 0.7)];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName: rgbfromHex(@"9e9e9e"),
                                                        NSFontAttributeName: Font_System_Bold(10)
                                                        }
                                             forState: UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName: rgbfromHex(@"5758f3"),
                                                        NSFontAttributeName: Font_System_Bold(10)
                                                        }
                                             forState: UIControlStateSelected];
    
    self.delegate = self;
    self.selectedIndex = 0;
    self.viewControllers = navigationCsArray;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![[UserManager sharedInstance] hasAccount]) {
        [YZRoutes showLoginPage];
    }
    else{
        // 有数据，更新信息
        [[UserManager sharedInstance] getUserDatafromNetWork];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}


- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    // 此处代理为了解决侧滑手机卡顿问题，禁止首页侧滑
    if (viewController == navigationController.viewControllers[0])
    {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

@end
