//
//  HybridNSURLProtocol.m
//  WKWebVIewHybridDemo
//
//  Created by shuoyu liu on 2017/1/16.
//  Copyright © 2017年 shuoyu liu. All rights reserved.
//

#import "HybridNSURLProtocol.h"
#import <UIKit/UIKit.h>
//#import "YYKit"

static NSString*const sourUrl  = @"https://m.baidu.com/static/index/plus/plus_logo.png";
static NSString*const sourIconUrl  = @"http://m.baidu.com/static/search/baiduapp_icon.png";
static NSString*const localUrl = @"http://mecrm.qa.medlinker.net/public/image?id=57026794&certType=workCertPicUrl&time=1484625241";

static NSString* const KHybridNSURLProtocolHKey = @"KHybridNSURLProtocol";
@interface HybridNSURLProtocol ()<NSURLSessionDelegate>
@property (nonnull,strong) NSURLSessionDataTask *task;

@end


@implementation HybridNSURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    NSLog(@"request.URL.absoluteString = %@-%@",request.URL.absoluteString,[request.URL query]);
    NSString *scheme = [[request URL] scheme];
    if ( ([scheme caseInsensitiveCompare:@"http"]  == NSOrderedSame ||
          [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame ))
    {
        NSString *str = [request.URL relativePath];
        //只处理http请求的图片
        if ([self isImageUrl:str]
            && ![NSURLProtocol propertyForKey:KHybridNSURLProtocolHKey inRequest:request]) {
            
            return YES;
        }
        return NO;
    }
    return NO;
}

+ (BOOL)isImageUrl:(NSString*)url
{
    NSArray* array = @[@"jpg",@"png",@"jpeg",@"gif"];
//    NSUInteger index = [array indexOfObject:[url pathExtension]];
//    if (index > 0) {
//        return YES;
//    }
    for (NSString* key in array) {
        if ([key isEqualToString:[[url pathExtension] lowercaseString]]) {
            return YES;
        }
    }
    
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    
    return mutableReqeust;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b
{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void)startLoading
{
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    //给我们处理过的请求设置一个标识符, 防止无限循环,
    [NSURLProtocol setProperty:@YES forKey:KHybridNSURLProtocolHKey inRequest:mutableReqeust];
    
    NSString* MIMEType = [NSString stringWithFormat:@"image/%@",[mutableReqeust.URL.absoluteString pathExtension]];
    
    //这里最好加上缓存判断，加载本地离线文件， 这个直接简单的例子。
    
    if ([HybridNSURLProtocol isImageUrl:[mutableReqeust.URL relativePath]])
    {
        UIImage* image = [[YYImageCache sharedCache] getImageForKey:mutableReqeust.URL.absoluteString];
//        [[[YYWebImageManager sharedManager] cache] containsImageForKey:mutableReqeust.URL.absoluteString];
        
//
//        UIImage* image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:mutableReqeust.URL.absoluteString];
        if (image) {
            NSData* data = UIImagePNGRepresentation(image);
            if ([[mutableReqeust.URL.absoluteString pathExtension] isEqualToString:@"jpg"]) {
                data = UIImageJPEGRepresentation(image,1);
            }
            
            NSURLResponse* response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:MIMEType expectedContentLength:data.length textEncodingName:nil];
            [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
            [self.client URLProtocol:self didLoadData:data];
            [self.client URLProtocolDidFinishLoading:self];
            return;
        }
//        else{
//            [[YYWebImageManager sharedManager] requestImageWithURL:mutableReqeust.URL options:YYWebImageOptionProgressive
//                                                          progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                
//            }
//                                                         transform:nil
//                                                        completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//                                                            if (!error && image) {
//                                                                NSData* data = UIImagePNGRepresentation(image);
//                                                                NSURLResponse* response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:@"image/png" expectedContentLength:data.length textEncodingName:nil];
//                                                                [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
//                                                                [self.client URLProtocol:self didLoadData:data];
//                                                                [self.client URLProtocolDidFinishLoading:self];
//                                                            }
//            }];
//        }
        
    }
//    else
    {
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
        self.task = [session dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if ([HybridNSURLProtocol isImageUrl:[mutableReqeust.URL relativePath]]) {
//                NSLog(mutableReqeust.URL.absoluteString);
                if (!error && data) {
//                    [[SDImageCache sharedImageCache] storeImage:[UIImage imageWithData:data] forKey:mutableReqeust.URL.absoluteString];
                    [[YYImageCache sharedCache] setImage:[UIImage imageWithData:data] forKey:mutableReqeust.URL.absoluteString];
                    NSURLResponse* response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:MIMEType expectedContentLength:data.length textEncodingName:nil];
                    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
                    [self.client URLProtocol:self didLoadData:data];
                    [self.client URLProtocolDidFinishLoading:self];
                }
            }
        }];
        [self.task resume];
    }
}
- (void)stopLoading
{
    if (self.task != nil)
    {
        [self.task  cancel];
    }
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
//    NSLog(@"%@",dataTask.originalRequest.URL);
    if ([HybridNSURLProtocol isImageUrl:dataTask.originalRequest.URL.absoluteString] && dataTask.state == NSURLSessionTaskStateCompleted)
    {
        NSLog(@"---------%@",dataTask.originalRequest.URL);
    }
    
    [[self client] URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
        
    [self.client URLProtocolDidFinishLoading:self];
}

@end
