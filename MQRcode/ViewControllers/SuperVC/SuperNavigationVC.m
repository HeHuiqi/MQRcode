//
//  SuperNavigationVC.m
//  HHQ
//
//  Created by iMac on 15/7/17.
//  Copyright (c) 2015年 HHQ. All rights reserved.
//

//#define NavigationBarColor COLOR(59, 181, 247, 1)

#import "SuperNavigationVC.h"

@interface SuperNavigationVC ()<UIGestureRecognizerDelegate>

@end

@implementation SuperNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = YES;
    self.interactivePopGestureRecognizer.delegate = self;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    BOOL isPop = self.viewControllers.count==1 ? NO:YES;
    return isPop;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
