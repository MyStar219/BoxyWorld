//
//  changePwdVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 27/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changePwdVC : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *fldOldPwd;
@property (strong, nonatomic) IBOutlet UITextField *fldNewPwd;
@property (strong, nonatomic) IBOutlet UITextField *fldConfrmPwd;
@property (strong, nonatomic) IBOutlet UIButton *btnChangePwd;
@property (strong, nonatomic) IBOutlet UIView *viewCP;

@property (weak, nonatomic) IBOutlet UITextField *theTextField;

@end
