//
//  NSString+TimeStamp.m
//  MeiShi
//
//  Created by HUANGJINTAI on 16/7/11.
//  Copyright © 2016年 More. All rights reserved.
//

#import "NSString+TimeStamp.h"

@implementation NSString (TimeStamp)

// 获取当前时间戳
+ (NSInteger)getCurrentTimeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval timeNum = [date timeIntervalSince1970];
    NSNumber *time = [NSNumber numberWithDouble:timeNum];
    
    return [time longValue];
}


// 系统带的算法 根据UUID生成的
+ (NSString *)getUniqueStrByUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    
    return retStr;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}


@end
