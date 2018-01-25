//
//  YZTabViewController.h
//  GTarcade
//
//  Created by Lost on 2017/12/25.
//  Copyright © 2017年 VisonCui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZTabData;
@interface YZTabViewController : UITabBarController

@end

@interface YZTabItemData : NSObject
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* info;
@property (nonatomic, strong) NSString* imgNormal;
@property (nonatomic, strong) NSString* imgSelect;
@end

@interface YZTabData : NSObject
@property (nonatomic, strong) NSMutableArray<YZTabItemData*>* arrayTabData;
@end


