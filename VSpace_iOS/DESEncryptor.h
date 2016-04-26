//
//  DESEncryptor.h
//  VSpace_iOS
//
//  Created by 李昂 on 15/8/9.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#define __BASE64( text )        [DESEncryptor base64StringFromText:text]
#define __TEXT( base64 )        [DESEncryptor textFromBase64String:base64]

@interface DESEncryptor : NSObject
+ (NSString *)base64StringFromText:(NSString *)text;
+ (NSString *)textFromBase64String:(NSString *)base64;
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
+ (NSString *)base64EncodedStringFrom:(NSData *)data;
@end
