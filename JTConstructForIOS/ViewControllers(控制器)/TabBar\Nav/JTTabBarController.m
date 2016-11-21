//
//  JTTabBarController.m
//  JTConstructForIOS
//
//  Created by Hjt on 16/11/21.
//  Copyright © 2016年 ShenZhenHermallUnion.Ltd. All rights reserved.
//

#import "JTTabBarController.h"

@interface JTTabBarController ()

@end

@implementation JTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    [self intilized];
}

- (void)intilized {
    
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    JTTabBar *tabBar = [[JTTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    // 设置tabBar被选中后的图片的渲染模式(颜色为本身的颜色)
    self.tabBarItem.selectedImage = [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAutomatic];
    
    self.selectedIndex = 0;
    self.title = self.tabBar.items[self.selectedIndex].title;
}


#pragma mark - ===================== UITabBarDeleagate =====================
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    // 设置标题
    self.title = item.title;
    
    // 设置推送角标
    [item setBadgeValue:nil];
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
