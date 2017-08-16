//
//  IMTUrechargeVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 23/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMTUDiscountVC.h"
#import "KPDropMenu.h"
@interface IMTUrechargeVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
     IBOutlet UITextField *activeField;
}

@property (weak, nonatomic) IBOutlet UILabel *lblHeading;
@property (weak, nonatomic) IBOutlet UIView *viewBtn;
@property (weak, nonatomic) IBOutlet UIButton *btnTopup1;
@property (weak, nonatomic) IBOutlet UIButton *btnTopup2;
@property (weak, nonatomic) IBOutlet UIButton *btnTopup3;
@property (weak, nonatomic) IBOutlet UIButton *btnTopup4;
@property (weak, nonatomic) IBOutlet UIButton *btnTopup5;
@property (weak, nonatomic) IBOutlet UIButton *btnTopup6;
@property (weak, nonatomic) IBOutlet UIButton *btnTopup7;
@property (weak, nonatomic) IBOutlet UIButton *btnTopup8;
@property (weak, nonatomic) IBOutlet UIButton *btnTopup9;




@property (weak, nonatomic) IBOutlet UITextField *txtCountry;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtCCode;
@property (weak, nonatomic) IBOutlet UITextField *txtNetwork;
@property (weak, nonatomic) IBOutlet UITextField *txtAmmount;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;
@property (weak, nonatomic) IBOutlet UIScrollView *scrVWIMTURe;

@property (nonatomic, strong) IBOutlet KPDropMenu *dropcountry;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropNetwork;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropAmount;


@end
