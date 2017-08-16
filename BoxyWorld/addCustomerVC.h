//
//  addCustomerVCViewController.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 21/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPDropMenu.h"

@interface addCustomerVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
     IBOutlet UITextField *activeField;
    UIImagePickerController *ipc;
    UIPopoverController *popover;
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
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectImg;
@property (weak, nonatomic) IBOutlet UIScrollView *scrView;
@property (weak, nonatomic) IBOutlet UITextField *txtcity;

@property (nonatomic, strong) IBOutlet KPDropMenu *dropcountry;
@property (nonatomic, strong) IBOutlet KPDropMenu *dropState;

@property (weak, nonatomic) IBOutlet UIButton *btnGallery;
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;
@property (weak, nonatomic) IBOutlet UIImageView *ivPickedImage;
@property (nonatomic, strong) NSString *editCustomerId;
@property (nonatomic, strong) NSString *type;
-(NSString *)imageToNSString;

@property (strong, nonatomic) NSMutableArray *customerDetailsArr;
@end
