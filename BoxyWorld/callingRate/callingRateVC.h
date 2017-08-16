//
//  callingRateVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 12/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPDropMenu.h"
@interface callingRateVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtRate;
@property (weak, nonatomic) IBOutlet UIButton *btnGetRate;
@property (weak, nonatomic) IBOutlet UITableView *tblratelist;

@property (nonatomic, strong) IBOutlet KPDropMenu *dropcountry;
@property (strong, nonatomic) IBOutlet UIView *viewCallRate;

@end
