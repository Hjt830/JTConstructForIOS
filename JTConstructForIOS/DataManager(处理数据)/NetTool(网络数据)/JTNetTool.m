//
//  JTNetTool.m
//  JTConstructForIOS
//
//  Created by Hjt on 16/11/21.
//  Copyright © 2016年 ShenZhenHermallUnion.Ltd. All rights reserved.
//

#import "JTNetTool.h"

@implementation JTNetTool

+ (void)netWorkReachabilityWithURLString:(NSString *)strUrl complectionBlock:(void(^)(BOOL stasus))complection {
    
    __block BOOL netState = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
        
        complection (netState);
    }];
    
    [manager.reachabilityManager startMonitoring];
}

+ (void)requestDataFromNetworkWithMethod:(JTNetType)method
                                     url:(nonnull NSString *)URL
                              parameters:(nullable NSDictionary *)parameters
                      successComplection:(void(^ _Nullable)(NSDictionary * _Nullable responesObject))success
                         failComplection:(void(^ _Nullable)(NSError * _Nullable error))fail
                               noNetwork:(void(^ _Nullable)(NSError * _Nullable noNetwork))noNetwork {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionTask *task = nil;
    
    // GET请求
    if (method == JTNetTypeGET) {
        task = [manager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 获取并保存Cookie
            [self getAndSaveCookie];
            
            if ([responseObject isKindOfClass:[NSData class]]) {
                
                NSError *jsonError = nil;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonError];
                if (!jsonError) {
                    success (dic);
                } else {
                    fail (jsonError);
                }
            } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
                success (responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail (error);
        }];
    }
    // POST请求
    else if (method == JTNetTypePost) {
        task = [manager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self getAndSaveCookie];
            
            if ([responseObject isKindOfClass:[NSData class]]) {
                
                NSError *jsonError = nil;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonError];
                if (!jsonError) {
                    success (dic);
                } else {
                    fail (jsonError);
                }
            } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
                success (responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail (error);
        }];
    }
    // PUT请求
    else if (method == JTNetTypePut) {
        [manager PUT:URL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self getAndSaveCookie];
            
            if ([responseObject isKindOfClass:[NSData class]]) {
                
                NSError *jsonError = nil;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonError];
                if (!jsonError) {
                    success (dic);
                } else {
                    fail (jsonError);
                }
            } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
                success (responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail (error);
        }];
    }
    
    [task resume];
}

#pragma mark 获取cookie并存储归档后的cookie
+ (void)getAndSaveCookie {
    //获取cookie
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    if (cookies.count > 0) {
        NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
        
        //存储归档后的cookie
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject: cookiesData forKey: @"cookie"];
        
        [self deleteCookie];
        
        [self setCoookie];
    }
}

#pragma mark 删除cookie
+ (void)deleteCookie
{
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    //删除cookie
    for (NSHTTPCookie *tempCookie in cookies) {
        [cookieStorage deleteCookie:tempCookie];
    }
    
    //把cookie打印出来，检测是否已经删除
    NSArray *cookiesAfterDelete = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *tempCookie in cookiesAfterDelete) {
        NSLog(@"cookieAfterDelete: %@", tempCookie);
    }
    NSLog(@"\n");
}

#pragma mark 再取出保存的cookie重新设置cookie
+ (void)setCoookie
{
    //取出保存的cookie
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //对取出的cookie进行反归档处理
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"cookie"]];
    
    if (cookies) {
        //设置cookie
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (id cookie in cookies) {
            [cookieStorage setCookie:(NSHTTPCookie *)cookie];
        }
    }else{
        JTLOG(@"无cookie");
    }
    
    //打印cookie，检测是否成功设置了cookie
    NSArray *cookiesA = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookiesA) {
        JTLOG(@"setCookie: %@ \n", cookie);
    }
}

@end
