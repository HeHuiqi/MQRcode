//
//  HqGenerateCodeVC.m
//  MQRcode
//
//  Created by macpro on 2018/2/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqGenerateCodeVC.h"
#import "HqGenerateCodeView.h"
#import "HqGenerateCodeView.h"
@interface HqGenerateCodeVC ()

@property (nonatomic,strong) HqGenerateCodeView *generateCodeView;


@end

@implementation HqGenerateCodeVC
- (void)dealloc{
    [self.generateCodeView stopGetPayCode];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.generateCodeView];
    self.title = @"MQR Code";
    self.generateCodeView.backgroundColor = [UIColor whiteColor];
     NSString *url = [NSString stringWithFormat:@"/transactions/codes/%@",_merchantOrderNo];
    self.generateCodeView.codeUrl = url;
    self.generateCodeView.autoRefresh = NO;
    [self.generateCodeView startGetPayCode];
}
- (HqGenerateCodeView *)generateCodeView{
    if (!_generateCodeView) {
        _generateCodeView = [[HqGenerateCodeView alloc] initWithFrame:CGRectMake(0, self.navBarheight, self.view.frame.size.width,  self.view.frame.size.height-self.navBarheight)];
    }
    return _generateCodeView;
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
