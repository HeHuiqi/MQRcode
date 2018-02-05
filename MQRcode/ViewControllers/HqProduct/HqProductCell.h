//
//  HqProductCell.h
//  MQRcode
//
//  Created by macpro on 2018/2/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HqProductCell : UITableViewCell

@property (nonatomic,strong) UIImageView *leftIcon;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *priceLab;

@property (nonatomic,strong) HqProduct *product;

@end
