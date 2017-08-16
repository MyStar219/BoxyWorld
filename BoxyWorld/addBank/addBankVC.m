//
//  addBankVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 17/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "addBankVC.h"
#import "config.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "recipientVC.h"

@interface addBankVC ()<UIScrollViewDelegate,KPDropMenuDelegate,UITextFieldDelegate>
{
     MBProgressHUD *hud;
     NSString *userId,*athenticationKey,*country_Id,*country_preFix,*customer_id,*flag,*amount;
    NSMutableArray *countryArr,*countryCodeArr,*countryPrefix;
     NSMutableArray *allBanksArr,*allBanksIdArr,*allBankName;
    NSString *countryId,*recipientId,*with_contact_info,*bank_Id;
    
    NSString *addBank_res_Fname,*addBank_res_Lname,*addBank_email,*addBank_Phno;
   
}
@end

@implementation addBankVC
@synthesize dropcountry,dropBank;
@synthesize txtFName,txtLName,txtPrePhNo,txtPhno,txtMail,txtCountry,txtBank,txtAccountNo,txtConfrmAccountNo,btnAddBank,scrAddBank,btnActionselectBox;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    countryArr = [[NSMutableArray alloc]init];
    countryCodeArr = [[NSMutableArray alloc]init];
    countryPrefix = [[NSMutableArray alloc]init];
    allBanksArr= [[NSMutableArray alloc]init];
    allBanksIdArr= [[NSMutableArray alloc]init];
    allBankName= [[NSMutableArray alloc]init];
    with_contact_info =@"0";
    
     UserSession *addBank = [UserAccessSession getUserSession];
    addBank_res_Fname =addBank.reseller_firstname;
    addBank_res_Lname =addBank.reseller_lastname;
    addBank_email = addBank.reseller_email;
    addBank_Phno = addBank.customer_phNo;


    [self setTitle:@"Add Bank "];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBarTintColor:navigationBarColor];
    [self makeLayout];
    [self barButtonFunction];
    [self registerForKeyboardNotifications];
    [self loadCountry];
    float appWidth = CGRectGetWidth([UIScreen mainScreen].applicationFrame);
    UIToolbar *accessoryView = [[UIToolbar alloc]
                                initWithFrame:CGRectMake(0, 0, appWidth, 0.1 * appWidth)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]
                              initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                              target:nil
                              action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                             target:self
                             action:@selector(selectDoneButton)];
    accessoryView.items = @[space, done, space];
    self.txtPhno.inputAccessoryView = accessoryView;
    self.txtAccountNo.inputAccessoryView = accessoryView;
    self.txtConfrmAccountNo.inputAccessoryView = accessoryView;
}

- (void)selectDoneButton {
    [self.txtPhno resignFirstResponder];
    [self.txtAccountNo resignFirstResponder];
    [self.txtConfrmAccountNo resignFirstResponder];
    
   
}
    

