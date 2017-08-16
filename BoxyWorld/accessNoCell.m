//
//  accessNoCell.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 13/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "accessNoCell.h"

@implementation accessNoCell
@synthesize imgFlag,lblTitle,btnSelect;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
- (IBAction)btnselectAction:(id)sender {
    [btnSelect setBackgroundColor:[UIColor redColor]];
}
*/
@end
