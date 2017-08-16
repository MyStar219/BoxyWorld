//
//  sentMoneyTableViewCell.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 31/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "sentMoneyTableViewCell.h"

@implementation sentMoneyTableViewCell

@synthesize btnSentMoney;
@synthesize btnPinlessRchrg;
@synthesize btnIMTUrchrg;
@synthesize btnAddCash;

@synthesize SM_TotalSale;
@synthesize PR_TotalSale;
@synthesize IMPU_TotalSale;
@synthesize AC_TotalSale;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
