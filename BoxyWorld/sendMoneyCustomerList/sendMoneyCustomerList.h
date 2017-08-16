//
//  sendMoneyCustomerList.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 06/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sendMoneyCustomerList : UIViewController
{
    NSMutableArray *customerListArray;
}
@property (weak, nonatomic) IBOutlet UIButton *btnAddCustomer;
@property (weak, nonatomic) IBOutlet UIImageView *btnAddCustomerImg;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarCustomerList;
@property (weak, nonatomic) IBOutlet UITableView *tableCustomaerList;
@end
