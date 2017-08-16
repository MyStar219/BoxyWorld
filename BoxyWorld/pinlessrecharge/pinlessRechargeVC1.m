//
//  pinlessRechargeVC1.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 04/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "pinlessRechargeVC1.h"

@interface pinlessRechargeVC1 ()

@end

@implementation pinlessRechargeVC1
@synthesize fldCustomerPH;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //Customer Phone NUmber
    UIView *paddingfldCustomerPH = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    fldCustomerPH.leftView = paddingfldCustomerPH;
    fldCustomerPH.leftViewMode = UITextFieldViewModeAlways;
    fldCustomerPH.layer.cornerRadius=8.0f;
    fldCustomerPH.layer.masksToBounds=YES;
    fldCustomerPH.layer.borderColor=[[UIColor whiteColor]CGColor];
    fldCustomerPH.layer.borderWidth= 1.0f;
    fldCustomerPH.delegate=self;
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
