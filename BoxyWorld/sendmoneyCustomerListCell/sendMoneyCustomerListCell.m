//
//  sendMoneyCustomerListCell.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 06/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "sendMoneyCustomerListCell.h"

@implementation sendMoneyCustomerListCell

@synthesize customerImg,customerNamelbl,memberSincelbl,phNolbl,addresslbl,customerSelectBtn;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    customerSelectBtn.layer.cornerRadius=10.0f;
    customerSelectBtn.layer.borderWidth =0.30f;
    customerNamelbl.textColor=[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
