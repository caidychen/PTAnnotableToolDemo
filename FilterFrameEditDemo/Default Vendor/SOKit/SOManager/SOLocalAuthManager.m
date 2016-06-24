//
//  SOLocalAuthManager.m
//  NOETouchIDTest
//
//  Created by soso on 15-1-15.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import "SOLocalAuthManager.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "SOGlobal.h"

static NSString *authUsersKey = @"BoundleID+Authentication+Users+Key";

@interface SOLocalAuthManager () {
    @private
    LAContext *_laCtx;
    NSMutableDictionary *_users;
}
@end


@implementation SOLocalAuthManager

+ (instancetype)shared {
    return ([self manager]);
}

+ (instancetype)manager {
    static SOLocalAuthManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[SOLocalAuthManager alloc] init];
    });
    return (mgr);
}

#if !__has_feature(objc_arc)
- (oneway void)release {
    NSLog(@"release do nothing");
}
#endif

- (instancetype)init {
    self = [super init];
    if(self) {
        _laCtx = nil;
        _users = nil;
    }
    return (self);
}

- (LAContext *)laCtx {
    if(!_laCtx) {
        _laCtx = [[LAContext alloc] init];
        _laCtx.localizedFallbackTitle = @"输入密码";
    }
    return (_laCtx);
}

- (NSMutableDictionary *)users {
    NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:authUsersKey];
    if(!dict) {
        dict = [NSMutableDictionary dictionary];
    }
    return (dict);
}

- (void)setUses:(NSMutableDictionary *)users {
    [[NSUserDefaults standardUserDefaults] setObject:users forKey:authUsersKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)allUserNames {
    return ([[self users] allKeys]);
}

- (NSString *)passwordWithUserName:(NSString *)username {
    return ([[self users] objectForKey:username]);
}

- (void)addUserName:(NSString *)username password:(NSString *)password {
    NSMutableDictionary *dict = [self users];
    [dict setObject:password forKey:username];
    [self setUses:dict];
}

- (void)removeUserWithUserName:(NSString *)username {
    NSMutableDictionary *dict = [self users];
    [dict removeObjectForKey:username];
    [self setUses:dict];
}

- (void)removeUsersWithUserNames:(NSArray *)usernames {
    NSMutableDictionary *dict = [self users];
    [dict removeObjectsForKeys:usernames];
    [self setUses:dict];
}

- (BOOL)canEvaluateError:(NSError **)error {
    return ([[self laCtx] canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:error]);
}

- (void)evaluateWithReason:(NSString *)reason callback:(NOELocalAuthCallBackBlock)block {
    
    [[self laCtx] evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请验证指纹" reply:^(BOOL success, NSError *error){
        if(!success) {
            if(error) {
                switch ([error code]) {
                    case LAErrorAuthenticationFailed: {
                        NSLog(@"--- LAErrorAuthenticationFailed ---");
                    }break;
                        
                    case LAErrorUserCancel: {
                        NSLog(@"--- LAErrorUserCancel ---");
                    }break;
                        
                    case LAErrorUserFallback: {
                        NSLog(@"--- LAErrorUserFallback ---");
                    }break;
                        
                    case LAErrorSystemCancel: {
                        NSLog(@"--- LAErrorSystemCancel ---");
                    }break;
                        
                    case LAErrorPasscodeNotSet: {
                        NSLog(@"--- LAErrorPasscodeNotSet ---");
                    }break;
                        
                    case LAErrorTouchIDNotAvailable: {
                        NSLog(@"--- LAErrorTouchIDNotAvailable ---");
                    }break;
                        
                    case LAErrorTouchIDNotEnrolled: {
                        NSLog(@"--- LAErrorTouchIDNotEnrolled ---");
                    }break;
                        
                    default: {
                        NSLog(@"--- other error ---");
                    }break;
                }
            }
            return ;
        }
        
        NSLog(@"--- success ---");
        
        NSArray *users = [self allUserNames];
        if(!users || [users count] == 0) {
            NSLog(@"--- 无可用账户 ---");
            return;
        }
        
        if([users count] == 1) {
            NSLog(@"--- 只有一个账户资料，直接自动键入账户及密码来认证 ---");
            return;
        }
        
        NSLog(@"--- 如果有多个账户资料，弹出视图来给用户选择登录的用户 ---");
    }];
    
}

@end
