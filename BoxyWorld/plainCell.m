//
//  plainCell.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 28/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "plainCell.h"

@implementation plainCell
@synthesize lblKey,lblValue;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
