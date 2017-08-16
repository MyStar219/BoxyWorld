//
//  faqQstnVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 11/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface faqQstnVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *faqtblview;
@property (strong, nonatomic) IBOutlet UISearchBar *btnSearch;
@property (strong, nonatomic) IBOutlet NSString *faq_cat_Id;
@end
