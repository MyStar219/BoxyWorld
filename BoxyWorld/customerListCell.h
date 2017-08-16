//
//  customerListCell.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 21/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customerListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *customerImg;
@property (weak, nonatomic) IBOutlet UILabel *customerNamelbl;
@property (weak, nonatomic) IBOutlet UILabel *memberSincelbl;
@property (weak, nonatomic) IBOutlet UILabel *phNolbl;
@property (weak, nonatomic) IBOutlet UILabel *addresslbl;
@property (weak, nonatomic) IBOutlet UIButton *customerSelectBtn;

@end
