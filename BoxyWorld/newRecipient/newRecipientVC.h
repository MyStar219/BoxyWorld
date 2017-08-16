//
//  newRecipientVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 17/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPDropMenu.h"
@interface newRecipientVC : UIViewController
{
     IBOutlet UITextField *activeField;
}
@property (weak, nonatomic) IBOutlet UITextField *txtFName;
@property (weak, nonatomic) IBOutlet UITextField *txtLName;
@property (weak, nonatomic) IBOutlet UITextField *txtMName;
@property (weak, nonatomic) IBOutlet UITextField *txtMail;
@property (weak, nonatomic) IBOutlet UITextField *txtPrePh;
@property (weak, nonatomic) IBOutlet UITextField *txtPhno;
@property (weak, nonatomic) IBOutlet UITextField *txtCountry;
@property (weak, nonatomic) IBOutlet UITextField *txtBank;
@property (weak, nonatomic) IBOutlet UITextField *txtACNo;
@property (weak, nonatomic) IBOutlet UITextField *txtConfrmACNo;
@property (weak, nonatomic) IBOutlet UITextField *txtselectBox;
@property (weak, nonatomic) IBOutlet UIButton *btnAddAsContact;
@property (weak, nonatomic) IBOutlet UIScrollView *scrNewRecipent;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectBox;

@property (nonatomic, strong) IBOutlet KPDropMenu *dropcountry;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropBank;
@end
