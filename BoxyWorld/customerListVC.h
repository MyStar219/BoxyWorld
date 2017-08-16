//
//  customerListVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 21/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customerListVC : UIViewController
{
    NSMutableArray *customerListArray;
}
@property (weak, nonatomic) IBOutlet UIButton *btnAddCustomer;
@property (weak, nonatomic) IBOutlet UIImageView *btnAddCustomerImg;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarCustomerList;
@property (weak, nonatomic) IBOutlet UITableView *tableCustomaerList;
@end
