//
//  exploreVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 14/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPDropMenu.h"

@interface exploreVC : UIViewController
{
    IBOutlet UITextField *activeField;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *btnSaveConstraint;
@property (weak, nonatomic) IBOutlet UITextField *txtmoneySentTo;
@property (weak, nonatomic) IBOutlet UITextField *txtAmt1;
@property (weak, nonatomic) IBOutlet UITextField *txtAmt2;
@property (weak, nonatomic) IBOutlet UITextField *txtUsd1;
@property (weak, nonatomic) IBOutlet UITextField *txtUsd2;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveCon;
@property (weak, nonatomic) IBOutlet UIScrollView *scrExpor;
@property (strong, nonatomic) IBOutlet UIView *viewExp;
@property (weak, nonatomic) IBOutlet UIButton *btnforBank;
@property (weak, nonatomic) IBOutlet UIButton *btnForMobile;
@property (weak, nonatomic) IBOutlet UILabel *lblForBank;
@property (weak, nonatomic) IBOutlet UILabel *lblForMobile;
@property (weak, nonatomic) IBOutlet UIView *viewBySentMoney;
@property (strong, nonatomic) IBOutlet UILabel *lblrecieveMoney;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *saveBtnHeight;
@property (strong, nonatomic) IBOutlet UIStackView *stackExplore;

@property (nonatomic, strong) IBOutlet KPDropMenu *dropcountry;
@end
