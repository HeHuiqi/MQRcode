//
//  HqTradeStatusVC.m
//  MQRcode
//
//  Created by macpro on 2018/2/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqTradeStatusVC.h"
#import "HqBillCell.h"

@interface HqTradeStatusVC ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation HqTradeStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _records = [[NSMutableArray alloc] init];
    [self initView];
}
- (void)setRecords:(NSMutableArray *)records{
    _records = records;
    if(_records){
        if(records.count>0){
            [_tableView reloadData];
        }
    }
    _tableView.hidden = _records.count==0;
    _noContentView.hidden = records.count>0;
}
/*
- (void)getBillList{
    [HqHttpUtil hqGetShowHudTitle:nil param:nil url:@"/transactions/orders" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"账单列表==%@",responseObject);
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                NSArray *orders = [responseObject hq_objectForKey:@"orders"];
                for (NSDictionary *dic in orders) {
                    HqBill *bill = [HqBill mj_objectWithKeyValues:dic];
                    [_records addObject:bill];
                }
                _noContentView.hidden = (orders.count>0);
                _tableView.hidden = (orders.count==0);
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
        [_tableView reloadData];
    }];
}
*/

- (void)initView{
    self.navBarView.hidden = YES;
    CGFloat ctnHeight = SCREEN_HEIGHT-self.navBarheight-45;
   CGRect rect =CGRectMake(0, 0, SCREEN_WIDTH, ctnHeight);
    _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.separatorColor = LineColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _noContentView = [[HqNoContentView alloc] initWithFrame:rect];
    _noContentView.centerIcon.image = [UIImage imageNamed:@"no_bill_icon"];
    _noContentView.infoLab.text = @"no transcation record";
    [self.view addSubview:_noContentView];
    _noContentView.hidden = YES;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _records.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kZoomValue(85)  ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentfier = @"HqBillCell";
    HqBillCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfier];
    if (!cell) {
        cell = [[HqBillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentfier];
    }
    
    HqBill *bill = _records[indexPath.row];
    cell.bill = bill;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
