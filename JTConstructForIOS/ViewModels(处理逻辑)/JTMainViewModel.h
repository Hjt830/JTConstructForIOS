//
//  JTMainViewModel.h
//  JTConstructForIOS
//
//  Created by Hjt on 16/11/22.
//  Copyright © 2016年 ShenZhenHermallUnion.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JTViewModels.h"
#import "JTMainModel.h"
#import "JTDBManager.h"

@interface JTMainViewModel : JTViewModels

@property (nonatomic, copy) NSString *URL;
@property (nonatomic, strong)   NSDictionary *parameters;

@end
