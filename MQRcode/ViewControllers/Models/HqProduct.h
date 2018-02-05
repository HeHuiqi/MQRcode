//
//  HqProduct.h
//  MQRcode
//
//  Created by macpro on 2018/2/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HqProduct : NSObject

@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *currency;

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) CGFloat price;

@end
