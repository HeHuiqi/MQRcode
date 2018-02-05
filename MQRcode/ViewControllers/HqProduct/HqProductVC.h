//
//  HqProductVC.h
//  MQRcode
//
//  Created by macpro on 2018/2/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "SuperVC.h"
typedef NS_ENUM(NSInteger,HqProductType) {
    HqProductTypeScanPay,
    HqProductTypeGenerateCode
};
@interface HqProductVC : SuperVC

@property (nonatomic,assign) HqProductType productType;

@end
