//
//  UIImage+Extend.h
//  Football
//
//  Created by Lost on 16/6/7.
//  Copyright © 2016年 Lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)
- (UIImage*)grayscaleforType:(int)type;
- (UIImage*) convertImageToGrey;
+ (UIImage *)fixOrientation:(UIImage *)aImage;

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

// 获取Video第一帧图片
//+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;
@end
