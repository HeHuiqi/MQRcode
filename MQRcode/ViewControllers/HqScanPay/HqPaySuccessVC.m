//
//  HqPaySuccessVC.m
//  QRCode
//
//  Created by macpro on 2018/1/23.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqPaySuccessVC.h"

@interface HqPaySuccessVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HqPaySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [AppDelegate shareApp].isScanRecive = NO;
}
- (void)initView{
    self.title = @"Success";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarheight, SCREEN_WIDTH, SCREEN_HEIGHT-self.navBarheight) style:UITableViewStyleGrouped];
    _tableView.separatorColor = LineColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentfier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentfier];
    }
    NSString *title = @"";
    NSString *rightTitle = @"";
    switch (indexPath.row) {
            case 0:
        {
            title = @"Payer";
            rightTitle = [_payInfo hq_objectForKey:@"payUser"];
        }
            break;
            case 1:
        {
            title = @"PayMethod";
            rightTitle = [_payInfo hq_objectForKey:@"payMethod"];
        }
            break;
            case 2:
        {
            title = @"PayTime";
            NSString *timeStr = [_payInfo hq_objectForKey:@"payTime"];
            long long time =  timeStr.longLongValue/1000.0;
            HqDateFormatter *date = [HqDateFormatter shareInstance];
            NSString *dateStr = [date dateStringWithFormat:@"yyyy-MM-dd HH:ss:mm" timeInterval:time];
            rightTitle = dateStr;
        }
            break;
            
        default:
            break;
    }
    cell.textLabel.text = title;
    cell.detailTextLabel.text = rightTitle;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)backClick{
    if (self.isPushShow) {
        Dismiss();
    }else{
        [self backToVC:@"HqProductVC"];
    }
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

