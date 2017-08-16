//
//  helpVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 11/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPDropMenu.h"

@interface helpVC : UIViewController
{
    IBOutlet UITextField *activeField;
}
@property (weak, nonatomic) IBOutlet UITextField *txtFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtpriority;
@property (weak, nonatomic) IBOutlet UITextField *txtSub;
@property (weak, nonatomic) IBOutlet UITextView *txtmsg;
@property (weak, nonatomic) IBOutlet UIButton *btnSent;
@property (weak, nonatomic) IBOutlet UIScrollView *scrHelp;


@property (nonatomic, strong) IBOutlet KPDropMenu *dropPriority;
@end
