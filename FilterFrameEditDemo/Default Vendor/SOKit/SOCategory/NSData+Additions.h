//
//  NSData+Additions.h
//  SOKit
//
//  Created by Carl on 15/5/7.
//  Copyright (c) 2015年 Carl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(Additions)
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64Encoding;
- (NSString *)md5Hash;
- (NSString *)sha1Hash;
@end
