//
//  summaryFooterCell.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 26/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface summaryFooterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *BtnAgreeAndSent;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UILabel *lblTrmsAndCondition;

@end
