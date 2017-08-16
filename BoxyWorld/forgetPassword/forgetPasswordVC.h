//
//  forgetPasswordVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 27/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface forgetPasswordVC : UIViewController
{
    IBOutlet UITextField *activeField;
}
@property (strong, nonatomic) IBOutlet UITextField *fldEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnResetPwd;
@property (strong, nonatomic) IBOutlet UIScrollView *scrforgetPWD;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;

@end
