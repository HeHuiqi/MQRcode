//
//  SuperVC.h
//  XWF_iOS
//
//  Created by iMac on 15/6/8.
//  Copyright (c) 2015年 xwf_id. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BarHeight 64
#define HqTitleColor [UIColor whiteColor]
#define HqShadowHeight 2
#define HqBarShadowHeight (BarHeight+HqShadowHeight)
@interface SuperVC : UIViewController

@property (nonatomic,strong) UIView *navBarView;
@property (nonatomic,strong) UILabel *titelLab;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,copy) NSString *leftBtnImageName;

@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,copy) NSString *rightBtnImageName;

@property (nonatomic,assign) BOOL isShowBottomLine;
@property (nonatomic,strong) UIView *bottomLine;

@property (nonatomic,strong) UIBezierPath *shadowPath;

-(void)backClick;
- (void)backToVC:(NSString *)vcName;
@end
