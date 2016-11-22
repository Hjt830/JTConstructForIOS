//
//  JTDBManager.m
//  JTConstructForIOS
//
//  Created by Hjt on 16/11/21.
//  Copyright © 2016年 ShenZhenHermallUnion.Ltd. All rights reserved.
//

#import "JTDBManager.h"

@interface JTDBManager ()

@property (nonatomic, strong) FMDatabaseQueue   *DBQueue;

@end

static JTDBManager *manager = nil;

@implementation JTDBManager

+ (nonnull instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    return manager;
}

- (instancetype) copyWithZone:(struct _NSZone *)zone
{
    return [JTDBManager defaultManager];
}

+ (instancetype) allocWithZone:(struct _NSZone *)zone {
    return [JTDBManager defaultManager];
}

#pragma mark - ===================== 建表 增 删 查 改 =====================
/**
 *  数据库路径
 */
- (NSString *)databasePath {
    NSString *url = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [url stringByAppendingPathComponent:@"Caches/history"];
    return path;
}

/**   
 *  method:创建数据库
 */
- (void)setupDatabasecomplection:(void(^ _Nullable)(BOOL result, NSError * _Nullable error))complection {
    // 先查看目录下是否存在同名的表, 若存在就返回
    NSString *path = [self databasePath];
    
    // 若没有路径 就创建该路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",path,@"Caches/history"] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 获取或者创建数据库
    self.DBQueue = [FMDatabaseQueue databaseQueueWithPath:[[self databasePath] stringByAppendingPathComponent:@"main.sqlite"]];
    if (!self.DBQueue) {
        NSError *error = [NSError errorWithDomain:@"创建数据库失败" code:0 userInfo:nil];
        complection (NO, error);
    }
    else {
        complection (YES, nil);
        JTLOG(@"创建数据库成功");
    }
}

/**   
 *  method:建表
 */
- (void)setupTableName:(nonnull NSString *)name
           information:(nonnull NSString *)information
           complection:(void(^ _Nullable)(BOOL result, NSError * _Nullable error))complection {
    
    [self.DBQueue inDatabase:^(FMDatabase *db) {
        
        if ([db tableExists:name]) {
            NSError *error = [NSError errorWithDomain:@"表已经存在" code:0 userInfo:nil];
            complection (NO, error);
        }
        else {  
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' %@;", name, information];

            BOOL res = [db executeStatements:sql];
            if (res) {
                complection (YES, nil);
                JTLOG(@"建表成功");
            }
            else {
                NSError *error = [NSError errorWithDomain:@"建表失败" code:0 userInfo:nil];
                complection (NO, error);
            }
        }
    }];
}

/***
 *  method:查询
 **/
- (void)selectTableWithName:(nonnull NSString *)name
                    keyword:(nullable NSString *)keyword
                  condition:(nullable NSString *)condition
                complection:(void(^ _Nullable)(FMResultSet  * _Nullable result ,NSError * _Nullable error))complection {

    [self.DBQueue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@%@", name, keyword, condition]];
       
        complection (set, nil);
    }];
}

/***
 *  method:删除
 **/
- (void)deleteDataWithName:(nonnull NSString *)name
                   keyword:(nullable NSString *)keyword
                 condition:(nullable NSString *)condition
               complection:(void(^ _Nullable)(BOOL result))complection {
    
    [self.DBQueue inDatabase:^(FMDatabase *db) {

        BOOL result = [db executeUpdate:[NSString stringWithFormat:@"DELETE * FROM %@ WHERE %@%@", name, keyword, condition]];
        complection(result);
    }];
}

/***
 *  method:插入
 **/
- (void)insertDataWithName:(nonnull NSString *)name
                 condition:(nonnull NSString *)condition
               complection:(void(^ _Nullable)(BOOL result))complection {
    
    [self.DBQueue inDatabase:^(FMDatabase *db) {
                                                        
        BOOL result = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ %@", name, condition]];
        complection (result);
    }];

}

@end
