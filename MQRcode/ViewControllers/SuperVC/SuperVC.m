//
//  SuperVC.m
//  HHQ
//
//  Created by iMac on 15/6/8.
//  Copyright (c) 2015年 HHQ. All rights reserved.
//

#import "SuperVC.h"
#define BarHeight 64
#define HqTitleColor [UIColor whiteColor]
@interface SuperVC ()

@end

@implementation SuperVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navBarView];
//    self.navBarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navBarView.backgroundColor  = AppMainColor;
    [self titelLab];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtnImageName = nil;
    
   
}
- (UILabel *)titelLab{
    if (!_titelLab) {
        _titelLab = [[UILabel alloc]init];
        _titelLab.textColor = HqTitleColor;
        _titelLab.font = [UIFont boldSystemFontOfSize:kZoomValue(18)];
        [self.navBarView addSubview:_titelLab];
        [_titelLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.navBarView.mas_centerX);
//            make.left.equalTo(self.navBarView).offset(kZoomValue(50));
            make.top.equalTo(_navBarView).offset(20);
            make.height.mas_equalTo(44);
        }];
    }
    return _titelLab;
}
- (void)setLeftBtn:(UIButton *)leftBtn{
    
    if (leftBtn) {
        [_leftBtn removeFromSuperview];
        _leftBtn = leftBtn;
        [self.navBarView addSubview:_leftBtn];
    }
    self.leftBtn.tintColor = [UIColor whiteColor];

    [_leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_navBarView).offset(0);
        make.top.equalTo(_navBarView).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 44));
    }];
}
- (void)setLeftBtnImageName:(NSString *)leftBtnImageName{

    UIImage * image = nil;
    if (leftBtnImageName.length > 0) {
        image = [UIImage imageNamed:leftBtnImageName];
    }else{
        image = [UIImage imageNamed:@"back"];
    }
    [_leftBtn setImage:image forState:UIControlStateNormal];
}

- (void)setRightBtn:(UIButton *)rightBtn{
    _rightBtn = rightBtn;
    
    if (rightBtn) {
        [_rightBtn removeFromSuperview];
        _rightBtn = rightBtn;
        [self.navBarView addSubview:_rightBtn];
    }
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_navBarView).offset(0);
        make.top.equalTo(_navBarView).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 44));
    }];
}
- (void)setRightBtnImageName:(NSString *)rightBtnImageName{
    
    UIImage * image = [UIImage imageNamed:rightBtnImageName];
    
    [_rightBtn setImage:image forState:UIControlStateNormal];
}
- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    _titelLab.text = title;
}
-(UIView *)navBarView{
    if (!_navBarView) {
        _navBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, BarHeight)];
        _navBarView.backgroundColor = [UIColor whiteColor];
    }
    
    return _navBarView;
}
- (void)setIsShowBottomLine:(BOOL)isShowBottomLine{
    _isShowBottomLine = isShowBottomLine;
    
    if (_isShowBottomLine) {
        UIView *xline = [[UIView alloc] init];
        xline.backgroundColor = COLOR(0,0,0,0.2);
        [_navBarView addSubview:xline];
        [xline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_navBarView).offset(0);
            make.left.equalTo(self.view).offset(0);
            make.right.equalTo(self.view).offset(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        }];
        _bottomLine = xline;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)backClick
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)backToVC:(NSString *)vcName{
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    for (UIViewController *vc in viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(vcName)]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}
@end