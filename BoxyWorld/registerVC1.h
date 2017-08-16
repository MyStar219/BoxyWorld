//
//  registerVC1.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 12/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "registerVC2.h"
#import "KPDropMenu.h"
@interface registerVC1 : UIViewController
{
    IBOutlet UITextField *activeField;
}
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *country;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *state;
@property (weak, nonatomic) IBOutlet UITextField *preph;
@property (weak, nonatomic) IBOutlet UIScrollView *RegScrlView;
@property (strong, nonatomic) IBOutlet UIButton *btnlogin;

@property (nonatomic, strong) IBOutlet KPDropMenu *dropcountry;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropState;

@end
