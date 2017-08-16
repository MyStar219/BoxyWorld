//
//  subAgentCell.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 23/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "subAgentCell.h"

@implementation subAgentCell
@synthesize lblSince,lblEmail,lblPhno,lblCash,lblCommision,lblAgentName,btnEdit;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
        lblSince.textColor=[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0];
    
     lblEmail.textColor=[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0];
     lblPhno.textColor=[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0];
     lblCash.textColor=[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0];
     lblCommision.textColor=[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
