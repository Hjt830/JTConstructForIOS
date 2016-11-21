//
//  NSString+Md5.m
//  MeiShi
//
//  Created by HUANGJINTAI on 16/7/11.
//  Copyright © 2016年 More. All rights reserved.
//

#import "NSString+Md5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Md5)

- (NSString*)md5_32BitUpper {
    
    const char *cStr = [self UTF8String];
    
    unsigned char result[32];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    
    CC_MD5( cStr,[num intValue], result );
    
    NSString *upperStr = [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3],result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15], result[16], result[17],result[18], result[19], result[20], result[21], result[22], result[23], result[24], result[25], result[26], result[27], result[28], result[29],result[30], result[31]] uppercaseString];
    
    return upperStr;
}

- (NSString *)md5_16BitUpper {
    
    const char *cStr = [self UTF8String];
    
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    
    CC_MD5( cStr, [num intValue], result );
    
    NSString *lowerStr = [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3],result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]] uppercaseString];
    
    return lowerStr;
}



@end
