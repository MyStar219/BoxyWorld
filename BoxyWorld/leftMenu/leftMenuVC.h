//
//  leftMenuVC.h
//  BoxyWorld
//
//  Created by Sambaran DAS on 15/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addFunds.h"
#import "menuHeadercellTableViewCell.h"
@interface leftMenuVC : UIViewController<UITabBarControllerDelegate>
{
     NSMutableArray *myMenuListArray;
}
@property (weak, nonatomic) IBOutlet UITableView *myMenuView;
@property (nonatomic, strong) UITabBarController *tabController;
@property (strong, nonatomic) UIWindow *window;
@end
