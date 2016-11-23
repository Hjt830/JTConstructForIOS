//
//  JTDBManager.h
//  JTConstructForIOS
//
//  Created by Hjt on 16/11/21.
//  Copyright © 2016年 ShenZhenHermallUnion.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JTDBManager : NSObject

/**
 *  单例实例化方法
 */
+ (nonnull instancetype)defaultManager;


/**   method:创建数据库
 * complection: 回调建表结果
 * status: 建表结果 YES/NO
 * error: 建表失败原因
 */
- (void)setupDatabasecomplection:(void(^ _Nullable)(BOOL result, NSError * _Nullable error))complection;


/**   method:创建表
 * path:路径
 * name:表名
 * information:@{字段:类型}
 * result: 建表结果 YES/NO
 * error: 建表失败原因
 */
- (void)setupTableName:(nonnull NSString *)name
           information:(nonnull NSString *)information
           complection:(void(^ _Nullable)(BOOL result, NSError * _Nullable error))complection;


/**   method:查询方法
 * name:表名
 * keyword:关键字
 * complection:查询结果回调
 * error:查询失败或者错误
 */
- (void)selectTableWithName:(nonnull NSString *)name
                    keyword:(nullable NSString *)keyword
                  condition:(nullable NSString *)condition
                complection:(void(^ _Nullable)(FMResultSet  * _Nullable result ,NSError * _Nullable error))complection;


/**   method:删除方法
 * name:表名
 * keyword: 关键字
 * result: 操作结果 YES/NO
 */
- (void)deleteDataWithName:(nonnull NSString *)name
                   keyword:(nullable NSString *)keyword
                 condition:(nullable NSString *)condition
               complection:(void(^ _Nullable)(BOOL result))complection;

/***
 *  method:插入方法
 *  name:表名
 *  condition: 插入的语句
 *  result: 操作结果 YES/NO
 **/
- (void)insertDataWithName:(nonnull NSString *)name
                 condition:(nonnull NSString *)condition
               complection:(void(^ _Nullable)(BOOL result))complection;

/***
 *  method:更新方法
 *  name:表名
 *  condition: 修改的语句
 *  result: 操作结果 YES/NO
 **/
- (void)updateDataWithName:(nonnull NSString *)name
                 condition:(nonnull NSString *)condition
               complection:(void(^ _Nullable)(BOOL result))complection;

@end
