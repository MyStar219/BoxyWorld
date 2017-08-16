//
//  EmployeeListVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 07/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeListVC : UIViewController
{
    NSMutableArray *employeeListArray;
}
@property (weak, nonatomic) IBOutlet UIButton *btnAddEmployee;
@property (weak, nonatomic) IBOutlet UISearchBar *btnSearch;
@property (weak, nonatomic) IBOutlet UITableView *tblEmplyList;

@end
