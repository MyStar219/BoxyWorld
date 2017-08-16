//
//  pinlessRechervC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 04/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pinlessRechervC : UIViewController
{
 IBOutlet UITextField *activeField;
}
@property (weak, nonatomic) IBOutlet UITextField *fldCustomerph;
@property (weak, nonatomic) IBOutlet UITextField *fldrechargeAmt;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIScrollView *scrPinless;
@property (weak, nonatomic) IBOutlet UILabel *lblMsgBox;
@property (weak, nonatomic) IBOutlet UITextField *fldFName;
@property (weak, nonatomic) IBOutlet UITextField *fldLName;
@property (weak, nonatomic) IBOutlet UITextField *fldEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblFName;
@property (weak, nonatomic) IBOutlet UILabel *lblLName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;


@end
