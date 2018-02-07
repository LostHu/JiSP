//
//  NSString+Extend.h
//  Football
//
//  Created by lost on 15/7/13.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)

/**
 *  32位MD5加密
 */
@property (nonatomic,copy,readonly) NSString *md5;


/**
 *  SHA1加密
 */
@property (nonatomic,copy,readonly) NSString *sha1;

- (CGSize)calcSizeforFont:(UIFont*)font size:(CGSize)size;

+ (NSString *)encodeBase64String:(NSString *)input;
+ (NSString *)decodeBase64String:(NSString *)input;
+ (NSString *)encodeBase64Data:(NSData *)data;
+ (NSString *)decodeBase64Data:(NSData *)data;

- (NSString *)URLEncodedStringTranslate;
- (NSString *)URLEncodedString;
- (NSString *)filterHTML;

+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet;
+ (NSString *)trimWhitespace:(NSString *)val;
+ (NSString *)trimNewline:(NSString *)val;
+ (NSString *)trimWhitespaceAndNewline:(NSString *)val;

+ (BOOL)isBlankString:(NSString *)string;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)isVerifyPassport:(NSString *)value;
+ (BOOL)isVerifyIDCardNumber:(NSString *)value;
+ (BOOL)isSpecial:(NSString *)content;
+ (BOOL)isIncludeSpecialCharact: (NSString *)str;
+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (NSString *)image2DataURL: (UIImage *) image;

+ (NSString *)dataTOjsonString:(id)object;

+(NSString *)return16LetterAndNumber;

@end
