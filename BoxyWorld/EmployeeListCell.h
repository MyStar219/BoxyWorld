//
//  EmployeeListCell.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 07/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *txtname;
@property (weak, nonatomic) IBOutlet UILabel *txtSince;
@property (weak, nonatomic) IBOutlet UILabel *txtEmail;
@property (weak, nonatomic) IBOutlet UILabel *txtPhno;
@property (weak, nonatomic) IBOutlet UILabel *txtIMTU;
@property (weak, nonatomic) IBOutlet UILabel *txtPinless;
@property (weak, nonatomic) IBOutlet UILabel *txtSentMoney;
@property (weak, nonatomic) IBOutlet UIButton *btnstatus;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;

@end
