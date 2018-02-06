//
//  LoginVC.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "LoginVC.h"
#import "HqInputView.h"

@interface LoginVC ()<UITextFieldDelegate>

@property (nonatomic,strong) HqInputView *userIdTf;
@property (nonatomic,strong) HqInputView *passwordTf;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
}
- (void)initView{
    
    UILabel *topLab = [[UILabel alloc] init];
    topLab.text = @"Multiple payments ,one yard whole.";
    topLab.font = [UIFont boldSystemFontOfSize:18.0];
    [self.view addSubview:topLab];
    [topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kZoomValue(55));
        make.centerX.equalTo(self.view);
    }];
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    contentView.backgroundColor = COLORA(227,242,253);
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kZoomValue(118));
        make.left.equalTo(self.view).offset(kZoomValue(35));
        make.bottom.equalTo(self.view).offset(kZoomValue(-118));
        make.right.equalTo(self.view).offset(kZoomValue(-35));
    }];
    
    UIImageView *loginLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    loginLogo.contentMode = UIViewContentModeScaleAspectFill;
    [contentView addSubview:loginLogo];
    [loginLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(kZoomValue(78));
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(118), kZoomValue(116)));
    }];
    
    
    CGFloat inputHeight = 45;
    CGFloat leftSpace = 0;
    
    UIColor *inputBgColor = COLORA(79,161,218);
    UIColor *inputContentColor = [UIColor whiteColor];
    NSString *userId = @"User ID";
    
    _userIdTf = [[HqInputView alloc] initWithPlacehoder:userId];
    [_userIdTf setPlacehoder:userId color:inputContentColor];
    _userIdTf.textColor = inputContentColor;
    _userIdTf.delegate = self;
    _userIdTf.keyboardType = UIKeyboardTypeNumberPad;
    _userIdTf.backgroundColor = inputBgColor;
    [contentView addSubview:_userIdTf];
    NSString *password = @"Password";
    _passwordTf = [[HqInputView alloc] initWithPlacehoder:password];
    [_passwordTf setPlacehoder:password color:inputContentColor];
    _passwordTf.textColor = inputContentColor;
    _passwordTf.delegate = self;
    _passwordTf.secureTextEntry = YES;
    _passwordTf.backgroundColor = inputBgColor;
    [contentView addSubview:_passwordTf];
    
    UIView *xline = [[UIView alloc] init];
    xline.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:xline];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.tintColor = COLORA(25,118,210);
    [loginBtn setTitle:@"ENTER" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginApp:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:loginBtn];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(0);
        make.bottom.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];

    /*
    NSString *title = @"Forgot password?";
    UIColor *titleColor = [UIColor darkTextColor];
    HqString *str = [[HqString alloc] initWithHqString:title];
    [str setHqUnderlineColor:titleColor lineStyle:NSUnderlineStyleSingle range:NSMakeRange(0, title.length)];
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    forgetBtn.tintColor = titleColor;
    [forgetBtn setAttributedTitle:str.hqAttributedString forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgotPassword:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:forgetBtn];
    
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.top.equalTo(loginBtn.mas_bottom).offset(kZoomValue(20));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(leftSpace));
    }];
    */
    
    [_passwordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.bottom.equalTo(loginBtn.mas_top).offset(0);
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    [xline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.bottom.equalTo(_passwordTf.mas_top).offset(0);
        make.height.mas_equalTo(LineHeight);
    }];
    [_userIdTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.bottom.equalTo(xline.mas_top).offset(0);
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
}
- (void)loginApp:(UIButton *)btn{
    
    
    if(_userIdTf.text.length==0){
        [Dialog simpleToast:@"The user id can't be empty"];
        return;
    }
    /*
    BOOL isNumber = [NSString isMobileNumber:_userIdTf.text];
    if(_userIdTf.text.length<kMobileNumberMinLength||!isNumber){
        [Dialog simpleToast:@"Incorrect phone number"];
        return;
    }
    */
    if(_passwordTf.text.length==0){
        [Dialog simpleToast:@"The password can't be empty"];
        return;
    }
    if(_passwordTf.text.length<6){
        [Dialog simpleToast:@"The password's length 6~14 "];
        return;
    }
    NSString *password = [NSString sha1:_passwordTf.text];
    NSDictionary *param = @{@"username": _userIdTf.text,
                            @"password": password};
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:@"/users/sessions" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"登录===%@",responseObject);
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                NSString *token = [responseObject hq_objectForKey:@"token"];
                SetUserDefault(token, kToken);
                SetUserDefault(@"1", kisLogin);
                
                AppDelegate *app = [AppDelegate shareApp];
                app.isInputGesturePassword = NO;
                [AppDelegate setRootVC:HqSetRootVCHome];
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
    
    
}
- (void)forgotPassword:(UIButton *)btn{
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if ([textField isEqual:_userIdTf]) {
        if (textField.text.length >=kMobileNumberLength) {
            return NO;
        }
    }
    
    if ([textField isEqual:_passwordTf]) {
        if (textField.text.length >=kPasswordMaxLength) {
            return NO;
        }
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