-(void)makeLayout{
    
    //txtFName,txtLName,txtPrePhNo,txtPhno,txtMail,txtCountry,txtBank,txtAccountNo,txtConfrmAccountNo,selectBox,btnAddBank;
    UIView *paddingtxtFName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtFName.leftView = paddingtxtFName;
    txtFName.leftViewMode = UITextFieldViewModeAlways;
    txtFName.delegate=self;
    self.txtFName.layer.borderWidth = 1.3;
    self.txtFName.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtFName.layer.cornerRadius = 5.0f;
    txtFName.text= addBank_res_Fname;
    
    UIView *paddingtxtLName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtLName.leftView = paddingtxtLName;
    txtLName.leftViewMode = UITextFieldViewModeAlways;
    self.txtLName.layer.borderWidth = 1.3;
    self.txtLName.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtLName.layer.cornerRadius = 5.0f;
    txtLName.delegate=self;
    txtLName.text=addBank_res_Lname;
    
    UIView *paddingtxtMName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtPrePhNo.leftView = paddingtxtMName;
    txtPrePhNo.leftViewMode = UITextFieldViewModeAlways;
    self.txtPrePhNo.layer.borderWidth = 1.3;
    self.txtPrePhNo.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtPrePhNo.layer.cornerRadius = 5.0f;
    txtPrePhNo.delegate=self;
    
    UIView *paddingphno = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtPhno.leftView = paddingphno;
    txtPhno.leftViewMode = UITextFieldViewModeAlways;
    txtPhno.delegate=self;
    self.txtPhno.layer.borderWidth = 1.3;
    self.txtPhno.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtPhno.layer.cornerRadius = 5.0f;
    txtPhno.text=addBank_Phno;
    
    UIView *paddingtxtmail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtMail.leftView = paddingtxtmail;
    txtMail.leftViewMode = UITextFieldViewModeAlways;
    txtMail.delegate=self;
    self.txtMail.layer.borderWidth = 1.3;
    self.txtMail.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtMail.layer.cornerRadius = 5.0f;
    txtMail.text=addBank_email;
    
    
    UIButton *btncountry = [UIButton buttonWithType:UIButtonTypeCustom];
    [btncountry addTarget:self action:@selector(btncountryPressed:) forControlEvents:UIControlEventTouchUpInside];
    btncountry.frame = CGRectMake([UIScreen mainScreen].bounds.size.width -45, 10, 20, 20);
    [btncountry setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtCountry addSubview:btncountry];
    NSLog(@"abc.frame=%f", btncountry.frame.origin.x);
    
    UIView *paddingCountry = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtCountry.leftView = paddingCountry;
    txtCountry.leftViewMode = UITextFieldViewModeAlways;
    txtCountry.delegate=self;
    self.txtCountry.layer.borderWidth = 1.3;
    self.txtCountry.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCountry.layer.cornerRadius = 5.0f;
    NSLog(@"self.txtCountry.frame.size.width=%f",self.txtCountry.frame.size.width);
    
    
    
    
    UIButton *btnBank = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBank addTarget:self action:@selector(btncountryPressed:) forControlEvents:UIControlEventTouchUpInside];
    btnBank.frame = CGRectMake([UIScreen mainScreen].bounds.size.width -45, 10, 20, 20);
    [btnBank setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtBank addSubview:btnBank];
    UIView *paddingtxtcountry = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtBank.leftView = paddingtxtcountry;
    txtBank.leftViewMode = UITextFieldViewModeAlways;
    txtBank.delegate=self;
    self.txtBank.layer.borderWidth = 1.3;
    self.txtBank.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtBank.layer.cornerRadius = 5.0f;
   
    
    
    
    UIView *paddingtxtBank = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtAccountNo.leftView = paddingtxtBank;
    txtAccountNo.leftViewMode = UITextFieldViewModeAlways;
    txtAccountNo.delegate=self;
    self.txtAccountNo.layer.borderWidth = 1.3;
    self.txtAccountNo.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtAccountNo.layer.cornerRadius = 5.0f;
    
    UIView *paddingtxtACNo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtConfrmAccountNo.leftView = paddingtxtACNo;
    txtConfrmAccountNo.leftViewMode = UITextFieldViewModeAlways;
    txtConfrmAccountNo.delegate=self;
    self.txtConfrmAccountNo.layer.borderWidth = 1.3;
    self.txtConfrmAccountNo.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtConfrmAccountNo.layer.cornerRadius = 5.0f;
    
    
    
    self.btnActionselectBox.layer.borderWidth = 1.3;
    self.btnActionselectBox.layer.borderColor = textFieldBorderColor.CGColor;
    self.btnActionselectBox.layer.cornerRadius = 5.0f;
    
    //self.btnSubmit.layer.borderWidth = 1.3;
    self.btnAddBank.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnAddBank.layer.cornerRadius = 5.0f;
    
    /*self.btnSelectBox.layer.borderWidth = 1.3;
    self.btnSelectBox.layer.borderColor =textFieldBorderColor.CGColor;
    self.btnSelectBox.layer.cornerRadius = 5.0f;*/
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    activeField = textField;
    int groupingSize = 4;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init] ;
    NSString *separator = @"-";
    [formatter setGroupingSeparator:separator];
    [formatter setGroupingSize:groupingSize];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setSecondaryGroupingSize:4];
    if (textField == txtFName)
    {
        self.txtFName.layer.borderColor = [UIColor blackColor].CGColor;
    }
    else if (textField == txtLName){
        self.txtFName.layer.borderColor = textFieldBorderColor.CGColor;
        self.txtLName.layer.borderColor = [UIColor blackColor].CGColor;
    }
    else if (textField == txtPhno){
        self.txtLName.layer.borderColor = textFieldBorderColor.CGColor;
        self.txtPhno.layer.borderColor = [UIColor blackColor].CGColor;
    }
    
    else if (textField == txtMail){
        self.txtPhno.layer.borderColor = textFieldBorderColor.CGColor;
        self.txtMail.layer.borderColor = [UIColor blackColor].CGColor;
    }
    else if (textField == txtCountry){
        self.txtMail.layer.borderColor = textFieldBorderColor.CGColor;
        self.txtCountry.layer.borderColor = [UIColor blackColor].CGColor;
    }
    else if (textField == txtBank){
        self.txtCountry.layer.borderColor = textFieldBorderColor.CGColor;
        self.txtBank.layer.borderColor = [UIColor blackColor].CGColor;
    }
    else if (textField == txtAccountNo){
        if(textField.text.length <19){
            if (![string  isEqual: @""] && (textField.text != nil && textField.text.length > 0)) {
                NSString *num = textField.text;
                num = [num stringByReplacingOccurrencesOfString:separator withString:@""];
                NSString *str = [formatter stringFromNumber:[NSNumber numberWithDouble:[num doubleValue]]];
                txtAccountNo.text = str;
               
            }
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:@"no of digits should be 16" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            
        }

    }
    else if (textField == txtConfrmAccountNo){
        
        if(textField.text.length <19){
            if (![string  isEqual: @""] && (textField.text != nil && textField.text.length > 0)) {
                NSString *num = textField.text;
                num = [num stringByReplacingOccurrencesOfString:separator withString:@""];
                NSString *str = [formatter stringFromNumber:[NSNumber numberWithDouble:[num doubleValue]]];
                txtConfrmAccountNo.text = str;
                
            }
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:@"no of digits should be 16" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            
        }

    }
    
    else
    {
        //self.txtLName.layer.borderColor = textFieldBorderColor.CGColor;
        self.txtConfrmAccountNo.layer.borderColor = textFieldBorderColor.CGColor;
        textField.layer.borderColor = textFieldBorderColor.CGColor;
        //[textField resignFirstResponder];
    }

    
    
    
    
    
    
    
    /*if([string length] == 0) {
     groupingSize = ;
     }*/
    
   
        return YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//for navigation bar
