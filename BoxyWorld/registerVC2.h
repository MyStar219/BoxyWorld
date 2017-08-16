//
//  registerVC2.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 13/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeVC.h"

@interface registerVC2 : UIViewController
{
    IBOutlet UITextField *activeField;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrVwregVC2;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *zipcode;
@property (weak, nonatomic) IBOutlet UITextField *busnessName;
@property (weak, nonatomic) IBOutlet UITextField *cPassword;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *turmsBtn;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;

@property (strong, nonatomic) IBOutlet NSString *fname;
@property (strong, nonatomic) IBOutlet NSString *lname;
@property (strong, nonatomic) IBOutlet NSString *email;
@property (strong, nonatomic) IBOutlet NSString *country;
@property (strong, nonatomic) IBOutlet NSString *phno;
@property (strong, nonatomic) IBOutlet NSString *state;
@end
