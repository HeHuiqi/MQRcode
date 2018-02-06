//
//  HqBillTypeChooseView.h
//  MQRcode
//
//  Created by macpro on 2018/2/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HqBillTypeChooseViewDelegate;
@interface HqBillTypeChooseView : UIView

@property (nonatomic,assign) id<HqBillTypeChooseViewDelegate> delegate;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,assign) NSInteger selectedIndex;

@end

@protocol HqBillTypeChooseViewDelegate
- (void)hqBillTypeChooseView:(HqBillTypeChooseView *)view index:(NSInteger)index;
@end