-(void) barButtonFunction
{
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"]
                                                                         style:UIBarButtonItemStylePlain target:self action:@selector(popView:)];
   
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:navigationBarColor];
    
}
-(void)popView:(UIBarButtonItem *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadCountry
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
    NSLog(@"addCustomer===%@",addCustomer);
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    customer_id = addCustomer.customer_id;
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETSENDMONEYCOUNTRY];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==%@",URL);
    NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        //NSLog(@"add bank==%@",json);
        NSMutableArray *allcountryArr = [[NSMutableArray alloc]init];
        allcountryArr = [json objectForKey:@"data"];//valueForKey:@"countryname"];
        // NSLog(@"allcountryArr*****%@",allcountryArr);
        [countryArr removeAllObjects];
        [countryCodeArr removeAllObjects];
        [countryPrefix removeAllObjects];
        
        for (int i=0; i<[allcountryArr count]; i++) {
            [countryArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryname"]];
            [countryCodeArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"id"]];
            [countryPrefix addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryprefix"]];
        }
        //NSLog(@"allcountryArr*****%@",allcountryArr);
       // NSLog(@"countryArr*****%@",countryArr);
       // NSLog(@"countryPrefix*****%@",countryPrefix);
        //for drop down
        CGFloat phoneX = self.txtCountry.frame.origin.x;
        CGFloat phoneY = self.txtCountry.frame.origin.y;
        CGFloat phoneWidth = self.txtCountry.frame.size.width;
        CGFloat phoneHeight = self.txtCountry.frame.size.height;
        
        dropcountry = [[KPDropMenu alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneWidth, phoneHeight)];
        dropcountry.delegate = self;
        dropcountry.items = countryArr;
        dropcountry.title = @"Select Country";
        dropcountry.titleColor=[UIColor whiteColor];
        dropcountry.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropcountry.titleTextAlignment = NSTextAlignmentLeft;
        dropcountry.DirectionDown = YES;
        [self.scrAddBank insertSubview:dropcountry aboveSubview:self.txtCountry];
        
        //NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        
        // NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
        // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        // registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // [[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}
-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex{
    
    if(dropMenu == dropcountry){
        
        txtPrePhNo.text=countryPrefix[atIntedex];
        txtCountry.text=countryArr[atIntedex];
        country_Id=countryCodeArr[atIntedex];
        country_preFix = countryPrefix[atIntedex];
        [self loadBankLis];
        //NSLog(@"%@ with TAG : %ld", dropMenu.items[atIntedex], (long)dropMenu.tag);
    }
    else if(dropMenu == dropBank){
        txtBank.text = allBankName[atIntedex];
        bank_Id = allBanksIdArr[atIntedex];
        //txtPrePhNo.text = country_preFix;
    }
    else{
        // NSLog(@"%@", dropMenu.items[atIntedex]);
    }
}

-(void)didShow:(KPDropMenu *)dropMenu{
    NSLog(@"didShow");
}

-(void)didHide:(KPDropMenu *)dropMenu{
    NSLog(@"didHide");
}

//SentMoneyRequest
-(void)addNewBank
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
    NSLog(@"addCustomer===%@",addCustomer);
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    customer_id =addCustomer.customer_id;
    
    recipientId = [[NSUserDefaults standardUserDefaults] objectForKey:@"recipientId"];
    NSLog(@"customer Id=====%@",addCustomer.customer_id);
       NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  customer_id,@"customer_id",
                  recipientId,@"contact_id",
                  txtFName.text,@"contact_fname",
                  txtLName.text ,@"contact_lname",
                  txtMail.text,@"contact_email",
                  txtPhno.text,@"contact_phone",
                  bank_Id ,@"bank_id",
                  txtAccountNo.text ,@"account_no",
                  txtConfrmAccountNo.text ,@"confirm_account_no",
                  with_contact_info,@"with_contact_info",
                  nil];
   
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETUPDATECONTACTBANK];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==%@",URL);
    NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSString  *status = [NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfull" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            recipientVC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"tabRecipient"];
            // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
            [[self navigationController] pushViewController:vc animated:YES];
        }
        else{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            
        }

        NSLog(@"Request==%@",json);
        
            }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        // registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // [[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}
