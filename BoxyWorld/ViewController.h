//
//  ViewController.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 10/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "registerVC1.h"
@interface ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SWRevealViewController *viewController;
@property (strong, nonatomic) IBOutlet UILabel *lblforgetPWD;



@property (weak, nonatomic) IBOutlet UITextField *theTextField;


@end

