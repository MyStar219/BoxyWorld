//
//  homeVC.h
//  BoxyWorld
//
//  Created by Sambaran DAS on 15/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "headerview.h"
#import "addFunds.h"
@interface homeVC : UIViewController{
    NSMutableArray *mylistingArray;
   
    headerview * headerViewObj;
    
}
@property (weak, nonatomic) IBOutlet UITableView *myListTableView;

@end