//for bank list
-(void)loadBankLis
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
     NSLog(@"addCustomer===%@",addCustomer);
     userId =addCustomer.reseller_id;
     athenticationKey =addCustomer.res_user_login_key;
     customer_id =addCustomer.customer_id;
     countryId =addCustomer.sentMoney_CountyID;
     amount = [[NSUserDefaults standardUserDefaults] objectForKey:@"Sm_Amount"];
     NSLog(@"customer Id=====%@",addCustomer.customer_id);
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  customer_id,@"customer_id",
                 amount,@"amount",
                  countryId,@"country_id",
                  @"balance",@"pay_option_with",
                  @"1",@"rate_type",
                  @"get_data_by_country",@"type",
                  nil];
    //txtCountry.text =CountryName;
   // txtPrePh.text =prePhno;
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETSENDMONEYREQUEST];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==%@",URL);
    NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"new bank==%@",json);
        allBanksArr = [json objectForKey:@"banks"];
        [allBanksIdArr removeAllObjects];
        [allBankName removeAllObjects];
       
        for (int i=0; i<[allBanksArr count]; i++) {
            [allBanksIdArr addObject:[[allBanksArr objectAtIndex:i]objectForKey:@"bank_id"]];
            [allBankName addObject:[[allBanksArr objectAtIndex:i]objectForKey:@"bank_name"]];
            
            
            // [countryPrefix addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryprefix"]];
        }
        NSLog(@"allBanksArr==%@",allBanksArr);
        NSLog(@"allBankName==%@",allBankName);
        NSLog(@"allBanksIdArr==%@",allBanksIdArr);
        CGFloat phoneX = txtBank.frame.origin.x;
        CGFloat phoneY = txtBank.frame.origin.y;
        CGFloat phoneWidth = self.txtBank.frame.size.width;
        CGFloat phoneHeight = self.txtBank.frame.size.height;
        
        dropBank = [[KPDropMenu alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneWidth, phoneHeight)];
        dropBank.delegate = self;
        dropBank.items = allBankName;
        //dropcountry.title = @"Select Country";
        dropBank.titleColor=[UIColor blackColor];
        dropBank.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropBank.titleTextAlignment = NSTextAlignmentLeft;
        dropBank.DirectionDown = YES;
        [self.scrAddBank insertSubview:dropBank aboveSubview:self.txtBank];
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        // registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // [[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}

