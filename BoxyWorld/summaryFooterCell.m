//
//  summaryFooterCell.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 26/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "summaryFooterCell.h"

@implementation summaryFooterCell
@synthesize BtnAgreeAndSent,btnBack,btnCancel,lblTrmsAndCondition;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //[self makeLayout];
}

-(void)makeLayout{
    
    self.btnBack.layer.borderWidth = 1.0;
    self.btnBack.layer.borderColor = [UIColor greenColor].CGColor;
    self.btnBack.layer.cornerRadius = 6.0f;
    
    self.btnCancel.layer.borderWidth = 1.0;
    self.btnCancel.layer.borderColor = [UIColor redColor].CGColor;
    self.btnCancel.layer.cornerRadius = 6.0f;
    
    self.BtnAgreeAndSent.layer.borderWidth = 1.0;
    //self.BtnAgreeAndSent.layer.borderColor = [UIColor blueColor].CGColor;
    self.BtnAgreeAndSent.layer.cornerRadius = 6.0f;
    
    
    }


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
