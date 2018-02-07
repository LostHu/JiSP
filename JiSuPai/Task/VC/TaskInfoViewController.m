//
//  TaskInfoViewController.m
//  JiSuPai
//
//  Created by Lost on 2018/1/14.
//  Copyright © 2018年 Lost. All rights reserved.
//

#import "TaskInfoViewController.h"
#import "ZLPhotoActionSheet.h"
#import "ZLPhotoConfiguration.h"
#import <Photos/Photos.h>

@interface TaskInfoViewController ()
@property (nonatomic, strong) ZLPhotoActionSheet* actionSheet;

@end

@implementation TaskInfoViewController
{
}
- (TaskInfoViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TaskInfoViewModel alloc] init];
    }
    return _viewModel;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = hexColor(f5f8fa);
    self.tableView.backgroundColor = self.view.backgroundColor;
//    self.cusnavigationBar.titleLabel.text = @"任务详情";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _arrayTitle = @[@"上传照片",@"基本信息",@"任务信息",@"货物信息及搬运信息",@"补充说明"];
    
    [self.tableView registerClass:[TaskInfoAddPhotoTableViewCell class] forCellReuseIdentifier:[TaskInfoAddPhotoTableViewCell identify]];
    [self.tableView registerClass:[TaskInfoBasicTableViewCell class] forCellReuseIdentifier:[TaskInfoBasicTableViewCell identify]];
    [self.tableView registerClass:[TaskInfoTableViewCell class] forCellReuseIdentifier:[TaskInfoTableViewCell identify]];
    [self.tableView registerClass:[TaskInfoCargoTableViewCell class] forCellReuseIdentifier:[TaskInfoCargoTableViewCell identify]];
    [self.tableView registerClass:[TaskInfoAdditionalTableViewCell class] forCellReuseIdentifier:[TaskInfoAdditionalTableViewCell identify]];
    
    @weakify(self);
    self.actionSheet.sender = self;
    [self.actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        @strongify(self);
        if (images && images.count > 0) {
            //            // 添加新图片
            for (int i=0; i<images.count; i++) {
                UIImage* img = [images objectAtIndex:i];
                //                PHAsset* newAsset = [assets objectAtIndex:i];
                
//                if (self.selectBtn) {
                NSString* fileName = FormatStr(@"%@.jpg", [NSString return16LetterAndNumber]);
                    [self.viewModel postOrderPhoto:img name:fileName block:^(id data, BOOL isTodo) {
                        @strongify(self);
                        if (isTodo) {
                            [self.viewModel.arrayPhotos addObject:fileName];
                            [self.viewModel getOrderPhoto:nil];
                        }
                    }];
//                }
            }
        }
    }];
    
    [RACObserve(self.viewModel, arrayPhotos) subscribeNext:^(id x) {
        @strongify(self);
        if (x && [x isKindOfClass:[NSArray class]]) {
            [self.tableView reloadData];
        }
    }];
    
    [self.viewModel getOrderPhoto:nil];
}

- (void)change
{
    //    self.actionSheet.arrSelectedAssets = self.arrayPhotoView.count > 0 ? [self getPhotoAssets] : nil;
    self.actionSheet.configuration.maxSelectCount = 1;
    [self.actionSheet showPhotoLibrary];
}

- (void)checkSourcePage
{
    if ([self.preClassName isEqualToString:@""]) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
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
    if (indexPath.row == 0) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoAddPhotoTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
            ((TaskInfoAddPhotoTableViewCell*)cell).array = self.viewModel.arrayPhotos;
        }];
    }
    if (indexPath.row == 1) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoBasicTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
        }];
    }
    if (indexPath.row == 2) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
        }];
    }
    if (indexPath.row == 3) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoCargoTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
        }];
    }
    if (indexPath.row == 4) {
        return [tableView fd_heightForCellWithIdentifier:[TaskInfoAdditionalTableViewCell identify] cacheByIndexPath:indexPath configuration:^(id cell) {
            ((TaskInfoAdditionalTableViewCell*)cell).contentLabel.text = self.viewModel.data.descrip;;
        }];
    }
    return 176;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TaskInfoAddPhotoTableViewCell *cell = (TaskInfoAddPhotoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoAddPhotoTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        ((TaskInfoAddPhotoTableViewCell*)cell).array = self.viewModel.arrayPhotos;
        
        [[[cell.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            [self change];
        }];
        
        return cell;
    }
    if (indexPath.row == 1) {
        TaskInfoBasicTableViewCell *cell = (TaskInfoBasicTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoBasicTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        cell.data = self.viewModel.data;
        
        return cell;
    }
    if (indexPath.row == 2) {
        TaskInfoTableViewCell *cell = (TaskInfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        cell.data = self.viewModel.data;
        
        return cell;
    }
    if (indexPath.row == 3) {
        TaskInfoCargoTableViewCell *cell = (TaskInfoCargoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoCargoTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        cell.data = self.viewModel.data;
        
        return cell;
    }
    if (indexPath.row == 4) {
        TaskInfoAdditionalTableViewCell *cell = (TaskInfoAdditionalTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[TaskInfoAdditionalTableViewCell identify] forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.indexLabel.text = FormatStr(@"%ld",indexPath.row+1);
        cell.titleLabel.text = [_arrayTitle objectAtIndex:indexPath.row];
        ((TaskInfoAdditionalTableViewCell*)cell).contentLabel.text = self.viewModel.data.descrip;
        
        return cell;
    }
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //    TopicDetailViewController* vc = [TopicDetailViewController new];
    //    [self.navigationController pushViewController:vc animated:YES];
}

- (ZLPhotoActionSheet*)actionSheet
{
    if (!_actionSheet) {
        _actionSheet = [ZLPhotoActionSheet new];
        _actionSheet.configuration.allowTakePhotoInLibrary = NO;    // 不允许相册内拍照
        _actionSheet.configuration.allowSelectOriginal = NO;    // 不允许原图
    }
    return _actionSheet;
}

@end
