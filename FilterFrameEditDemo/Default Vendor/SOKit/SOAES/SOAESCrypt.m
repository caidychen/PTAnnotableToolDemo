//
//  SOAESCrypt.m
//  SOKit
//
//  Created by soso on 15/6/18.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import "SOAESCrypt.h"
#import "NSData+Additions.h"
#import "NSData+CommonCrypto.h"

NSString * SOAESEncrypt(NSString *message, NSString *password, NSError **error) {
    NSData *encryptedData = [[message dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:error];
    NSString *base64EncodedString = [encryptedData base64Encoding];
    return (base64EncodedString);
}

NSString * SOAESDecrypt(NSString *base64EncodedString, NSString *password, NSError **error) {
    NSData *encryptedData = [NSData dataWithBase64EncodedString:base64EncodedString];
    NSData *decryptedData = [encryptedData decryptedAES256DataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:error];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

NSData * SOAESEncryptData(NSData *data, NSData *passdata, NSError **error) {
    return ([data AES256EncryptedDataUsingKey:passdata error:error]);
}

NSData * SOAESDecryptData(NSData *data, NSData *passdata, NSError **error) {
    return ([data decryptedAES256DataUsingKey:passdata error:error]);
}
