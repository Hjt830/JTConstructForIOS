//
//  configuration.h
//  JTConstructForIOS
//
//  Created by Hjt on 16/11/21.
//  Copyright © 2016年 ShenZhenHermallUnion.Ltd. All rights reserved.
//

#ifndef configuration_h
#define configuration_h

/***
 * 屏幕的宽高
 **/
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

/***
 * 颜色
 * AppTintColor  主题色
 **/
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define AppTintColor RGBACOLOR(255, 118, 1, 1)

/***
 * 日志
 * DEBUG 调试环境打印到控制台 / 生产环境不打印到控制台
 **/
#ifdef DEBUG
#define JTLOG(...) NSLog(__VA_ARGS__)
#else
#define JTLOG(...) ((void)0)
#endif

/**
 *  第三方的一些AppKey
 */
#define JTUmengKEY  @"123123123123123"
#define JTJpushKEY  @"123123123123123"
#define JTEaseKEY   @"123123123123123"

#endif /* configuration_h */
