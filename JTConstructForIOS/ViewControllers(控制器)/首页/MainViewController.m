//
//  MainViewController.m
//  JTConstructForIOS
//
//  Created by Hjt on 16/11/22.
//  Copyright © 2016年 ShenZhenHermallUnion.Ltd. All rights reserved.
//

#import "MainViewController.h"
#import "JTMainViewModel.h"
#import "JTDBManager.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray       *dataSource;
@property (nonatomic, strong) UITableView   *tableView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    [self getDataFormNetwork];
}

- (void)setup {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWidth, KHeight-49-64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
}

- (void)getDataFormNetwork {
    // 从网络加载数据
    JTMainViewModel *mainViewModel = [[JTMainViewModel alloc] init];
    mainViewModel.URL = @"http://apijewelry.hermall.com/app/home/findProductList";
    mainViewModel.parameters = nil;
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    [mainViewModel requestDataSourceWithSuccess:^(id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        NSArray *list = (NSArray *)responseObject;
        self.dataSource = list;
        [self.tableView reloadData];
        
        // 保存到数据库
        [self saveToDatabase:list];
    } fail:^(NSError * _Nullable error) {
        
        [SVProgressHUD dismiss];
        JTLOG(@"error = %@", error);
        [self getDataFormDatabase];
    } noNetwork:^(BOOL status) {
        if (!status) {
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
            [self getDataFormDatabase];
        }
    }];
}

// 从数据库加载数据
- (void)getDataFormDatabase {
    JTMainViewModel *mainViewModel = [[JTMainViewModel alloc] init];
    
    [mainViewModel getDatabaseWithName:@"t_main" keyword:@"*" condition:@"" complection:^(id _Nullable responesObject, NSError * _Nullable error) {
        if (!error) {
            NSArray *array = (NSArray *)responesObject;
            if (array.count > 0) {
                self.dataSource = array;
                [self.tableView reloadData];
            } else {
                JTLOG(@"数据库没有数据");
            }
        }
        else {
            JTLOG(@"查询失败");
        }
    }];
}

// 保存到数据库
- (void)saveToDatabase:(NSArray <JTMainModel *> *)list {
    JTDBManager *manager = [JTDBManager defaultManager];
    
    for (JTMainModel *model in list) {  // insert into Student (name, sex, age) values ('%@', '%@', '%d')
        NSString *condition = [NSString stringWithFormat:@"(name, enName, brandName, picUrl, specInfo, productId, price) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@')", model.name, model.enName, model.brandName, model.picUrl, model.specInfo, @(model.productId), model.price];
        
        [manager insertDataWithName:@"t_main" condition:condition complection:^(BOOL result) {
            if (!result) JTLOG(@"插入失败");
            else JTLOG(@"插入成功");
        }];
    }
}

#pragma mark - ===================== UITableViewDataSource =====================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setCell"];
    }
    JTMainModel *model = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.specInfo;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
