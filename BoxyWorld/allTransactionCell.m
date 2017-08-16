//
//  allTransactionCell.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 24/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "allTransactionCell.h"

@implementation allTransactionCell
@synthesize lblKey,lblVal;



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    lblKey.layer.borderWidth =0.30f;
    //lblKey.textColor=[UIColor redColor];
    
    lblVal.layer.borderWidth =0.30f;
    lblVal.textColor=[UIColor grayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
