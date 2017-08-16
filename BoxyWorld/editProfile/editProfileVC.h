//
//  editProfileVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 03/08/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPDropMenu.h"

@interface editProfileVC : UIViewController
{
     IBOutlet UITextField *activeField;
}

@property (strong, nonatomic) IBOutlet UITextField *textEmail;
@property (strong, nonatomic) IBOutlet UITextField *textFname;
@property (strong, nonatomic) IBOutlet UITextField *textLname;
@property (strong, nonatomic) IBOutlet UITextField *textAddr;
@property (strong, nonatomic) IBOutlet UITextField *textPhone;
@property (strong, nonatomic) IBOutlet UITextField *textCountry;
@property (strong, nonatomic) IBOutlet UITextField *textState;
@property (strong, nonatomic) IBOutlet UITextField *textCity;
@property (strong, nonatomic) IBOutlet UITextField *textZip;
@property (strong, nonatomic) IBOutlet UITextField *textBusinessName;
@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
@property (strong, nonatomic) IBOutlet UIScrollView *scrEditPrfl;

@property (nonatomic, strong) IBOutlet KPDropMenu *dropcountry;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropState;



@end
