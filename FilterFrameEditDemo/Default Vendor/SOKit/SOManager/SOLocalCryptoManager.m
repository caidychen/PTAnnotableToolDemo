//
//  SOLocalCryptoManager.m
//  SOKit
//
//  Created by soso on 15/6/19.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import "SOLocalCryptoManager.h"
#import "SOAESCrypt.h"
#import "SOGlobal.h"

static NSString * const SOLocalCryptoDomain         = @"SOLocalCryptoDomain";
static NSString * const _KeySOLocalCrypto           = @"Key0SO1Lo2ca3lC4ry5pt6o";

@interface SOLocalCryptoManager ()
@end


@implementation SOLocalCryptoManager
static SOLocalCryptoManager *manager = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SOLocalCryptoManager alloc] init];
    });
    return (manager);
}

- (NSData *)passdata {
    return ((NSData *)[[NSUserDefaults standardUserDefaults] objectForKey:_KeySOLocalCrypto]);
}

- (void)setPassdata:(NSData *)passdata {
    NSUserDefaults *usdef = [NSUserDefaults standardUserDefaults];
    if(!passdata) {
        [usdef removeObjectForKey:_KeySOLocalCrypto];
        [usdef synchronize];
        return;
    }
    [usdef setObject:passdata forKey:_KeySOLocalCrypto];
    [usdef synchronize];
}

- (void)updatePassword:(NSString *)password newPassword:(NSString *)nPassword block:(SOLocalCryptoBlock)block {
    [self updatePassdata:[password dataUsingEncoding:NSUTF8StringEncoding]
             newPassdata:[nPassword dataUsingEncoding:NSUTF8StringEncoding]
                   block:block];
}

- (void)updatePassdata:(NSData *)passdata newPassdata:(NSData *)nPassdata block:(SOLocalCryptoBlock)block {
    NSData *adata = [self passdata];
    if(!adata || (adata && passdata && [adata isEqualToData:passdata])) {
        [self setPassdata:nPassdata];
        block(SOLocalCryptoStatuSuccess, nil);
    } else {
        NSError *error = [NSError errorWithDomain:SOLocalCryptoDomain code:SOLocalCryptoStatuFail userInfo:@{@"description":@"passdata is error"}];
        block(SOLocalCryptoStatuFail, error);
    }
}

- (NSString *)enCryptString:(NSString *)string error:(NSError **)error {
    NSData *data = [self enCryptData:[string dataUsingEncoding:NSUTF8StringEncoding] error:error];
    NSString *enString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    SOAUTORELEASE(enString);
    return (enString);
}

- (NSString *)enCryptString:(NSString *)string password:(NSString *)password error:(NSError **)error {
    NSData *data = [self enCryptData:[string dataUsingEncoding:NSUTF8StringEncoding] passdata:[password dataUsingEncoding:NSUTF8StringEncoding] error:error];
    NSString *enString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    SOAUTORELEASE(enString);
    return (enString);
}

- (NSString *)deCryptString:(NSString *)string error:(NSError **)error {
    NSData *data = [self deCryptData:[string dataUsingEncoding:NSUTF8StringEncoding] error:error];
    NSString *deString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    SOAUTORELEASE(deString);
    return (deString);
}

- (NSString *)deCryptString:(NSString *)string password:(NSString *)password error:(NSError **)error {
    NSData *data = [self deCryptData:[string dataUsingEncoding:NSUTF8StringEncoding] passdata:[password dataUsingEncoding:NSUTF8StringEncoding] error:error];
    NSString *deString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    SOAUTORELEASE(deString);
    return (deString);
}

- (NSData *)enCryptData:(NSData *)data error:(NSError **)error {
    return (SOAESEncryptData(data, [self passdata], error));
}

- (NSData *)enCryptData:(NSData *)data passdata:(NSData *)passdata error:(NSError **)error {
    return (SOAESEncryptData(data, passdata, error));
}

- (NSData *)deCryptData:(NSData *)data error:(NSError **)error {
    return (SOAESDecryptData(data, [self passdata], error));
}

- (NSData *)deCryptData:(NSData *)data passdata:(NSData *)passdata error:(NSError **)error {
    return (SOAESDecryptData(data, passdata, error));
}

- (void)enCryptFileFromPath:(NSString *)fPath toPath:(NSString *)tPath block:(SOLocalCryptoBlock)block {
    
}

- (void)enCryptFileFromPath:(NSString *)fPath toPath:(NSString *)tPath passdata:(NSData *)passdata block:(SOLocalCryptoBlock)block {
    
}

- (void)deCryptFileFromPath:(NSString *)fPath toPath:(NSString *)tPath block:(SOLocalCryptoBlock)block {
    
}

- (void)deCryptFileFromPath:(NSString *)fPath toPath:(NSString *)tPath passdata:(NSData *)passdata block:(SOLocalCryptoBlock)block {
    
}

@end
