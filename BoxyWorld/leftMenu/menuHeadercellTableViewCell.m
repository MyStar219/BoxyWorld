//
//  menuHeadercellTableViewCell.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 14/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "menuHeadercellTableViewCell.h"
#import "UserAccessSession.h"

@implementation menuHeadercellTableViewCell
@synthesize profileImg,namelbl,mailLbl;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
