//
//  AESCipher.h
//  AESCipher
//
//  Created by Welkin Xie on 8/13/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  https://github.com/WelkinXie/AESCipher-iOS
//

#import <Foundation/Foundation.h>

@interface AESCipher : NSObject

+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key iv:(NSString *)iv;
+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key iv:(NSString *)iv;

+ (NSString *)decryptAESData:(NSData *)contentData key:(NSString *)key iv:(NSString *)iv;
+ (NSString *)encryptAESData:(NSData *)contentData key:(NSString *)key iv:(NSString *)iv;

@end
