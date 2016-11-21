//
//  JTNetTool.h
//  JTConstructForIOS
//
//  Created by Hjt on 16/11/21.
//  Copyright © 2016年 ShenZhenHermallUnion.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

// 请求方法类型
typedef NS_ENUM(NSInteger, JTNetType) {
    
    JTNetTypeGET = 0,   // get请求
    JTNetTypePost ,     // post请求
    JTNetTypePut  ,     // pull请求
};


@interface JTNetTool : NSObject

/** method: 查看是否能连接到地址url
 *  url: 请求连接地址
 *  complection:回调
 */
+ (void)netWorkReachabilityWithURLString:(nonnull NSString *)url
                        complectionBlock:(void(^ _Nullable)(BOOL stasus))complection;

/**
 *  method:请求方法类型
 *  URL:请求地址
 *  parameters:请求参数
 *  success:请求成功的回调
 *  fail:请求失败的回调
 *  noNetwork:没有网络的回调
 */
+ (void)requestDataFromNetworkWithMethod:(JTNetType)method
                                     url:(nonnull NSString *)URL
                              parameters:(nullable NSDictionary *)parameters
                      successComplection:(void(^ _Nullable)(NSDictionary * _Nullable responesObject))success
                         failComplection:(void(^ _Nullable)(NSError * _Nullable error))fail
                               noNetwork:(void(^ _Nullable)(NSError * _Nullable noNetwork))noNetwork;



@end
