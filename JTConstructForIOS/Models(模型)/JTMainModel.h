//
//  JTMainModel.h
//  JTConstructForIOS
//
//  Created by Hjt on 16/11/22.
//  Copyright © 2016年 ShenZhenHermallUnion.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JTMainModel : NSObject

@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* enName;
@property (nonatomic,copy) NSString* brandName;
@property (nonatomic,copy) NSString* picUrl;
@property (nonatomic,copy) NSString* specInfo;
@property (nonatomic,assign)int productId ;
@property (nonatomic, copy)NSString *price;
@end
