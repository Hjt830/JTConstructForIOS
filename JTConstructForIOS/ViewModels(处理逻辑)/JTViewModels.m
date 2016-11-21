//
//  JTViewModels.m
//  JTConstructForIOS
//
//  Created by Hjt on 16/11/21.
//  Copyright © 2016年 ShenZhenHermallUnion.Ltd. All rights reserved.
//

#import "JTViewModels.h"

@implementation JTViewModels

- (void)requestDataSourceWithSuccess:(_Nullable NetworkSuccess)successComplection
                                fail:(_Nullable NetworkFail)failCompletion
                           noNetwork:(_Nullable NoNetwork)noNetworkComplection {}

- (void)getDatabaseWithName:(nonnull NSString *)name
                    keyword:(nullable NSString *)keyword
                complection:(void(^ _Nullable)(id _Nullable responesObject, NSError * _Nullable error))complection {}

@end
