//
//  subAgentCell.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 23/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface subAgentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblSince;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblPhno;
@property (weak, nonatomic) IBOutlet UILabel *lblCash;
@property (weak, nonatomic) IBOutlet UILabel *lblCommision;
@property (weak, nonatomic) IBOutlet UILabel *lblAgentName;
@property (strong, nonatomic) IBOutlet UIButton *btnEdit;

@property (weak, nonatomic) IBOutlet UIImageView *imgdelete;

@end
