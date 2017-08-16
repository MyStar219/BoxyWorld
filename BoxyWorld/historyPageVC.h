//
//  historyPageVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 28/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface historyPageVC : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrVwHistory;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *table1st;
@property (strong, nonatomic) IBOutlet UITableView *table2nd;
@property (strong, nonatomic) IBOutlet UITableView *table3rd;

@property (strong, nonatomic) IBOutlet NSString *searchText;
@end
