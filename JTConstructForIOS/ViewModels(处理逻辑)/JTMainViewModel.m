//
//  JTMainViewModel.m
//  JTConstructForIOS
//
//  Created by Hjt on 16/11/22.
//  Copyright © 2016年 ShenZhenHermallUnion.Ltd. All rights reserved.
//

#import "JTMainViewModel.h"

@implementation JTMainViewModel

- (void)requestDataSourceWithSuccess:(NetworkSuccess)successComplection
                                fail:(NetworkFail)failCompletion
                           noNetwork:(NoNetwork)noNetworkComplection {
    
    [JTNetTool netWorkReachabilityWithURLString:self.URL complectionBlock:^(BOOL stasus) {
        noNetworkComplection (stasus);
    }];
    
    [JTNetTool requestDataFromNetworkWithMethod:JTNetTypeGET url:self.URL parameters:self.parameters successComplection:^(NSDictionary * _Nullable responesObject) {
        // 转模型后返回数据
        NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:0];
        NSArray *list = [responesObject objectForKey:@"list"];
        for (NSDictionary *dic in list) {
            JTMainModel *mainModel = [JTMainModel mj_objectWithKeyValues:dic];
            [dataSource addObject:mainModel];
        }
        successComplection (dataSource);
        
    } failComplection:^(NSError * _Nullable error) {
        
        failCompletion (error);
    } noNetwork:^(NSError * _Nullable noNetwork) {
        
        noNetworkComplection (noNetwork);
    }];
}

- (void)getDatabaseWithName:(NSString * _Nonnull)name
                    keyword:(NSString * _Nullable)keyword
                  condition:(NSString * _Nullable)condition
                complection:(void (^ _Nullable)(id _Nullable, NSError * _Nullable))complection{
    
    JTDBManager *manager = [JTDBManager defaultManager];
    
    [manager selectTableWithName:name keyword:keyword condition:condition complection:^(FMResultSet * _Nullable result, NSError * _Nullable error) {
        if (!error) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            while ([result next]) {
                JTMainModel *model = [[JTMainModel alloc] init];
                model.name = [result stringForColumn:@"name"];
                model.enName = [result stringForColumn:@"enName"];
                model.brandName = [result stringForColumn:@"brandName"];
                model.picUrl = [result stringForColumn:@"picUrl"];
                model.specInfo = [result stringForColumn:@"specInfo"];
                model.price = [result stringForColumn:@"price"];
                model.productId = [result intForColumn:@"productId"];
                [array addObject:model];
            }
            complection (array, nil);
        }
        else {
            complection (nil, error);
        }
    }];
    
}

@end
