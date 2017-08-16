//
//  addBankVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 17/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPDropMenu.h"
@interface addBankVC : UIViewController
{
    IBOutlet UITextField *activeField;
}
@property (weak, nonatomic) IBOutlet UITextField *txtFName;
@property (weak, nonatomic) IBOutlet UITextField *txtLName;
@property (weak, nonatomic) IBOutlet UITextField *txtPrePhNo;
@property (weak, nonatomic) IBOutlet UITextField *txtPhno;
@property (weak, nonatomic) IBOutlet UITextField *txtMail;
@property (weak, nonatomic) IBOutlet UITextField *txtCountry;
@property (weak, nonatomic) IBOutlet UITextField *txtBank;
@property (weak, nonatomic) IBOutlet UITextField *txtAccountNo;
@property (weak, nonatomic) IBOutlet UITextField *txtConfrmAccountNo;

@property (weak, nonatomic) IBOutlet UIButton *btnAddBank;
@property (weak, nonatomic) IBOutlet UIScrollView *scrAddBank;
@property (weak, nonatomic) IBOutlet UIButton *btnActionselectBox;

@property (nonatomic, strong) IBOutlet KPDropMenu *dropcountry;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropBank;
@end
