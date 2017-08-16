//
//  addfundsCell1.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 16/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "addfundsCell1.h"

@implementation addfundsCell1

@synthesize cardImg,cardNoLbl,cardTypeLbl,selectBtn,cardtypeTitle;
bool secletToggleBtn;
- (void)awakeFromNib {
    [super awakeFromNib];
    selectBtn.layer.cornerRadius=5.0f;
    selectBtn.layer.borderWidth =0.30f;
    cardtypeTitle.textColor=[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0];
    //selectBtn.layer.borderColor =
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
