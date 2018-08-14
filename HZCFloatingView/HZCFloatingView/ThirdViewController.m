//
//  ThirdViewController.m
//  HZCFloatingView
//
//  Created by Ken_cheng on 2018/8/14.
//  Copyright © 2018年 AiChen smart Windows and doors technology co., LTD. All rights reserved.
//

#import "ThirdViewController.h"
#import "HZCFloatingView.h"


@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"3333";
    self.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];


}
- (IBAction)clickButton:(UIButton *)sender {
    [HZCFloatingView showWithFloatVC:self];
}
- (IBAction)clickRemoveButton:(UIButton *)sender {

    [HZCFloatingView remove];
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
