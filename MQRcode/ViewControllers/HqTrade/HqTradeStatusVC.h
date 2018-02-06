//
//  HqTradeStatusVC.h
//  MQRcode
//
//  Created by macpro on 2018/2/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HqTradeStatusVC : UIViewController

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *records;
@property (nonatomic,strong) HqNoContentView *noContentView;

@end
