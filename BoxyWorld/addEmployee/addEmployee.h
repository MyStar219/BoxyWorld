//
//  addEmployee.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 22/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPDropMenu.h"
@interface addEmployee : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UITextField *activeField;
}

@property (weak, nonatomic) IBOutlet UITextField *txtFName;
@property (weak, nonatomic) IBOutlet UITextField *txtLName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtCCode;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtCountry;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtZipCode;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtCPWD;
@property (weak, nonatomic) IBOutlet UIButton *btnPinlessAccess;
@property (weak, nonatomic) IBOutlet UIButton *btnIMTUaccess;
@property (weak, nonatomic) IBOutlet UIButton *btnSendMoney;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIScrollView *scrvwAddEmp;
@property (strong, nonatomic) IBOutlet UILabel *lblPWD;
@property (strong, nonatomic) IBOutlet UILabel *lblcPWD;

@property (nonatomic, strong) IBOutlet KPDropMenu *dropcountry;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropState;

@property (nonatomic, strong) NSString *editEmployeeId;
@property (nonatomic, strong) NSString *type;
@property (strong, nonatomic) NSMutableArray *employeeDetailsArr;
@end
