//
//  EmployeeListCell.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 07/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "EmployeeListCell.h"

@implementation EmployeeListCell
@synthesize txtname,txtSince,txtEmail,txtPhno,txtIMTU,txtPinless,txtSentMoney;



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
