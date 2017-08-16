//
//  CitiDetailsVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 13/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitiDetailsVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITableView *tblCitiesList;


@property (strong, nonatomic) IBOutlet NSString *CountryCode;
@end
