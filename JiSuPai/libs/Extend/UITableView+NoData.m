//
//  UITableView+NoData.m
//  GameBiBi
//
//  Created by Lost on 2017/12/26.
//  Copyright © 2017年 Vison. All rights reserved.
//

#import "UITableView+NoData.h"
#import "NSObject+Swizzling.h"

@implementation UITableView (NoData)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(reloadData)
                               bySwizzledSelector:@selector(preReloadData)];
    });
}

- (void)preReloadData {
    if (!self.firstReload) {
        if ([self checkEmpty]) {
            if(!self.placeholderView)
            {
                [self createPlaceholderView];
                [self addSubview:self.placeholderView];
            }
            self.placeholderView.hidden = NO;
        }
        else
        {
            self.placeholderView.hidden = YES;
        }
    }
    self.firstReload = NO;
    [self preReloadData];
}

- (void)createPlaceholderView
{
    CGRect rc = CGRectMake(20, self.frame.size.height/5, self.frame.size.width-40, 120);
    NoDataView *placeholderView = [[NoDataView alloc] initWithFrame:rc];
//    placeholderView.backgroundColor = [UIColor orangeColor];
    __weak typeof(self) weakSelf = self;
    [placeholderView setReloadClickBlock:^{
        if (weakSelf.reloadBlock) {
            weakSelf.reloadBlock();
        }
    }];
    self.placeholderView = placeholderView;
}

- (BOOL)checkEmpty
{
    if (self.bIgnoreNoData) {
        return NO;
    }
    BOOL isEmpty = YES;
    
    NSInteger sectionCount = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sectionCount = [self.dataSource numberOfSectionsInTableView:self];
    }
    for (int i=0; i<sectionCount; i++) {
        NSInteger rowCount = 0;
        if ([self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            rowCount = [self.dataSource tableView:self numberOfRowsInSection:i];
        }
        if (rowCount > 0) {
            isEmpty = NO;
            break;
        }
    }
    
    return isEmpty;
}

- (NoDataView*)placeholderView
{
    return objc_getAssociatedObject(self, @selector(placeholderView));
}

- (void)setPlaceholderView:(NoDataView *)placeholderView
{
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)bIgnoreNoData
{
    return [objc_getAssociatedObject(self, @selector(bIgnoreNoData)) boolValue];
}

- (void)setBIgnoreNoData:(BOOL)bIgnoreNoData
{
    objc_setAssociatedObject(self, @selector(bIgnoreNoData), @(bIgnoreNoData), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)firstReload
{
    return [objc_getAssociatedObject(self, @selector(firstReload)) boolValue];
}

- (void)setFirstReload:(BOOL)firstReload
{
    objc_setAssociatedObject(self, @selector(firstReload), @(firstReload), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)(void))reloadBlock {
    return objc_getAssociatedObject(self, @selector(reloadBlock));
}

- (void)setReloadBlock:(void (^)(void))reloadBlock {
    objc_setAssociatedObject(self, @selector(reloadBlock), reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
