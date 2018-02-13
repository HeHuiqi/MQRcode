//
//  HqChangePasswordVC.m
//  MQRcode
//
//  Created by macpro on 2018/2/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqChangePasswordVC.h"
#import "HqInputView.h"
@interface HqChangePasswordVC ()

@property (nonatomic,strong) HqInputView *oldPasswordTf;
@property (nonatomic,strong) HqInputView *hqNewPasswordTf;
@property (nonatomic,strong) HqInputView *confirmPasswordTf;

@end

@implementation HqChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Modify Password";
    [self initView];
}

- (void)initView{
    
    UIView *contentView = self.view;
    CGFloat inputHeight = 45;
    CGFloat leftSpace = 20;
    UIColor *borderColor = COLORA(230,230,230);
    CGFloat boderWidth = LineHeight;

    _oldPasswordTf = [[HqInputView alloc] initWithPlacehoder:@"The original password" leftIcon:@"hqpassword_icon"];
    _oldPasswordTf.secureTextEntry = YES;
    _oldPasswordTf.layer.borderWidth = boderWidth;
    _oldPasswordTf.layer.borderColor = borderColor.CGColor;
    _oldPasswordTf.backgroundColor = [UIColor whiteColor];
    _oldPasswordTf.layer.cornerRadius = kHqCornerRadius;
    [contentView addSubview:_oldPasswordTf];
    
    [_oldPasswordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
    make.top.equalTo(contentView).offset(kZoomValue(leftSpace+self.navBarheight));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
    UIView *newPasswordView = [[UIView alloc] init];
    newPasswordView.layer.borderWidth = boderWidth;
    newPasswordView.layer.borderColor = borderColor.CGColor;
    newPasswordView.layer.cornerRadius = kHqCornerRadius;
    newPasswordView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:newPasswordView];
    [newPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.top.equalTo(_oldPasswordTf.mas_bottom).offset(kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(inputHeight*2)+2);
    }];
    
    _hqNewPasswordTf = [[HqInputView alloc] initWithPlacehoder:@"The new password" leftIcon:@"hqpassword_icon"];
    _hqNewPasswordTf.secureTextEntry = YES;
    _hqNewPasswordTf.layer.cornerRadius = kHqCornerRadius;
    [newPasswordView addSubview:_hqNewPasswordTf];
    
    [_hqNewPasswordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newPasswordView).offset(0);
        make.right.equalTo(newPasswordView).offset(0);
        make.top.equalTo(newPasswordView).offset(0);
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    UIView *xline = [[UIView alloc] init];
    xline.backgroundColor = borderColor;
    [newPasswordView addSubview:xline];
    [xline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newPasswordView).offset(0);
        make.right.equalTo(newPasswordView).offset(0);
        make.top.equalTo(_hqNewPasswordTf.mas_bottom).offset(0);
        make.height.mas_equalTo(boderWidth);
    }];
    _confirmPasswordTf = [[HqInputView alloc] initWithPlacehoder:@"Confirm new password" leftIcon:@"hqpassword_icon"];
    _confirmPasswordTf.secureTextEntry = YES;
    _confirmPasswordTf.layer.cornerRadius = kHqCornerRadius;
    [newPasswordView addSubview:_confirmPasswordTf];
    [_confirmPasswordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newPasswordView).offset(0);
        make.right.equalTo(newPasswordView).offset(0);
        make.top.equalTo(xline.mas_bottom).offset(0);
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    changeBtn.tintColor = [UIColor whiteColor];
    [changeBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    changeBtn.backgroundColor = COLOR(17, 139, 226, 1);
    [changeBtn addTarget:self action:@selector(changePassword:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:changeBtn];
    changeBtn.layer.cornerRadius = kHqCornerRadius;
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(newPasswordView.mas_bottom).offset(kZoomValue(30));
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
}
- (void)changePassword:(UIButton *)btn{
    
    if(_oldPasswordTf.text.length == 0){
        [Dialog toastCenter:@"The old password can't be empty"];
        return;
    }
    if(_hqNewPasswordTf.text.length == 0){
        [Dialog toastCenter:@"The new password can't be empty"];
        return;
    }
    if(_confirmPasswordTf.text.length == 0){
        [Dialog toastCenter:@"The confirm password can't be empty"];
        return;
    }
    BOOL isSame =[_hqNewPasswordTf.text isEqualToString:_confirmPasswordTf.text];
    if(!isSame){
        [Dialog toastCenter:@"New password and confirm password are inconsistent"];
        return;
    }
    NSString *oldp = [NSString sha1:_oldPasswordTf.text];
    NSString *newp = [NSString sha1:_confirmPasswordTf.text];
    NSDictionary *param = @{@"oldPassword": oldp,
                            @"newPassword": newp};
    [HqHttpUtil hqPutShowHudTitle:nil param:param url:@"/users/passwords" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"==%@",responseObject);
        
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                SetUserDefault(nil, kToken);
                SetUserDefault(nil, kisLogin);
                [AppDelegate setRootVC:HqSetRootVCLogin];
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
