//
//  JTViewModels.h
//  JTConstructForIOS
//
//  Created by Hjt on 16/11/21.
//  Copyright © 2016年 ShenZhenHermallUnion.Ltd. All rights reserved.
//

/**
 *  这是一个父类ViewModel,用于给子类继承。
 *  只声明一些业务逻辑必要的API，通过子类去重写(多态),从而将业务层封装，降低Controller的工作量、复杂度和耦合性。
 */

#import <Foundation/Foundation.h>
#import "JTNetTool.h"

typedef void(^NetworkSuccess)(id _Nullable responseObject);
typedef void(^NetworkFail)(NSError * _Nullable error);
typedef void(^NoNetwork)(BOOL status);

@interface JTViewModels : NSObject

/** method:网络请求方法
 *  successComplection:成功的回调  (在这里对数据转模型处理再返回，控制器就只管刷新界面的事情)
 *  failCompletion:失败的回调
 *  noNetworkComplection:没有网络的回调
 */
- (void)requestDataSourceWithSuccess:(_Nullable NetworkSuccess)successComplection
                                fail:(_Nullable NetworkFail)failCompletion
                           noNetwork:(_Nullable NoNetwork)noNetworkComplection;

/** method:查询本地数据库数据
 *  name:表名
 *  keyword:关键字
 *  complection:查询回调
 *  responesObject:查询成功的数据(在这里将数据序列化处理) error:查询失败或者错误
 */
- (void)getDatabaseWithName:(NSString * _Nonnull)name
                    keyword:(NSString * _Nullable)keyword
                  condition:(NSString * _Nullable)condition
                complection:(void (^ _Nullable)(id _Nullable, NSError * _Nullable))complection;


@end
