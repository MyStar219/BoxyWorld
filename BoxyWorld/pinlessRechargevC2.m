//
//  pinlessRechargevC2.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 04/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "pinlessRechargevC2.h"

@interface pinlessRechargevC2 ()

@end

@implementation pinlessRechargevC2
@synthesize fldRechargeAmt,lblhead,fldfname,flslname,fldEmail,btnSubmit;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //Customer RechargeAmount
    UIView *paddingrechargeAmt = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    fldRechargeAmt.leftView = paddingrechargeAmt;
    fldRechargeAmt.leftViewMode = UITextFieldViewModeAlways;
    fldRechargeAmt.layer.cornerRadius=8.0f;
    fldRechargeAmt.layer.masksToBounds=YES;
    fldRechargeAmt.layer.borderColor=[[UIColor whiteColor]CGColor];
    fldRechargeAmt.layer.borderWidth= 1.0f;
    fldRechargeAmt.delegate=self;
    
    //Label Head
   // UIView *paddingLabelHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
   //lblhead.leftView = paddingLabelHead;
   // lblhead.leftViewMode = UITextFieldViewModeAlways;
    lblhead.layer.cornerRadius=8.0f;
    lblhead.layer.masksToBounds=YES;
    lblhead.layer.borderColor=[[UIColor whiteColor]CGColor];
    lblhead.layer.borderWidth= 1.0f;
   // lblhead.delegate=self;
    
    //First Name
    fldfname.layer.cornerRadius=8.0f;
    fldfname.layer.masksToBounds=YES;
    fldfname.layer.borderColor=[[UIColor whiteColor]CGColor];
    fldfname.layer.borderWidth= 1.0f;
    
    // last name
    flslname.layer.cornerRadius=8.0f;
    flslname.layer.masksToBounds=YES;
    flslname.layer.borderColor=[[UIColor whiteColor]CGColor];
    flslname.layer.borderWidth= 1.0f;
    
    //email
    fldEmail.layer.cornerRadius=8.0f;
    fldEmail.layer.masksToBounds=YES;
    fldEmail.layer.borderColor=[[UIColor whiteColor]CGColor];
    fldEmail.layer.borderWidth= 1.0f;

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitBtnAction:(id)sender {
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
