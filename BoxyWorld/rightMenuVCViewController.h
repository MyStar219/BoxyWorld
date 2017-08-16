//
//  rightMenuVCViewController.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 15/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "addFunds.h"
#import "rightMenuHeader.h"
#import "rightmenuFooter.h"
#import "rightMenuCell.h"

@interface rightMenuVCViewController : UIViewController
{

        NSMutableArray *rightMenuListArray;
    
}
@property (weak, nonatomic) IBOutlet UITableView *RightMenuView;

@end
