//
//  JTNavigationController.m
//  JTConstructForIOS
//
//  Created by Hjt on 16/11/21.
//  Copyright © 2016年 ShenZhenHermallUnion.Ltd. All rights reserved.
//

#import "JTNavigationController.h"

@interface JTNavigationController ()

@end

@implementation JTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toolbarHidden = YES;
}

+ (void) initialize {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18.0], NSForegroundColorAttributeName: AppTintColor}];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
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
