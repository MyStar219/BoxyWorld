//
//  addCardVC.h
//  BoxyWorld
//
//  Created by Sambaran DAS on 21/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPDropMenu.h"
@interface addCardVC : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrAddCard;
@property (weak, nonatomic) IBOutlet UITextField *txtCardNo;
@property (weak, nonatomic) IBOutlet UITextField *txtMnth;
@property (weak, nonatomic) IBOutlet UITextField *txtYear;
@property (weak, nonatomic) IBOutlet UITextField *txtCVV;
@property (weak, nonatomic) IBOutlet UITextField *txtCardHolderName;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtBillingState;
@property (weak, nonatomic) IBOutlet UITextField *txtZipCode;
@property (weak, nonatomic) IBOutlet UIButton *btnAddCard;

@property (nonatomic, strong) IBOutlet KPDropMenu *dropState;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropmonth;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropyear;


@end
