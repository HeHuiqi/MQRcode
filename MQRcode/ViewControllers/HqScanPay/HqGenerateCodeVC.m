//
//  HqGenerateCodeVC.m
//  MQRcode
//
//  Created by macpro on 2018/2/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqGenerateCodeVC.h"
#import "HqMyPayCodeView.h"

@interface HqGenerateCodeVC ()

@property (nonatomic,strong) HqMyPayCodeView *payCodeView;


@end

@implementation HqGenerateCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.payCodeView];
    self.title = @"MQR Code";
    self.payCodeView.hidden = YES;
    self.payCodeView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self getPayCode];

}
- (HqMyPayCodeView *)payCodeView{
    if (!_payCodeView) {
        _payCodeView = [[HqMyPayCodeView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,  self.view.frame.size.height-64)];
        _payCodeView.backgroundColor = AppMainColor;
    }
    return _payCodeView;
}
- (void)getPayCode{
    NSString *url = [NSString stringWithFormat:@"/transactions/codes/%@",_merchantOrderNo];
    [HqHttpUtil hqGetShowHudTitle:nil param:nil url:url complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"==%@",responseObject);
        
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                NSString *payCode = [responseObject hq_objectForKey:@"collectCode"];
                if (payCode.length>0) {
                    self.payCodeView.payCodeInfo = payCode;
                    self.payCodeView.hidden = NO;
                }
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