//for keypad hide/show
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //NSLog(@"keyboard==%@",aNotification);
    NSDictionary* info = [aNotification userInfo];
    //NSLog(@"text y==%f",activeField.frame.origin.y);
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrAddBank.contentInset = contentInsets;
    scrAddBank.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrAddBank setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrAddBank.contentInset = contentInsets;
    scrAddBank.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    if (textField == txtFName)
    {
        self.txtFName.layer.borderColor = [UIColor blackColor].CGColor;
    }
    else if (textField == txtLName){
         self.txtFName.layer.borderColor = textFieldBorderColor.CGColor;
         self.txtLName.layer.borderColor = [UIColor blackColor].CGColor;
    }
    else if (textField == txtPhno){
        self.txtLName.layer.borderColor = textFieldBorderColor.CGColor;
        self.txtPhno.layer.borderColor = [UIColor blackColor].CGColor;
    }
    
    else if (textField == txtMail){
        self.txtPhno.layer.borderColor = textFieldBorderColor.CGColor;
        self.txtMail.layer.borderColor = [UIColor blackColor].CGColor;
    }
    else if (textField == txtCountry){
        self.txtMail.layer.borderColor = textFieldBorderColor.CGColor;
        self.txtCountry.layer.borderColor = [UIColor blackColor].CGColor;
    }
    else if (textField == txtBank){
        self.txtCountry.layer.borderColor = textFieldBorderColor.CGColor;
        self.txtBank.layer.borderColor = [UIColor blackColor].CGColor;
    }
    else if (textField == txtAccountNo){
        self.txtBank.layer.borderColor = textFieldBorderColor.CGColor;
       self.txtAccountNo.layer.borderColor = [UIColor blackColor].CGColor;
    }
    else if (textField == txtConfrmAccountNo){
        self.txtAccountNo.layer.borderColor = textFieldBorderColor.CGColor;
        self.txtConfrmAccountNo.layer.borderColor = [UIColor blackColor].CGColor;
    }
    
    else
    {
        //self.txtLName.layer.borderColor = textFieldBorderColor.CGColor;
        self.txtConfrmAccountNo.layer.borderColor = textFieldBorderColor.CGColor;
        textField.layer.borderColor = textFieldBorderColor.CGColor;
        //[textField resignFirstResponder];
    }

}

//
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
   //txtFName,txtLName,txtPrePhNo,txtPhno,txtMail,txtCountry,txtBank,txtAccountNo,txtConfrmAccountNo,selectBox,btnAddBank,scrAddBank;
    if (textField == txtFName)
    {
        [txtFName resignFirstResponder];
        [txtLName becomeFirstResponder];
    }
    else if (textField == txtLName){
        [txtLName resignFirstResponder];
        [txtPhno becomeFirstResponder];
    }
    else if (textField == txtPhno){
        [txtPhno resignFirstResponder];
        [txtMail becomeFirstResponder];
    }
    
    else if (textField == txtMail){
        [txtMail resignFirstResponder];
        [txtCountry becomeFirstResponder];
    }
    else if (textField == txtCountry){
        [txtCountry resignFirstResponder];
        [txtBank becomeFirstResponder];
    }
    else if (textField == txtBank){
        [txtBank resignFirstResponder];
        [txtAccountNo becomeFirstResponder];
    }
    else if (textField == txtAccountNo){
        [txtAccountNo resignFirstResponder];
        [txtConfrmAccountNo becomeFirstResponder];
    }
    else if (textField == txtConfrmAccountNo){
        [txtConfrmAccountNo resignFirstResponder];
        //[txtConfrmACNo becomeFirstResponder];
    }
    
    else
    {
        [textField resignFirstResponder];
    }
    
    return YES;
}
- (IBAction)btnActionSelectBox:(id)sender {
    if([with_contact_info isEqualToString:@"0"])
    {
        with_contact_info =@"1";
        // btnActionselectBox.backgroundColor = [UIColor redColor];
         //[btnActionselectBox setImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
         [btnActionselectBox setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
    }
    else{
        with_contact_info =@"0";
          //btnActionselectBox.backgroundim = [UIColor whiteColor];
       // [btnActionselectBox setImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
         [btnActionselectBox setBackgroundImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
    }
}
- (IBAction)btnAddBankAction:(id)sender {
    
    //txtFName,txtLName,txtPrePhNo,txtPhno,txtMail,txtCountry,txtBank,txtAccountNo,txtConfrmAccountNo,btnAddBank,scrAddBank,btnActionselectBox
    
    
    //NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    //NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
    //BOOL phoneValidates = [phoneTest evaluateWithObject:phoneNumber];
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    //firstName
    if([txtFName.text isEqualToString:@""] || [numerictest evaluateWithObject:txtFName.text] == YES){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter first Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //lastname
    else if([txtLName.text isEqualToString:@""] || [numerictest evaluateWithObject:txtLName.text] == YES){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter last Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //phno
    else if([txtPhno.text isEqualToString:@""]|| [numerictest evaluateWithObject:txtPhno.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Phone Number should not be blank and must be number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
  //email
    else if([txtMail.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    
    else if ([emailTest evaluateWithObject:txtMail.text] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    
   
        //ac no
    else if([txtAccountNo.text isEqualToString:@""] || [numerictest evaluateWithObject:txtAccountNo.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter account number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if([txtConfrmAccountNo.text isEqualToString:@""] || [numerictest evaluateWithObject:txtConfrmAccountNo.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please reenter account number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if(![txtAccountNo.text isEqualToString:[NSString stringWithFormat:@"%@",txtConfrmAccountNo.text]] ){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Account no does not match" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else{
        [self addNewBank];
    }

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
