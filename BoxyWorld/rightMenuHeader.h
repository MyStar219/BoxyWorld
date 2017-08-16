//
//  rightMenuHeader.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 15/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rightMenuHeader : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *prflImge;
@property (weak, nonatomic) IBOutlet UILabel *prflName;
@property (weak, nonatomic) IBOutlet UIImageView *editImg;
@property (strong, nonatomic) IBOutlet UIButton *btnEditPrfl;

@end
