//
//  sentMoneyCustomerDetails.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 06/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sentMoneyCustomerDetails : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblZipCode;
@property (weak, nonatomic) IBOutlet UILabel *lblState;
@property (weak, nonatomic) IBOutlet UILabel *lblCountry;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UIImageView *imgGovernment;
@property (weak, nonatomic) IBOutlet UIButton *btnSendMoney;

@property (strong, nonatomic) NSMutableArray *customerListArr;
@property (nonatomic, strong) UITabBarController *tabController;
//@property (nonatomic, strong) UIpushvie *tabController;
@end
