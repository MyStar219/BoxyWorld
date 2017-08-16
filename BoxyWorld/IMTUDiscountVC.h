//
//  IMTUDiscountVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 10/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMTUDiscountVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblCountry;
@property (weak, nonatomic) IBOutlet UILabel *lblPhno;
@property (weak, nonatomic) IBOutlet UILabel *lblNetwork;
@property (weak, nonatomic) IBOutlet UILabel *lblActualAmt;
@property (weak, nonatomic) IBOutlet UILabel *lblDiscount;
@property (weak, nonatomic) IBOutlet UILabel *lblCommisn;
@property (weak, nonatomic) IBOutlet UILabel *lblAmtWillDebit;
@property (weak, nonatomic) IBOutlet UILabel *LocalAmtDelivr;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnSUBMIT;

@property (strong, nonatomic) IBOutlet NSString *country;
@property (strong, nonatomic) IBOutlet NSString *phnoe;
@property (strong, nonatomic) IBOutlet NSString *actualAmt;
@property (strong, nonatomic) IBOutlet NSString *network_Id;
@property (strong, nonatomic) IBOutlet NSString *networkMethod;
@property (strong, nonatomic) IBOutlet NSString *country_Id;
@property (strong, nonatomic) IBOutlet NSString *discountIMTU;
@property (strong, nonatomic) IBOutlet NSString *willCollectFrmU;
@property (strong, nonatomic) IBOutlet NSString *network_name;
@property (strong, nonatomic) IBOutlet NSString *phonePre;
@property (strong, nonatomic) IBOutlet NSString *countryCode;



@end
