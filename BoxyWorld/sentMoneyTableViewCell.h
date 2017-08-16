//
//  sentMoneyTableViewCell.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 31/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sentMoneyTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *btnSentMoney;
@property (strong, nonatomic) IBOutlet UIButton *btnPinlessRchrg;
@property (strong, nonatomic) IBOutlet UIButton *btnIMTUrchrg;
@property (strong, nonatomic) IBOutlet UIButton *btnAddCash;

@property (strong, nonatomic) IBOutlet UILabel *SM_TotalSale;
@property (strong, nonatomic) IBOutlet UILabel *PR_TotalSale;
@property (strong, nonatomic) IBOutlet UILabel *IMPU_TotalSale;
@property (strong, nonatomic) IBOutlet UILabel *AC_TotalSale;

@end
