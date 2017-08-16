//
//  addSubAgentVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 23/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPDropMenu.h"
//#import "DownPicker.h"
//#import "UIDownPicker.h"
@interface addSubAgentVC : UIViewController
{
    IBOutlet UITextField *activeField;
}
@property (weak, nonatomic) IBOutlet UITextField *txtFName;
@property (weak, nonatomic) IBOutlet UITextField *txtLName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtCCode;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtAltrPhone;

@property (weak, nonatomic) IBOutlet UITextField *txtCountry;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtZipCode;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtCPWD;
@property (weak, nonatomic) IBOutlet UITextField *txtBusinessName;
@property (weak, nonatomic) IBOutlet UITextField *txtCommision;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollAddSubAgent;


@property (nonatomic, strong) IBOutlet KPDropMenu *dropcountry;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropState;
//@property (strong, nonatomic) DownPicker *downPicker;
//@property (strong, nonatomic) DownPicker *downPickerState;


@end
