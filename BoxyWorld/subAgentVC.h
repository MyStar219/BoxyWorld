//
//  subAgentVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 23/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface subAgentVC : UIViewController
{
     NSMutableArray *agentListArray;
}

@property (weak, nonatomic) IBOutlet UIButton *btnMoneyTransferToAgent;
@property (weak, nonatomic) IBOutlet UIButton *btnTransferHistory;
@property (weak, nonatomic) IBOutlet UISearchBar *agentSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *tblviewAgent;
@property (weak, nonatomic) IBOutlet UIButton *btnSubAgent;




@end
