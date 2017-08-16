//
//  recipientVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 17/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPDropMenu.h"

@interface recipientVC : UIViewController
{
    IBOutlet UITextField *activeField;
}

@property (weak, nonatomic) IBOutlet UILabel *lblHead;
@property (weak, nonatomic) IBOutlet UIButton *btnAddRecipient;
@property (weak, nonatomic) IBOutlet UILabel *lblFirst;
@property (weak, nonatomic) IBOutlet UITextField *txtFirst;
@property (weak, nonatomic) IBOutlet UILabel *lblSecond;
@property (weak, nonatomic) IBOutlet UITextField *fldSecond;
@property (weak, nonatomic) IBOutlet UILabel *lblThird;
@property (weak, nonatomic) IBOutlet UITextField *fldThird;
@property (weak, nonatomic) IBOutlet UIButton *btnAddAcc;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveANDCon;
@property (weak, nonatomic) IBOutlet UIScrollView *scrRecipient;

@property (strong, nonatomic) IBOutlet NSString *flagTransBy;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropRecipient;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropBank;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropNewwork;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropMobile;

@end
