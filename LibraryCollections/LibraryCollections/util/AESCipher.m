//
//  AESCipher.m
//  AESCipher
//
//  Created by Welkin Xie on 8/13/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  https://github.com/WelkinXie/AESCipher-iOS
//

#import "AESCipher.h"
#import <CommonCrypto/CommonCryptor.h>

//NSString *const kInitVector = @"tcmobileapptolin";

size_t const kKeySize = kCCKeySizeAES128;

@implementation AESCipher

+ (NSString *)encryptAESData:(NSData *)contentData key:(NSString *)key iv:(NSString *)iv {
    NSUInteger dataLength = contentData.length;
    
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    
    NSData *initVector = [iv dataUsingEncoding:NSUTF8StringEncoding];
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);
    
    if (cryptStatus == kCCSuccess) {
        return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    free(encryptedBytes);
    return nil;
}

+ (NSString *)decryptAESData:(NSData *)contentData key:(NSString *)key iv:(NSString *)iv {
    NSUInteger dataLength = contentData.length;
    
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    size_t decryptSize = dataLength + kCCBlockSizeAES128;
    void *decryptedBytes = malloc(decryptSize);
    size_t actualOutSize = 0;
    
    NSData *initVector = [iv dataUsingEncoding:NSUTF8StringEncoding];
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          decryptedBytes,
                                          decryptSize,
                                          &actualOutSize);
    
    if (cryptStatus == kCCSuccess) {
        return [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize] encoding:NSUTF8StringEncoding];
    }
    free(decryptedBytes);
    return nil;
}

+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key iv:(NSString *)iv {
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    return [self encryptAESData:contentData key:key iv:iv];
}

+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key iv:(NSString *)iv {
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [self decryptAESData:contentData key:key iv:iv];
}

@end
