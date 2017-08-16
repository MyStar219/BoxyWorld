//
//  editProfileVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 03/08/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "editProfileVC.h"
#import "config.h"
#import "SWRevealViewController.h"
#import "addCustomerVC.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"

@interface editProfileVC ()
{
    AppDelegate *appDel;
    MBProgressHUD *hud;
    NSString *password;
    NSString *email,*fname,*lname,*address,*phone,*country,*state,*city,*Zip,*businessName;
    NSString *userId,*athenticationKey;
    NSMutableArray *countryArr,*countryCodeArr,*countryPrefix;
    NSMutableArray *stateArr,*statecode;
    
}

@end

@implementation editProfileVC
@synthesize dropcountry,dropState;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    UserSession *editPrfl = [UserAccessSession getUserSession];
    userId =editPrfl.reseller_id;
    athenticationKey =editPrfl.res_user_login_key;
    

    appDel = [AppDelegate instance];
    
    [self loadProfileDetails];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self makeLayout];
    [self barButtonFunction];

}

-(void)makeLayout{
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setTitle:@"Edit User Profile"];
    
    UIView *paddingemail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
     self.textEmail.leftView = paddingemail;
     self.textEmail.leftViewMode = UITextFieldViewModeAlways;
     self.textEmail.delegate=self;
    self.textEmail.layer.borderWidth = 1.3;
    self.textEmail.layer.borderColor = textFieldBorderColor.CGColor;
    self.textEmail.layer.cornerRadius = 5.0f;
   
   
    UIView *paddingFName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.textFname.leftView = paddingFName;
    self.textFname.leftViewMode = UITextFieldViewModeAlways;
    self.textFname.delegate=self;
    self.textFname.layer.borderWidth = 1.3;
    self.textFname.layer.borderColor = textFieldBorderColor.CGColor;
    self.textFname.layer.cornerRadius = 5.0f;
    
    
    UIView *paddingLName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.textLname.leftView = paddingLName;
    self.textLname.leftViewMode = UITextFieldViewModeAlways;
    self.textLname.delegate=self;
    self.textLname.layer.borderWidth = 1.3;
    self.textLname.layer.borderColor = textFieldBorderColor.CGColor;
    self.textLname.layer.cornerRadius = 5.0f;
   
   //*address,*phone,*country,*state,*city,*Zip,*businessName;
    UIView *paddingAdd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.textAddr.leftView = paddingAdd;
    self.textAddr.leftViewMode = UITextFieldViewModeAlways;
    self.textAddr.delegate=self;
    self.textAddr.layer.borderWidth = 1.3;
    self.textAddr.layer.borderColor = textFieldBorderColor.CGColor;
    self.textAddr.layer.cornerRadius = 5.0f;
    
    
    UIView *paddingPhone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.textPhone.leftView = paddingPhone;
    self.textPhone.leftViewMode = UITextFieldViewModeAlways;
    self.textPhone.delegate=self;
    self.textPhone.layer.borderWidth = 1.3;
    self.textPhone.layer.borderColor = textFieldBorderColor.CGColor;
    self.textPhone.layer.cornerRadius = 5.0f;
    
    
    UIView *paddingcountry = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.textCountry.leftView = paddingcountry;
    self.textCountry.leftViewMode = UITextFieldViewModeAlways;
    self.textCountry.delegate=self;
    self.textCountry.layer.borderWidth = 1.3;
    self.textCountry.layer.borderColor = textFieldBorderColor.CGColor;
    self.textCountry.layer.cornerRadius = 5.0f;
    
    UIView *paddingstate = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.textState.leftView = paddingstate;
    self.textState.leftViewMode = UITextFieldViewModeAlways;
    self.textState.delegate=self;
    self.textState.layer.borderWidth = 1.3;
    self.textState.layer.borderColor = textFieldBorderColor.CGColor;
    self.textState.layer.cornerRadius = 5.0f;
    
    
    UIView *paddingCity = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.textCity.leftView = paddingCity;
    self.textCity.leftViewMode = UITextFieldViewModeAlways;
    self.textCity.delegate=self;
    self.textCity.layer.borderWidth = 1.3;
    self.textCity.layer.borderColor = textFieldBorderColor.CGColor;
    self.textCity.layer.cornerRadius = 5.0f;
   
    
    
    UIView *paddingZip = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.textZip.leftView = paddingZip;
    self.textZip.leftViewMode = UITextFieldViewModeAlways;
    self.textZip.delegate=self;
    self.textZip.layer.borderWidth = 1.3;
    self.textZip.layer.borderColor = textFieldBorderColor.CGColor;
    self.textZip.layer.cornerRadius = 5.0f;
   
    
    UIView *paddingBusinessName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.textBusinessName.leftView = paddingBusinessName;
    self.textBusinessName.leftViewMode = UITextFieldViewModeAlways;
    self.textBusinessName.delegate=self;
    self.textBusinessName.layer.borderWidth = 1.3;
    self.textBusinessName.layer.borderColor = textFieldBorderColor.CGColor;
    self.textBusinessName.layer.cornerRadius = 5.0f;
    
    
    //self.btnSubmit.layer.borderWidth = 1.3;
    self.btnSubmit.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnSubmit.layer.cornerRadius = 5.0f;
}

// for nevigation bar
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
    //[self.navigationController popViewControllerAnimated:YES];
    [appDel setBothMenus];
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
    self.scrEditPrfl.contentInset = contentInsets;
    self.scrEditPrfl.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [self.scrEditPrfl setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrEditPrfl.contentInset = contentInsets;
    self.scrEditPrfl.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

//
-(BOOL)textFieldShouldReturn:(UITextField *)textField


{
    //[textField resignFirstResponder];
    NSLog(@"textFieldShouldReturn");
        [textField resignFirstResponder];
    
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateProfile
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  email,@"user_id",
                 password,@"authentication_key",
                self.textFname.text,@"firstname",
                self.textLname.text,@"lastname",
                self.textAddr.text,@"address",
                self.textCity.text,@"city",
                self.textState.text,@"state",
                self.textZip.text,@"zipcode",
                self.textBusinessName.text,@"business_name",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_UPDATEPROFILE];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==******%@",URL);
    NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"edit Profile---%@",json);
        NSString* status = [NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        
        if([status isEqualToString:@"1"]){
            
                    }
        else if([status isEqualToString:@"0"]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:@"Wrong Email/Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            // ViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"loginSB"];
            
            // [[self navigationController] pushViewController:vc animated:YES];
            
            NSLog(@"status:%@",status);
        }
        else{
            NSLog(@"Hello");
        }
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:@"Wrong Email/Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}
//get profile details
-(void)loadProfileDetails
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETPROFILE];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==******%@",URL);
    NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"edit Profile---%@",json);
        NSString* status = [NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        
        if([status isEqualToString:@"1"]){
             NSMutableArray *DataArr = [[NSMutableArray alloc]init];
           
            DataArr = [json objectForKey:@"data"];
            NSLog(@"allDataArr==%@",DataArr);
           
            email = [NSString stringWithFormat:@"%@",[DataArr valueForKey:@"email"]];
            fname = [NSString stringWithFormat:@"%@",[DataArr valueForKey:@"firstname"]];
            lname = [NSString stringWithFormat:@"%@",[DataArr valueForKey:@"lastname"]];
            address= [NSString stringWithFormat:@"%@",[DataArr valueForKey:@"address"]];
            phone = [NSString stringWithFormat:@"%@",[DataArr valueForKey:@"phone"]];
            country = [NSString stringWithFormat:@"%@",[DataArr valueForKey:@"country"]];
            state = [NSString stringWithFormat:@"%@",[DataArr valueForKey:@"state"]];
            city = [NSString stringWithFormat:@"%@",[DataArr valueForKey:@"city"]];
            Zip = [NSString stringWithFormat:@"%@",[DataArr valueForKey:@"zip"]];
            businessName= [NSString stringWithFormat:@"%@",[DataArr valueForKey:@"business_name"]];
            
            self.textEmail.text = [NSString stringWithFormat:@"%@",email];
            self.textFname.text = fname;
            self.textLname.text = lname;
            self.textAddr.text = address;
            self.textCountry.text = country;
            self.textState.text = state;
            self.textCity.text = city;
            self.textZip.text = Zip;
            self.textBusinessName.text = businessName;
            self.textPhone.text = phone;
            
        }
        else if([status isEqualToString:@"0"]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:@"Wrong Email/Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }
        else{
            NSLog(@"Hello");
        }
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:@"Wrong Email/Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}

//************************
 -(void)loadCountry
 {
 hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
 hud.mode = MBProgressHUDModeIndeterminate;
 hud.label.text =@"Please Wait";
 
 [self.view addSubview:hud];
 [self.view setUserInteractionEnabled:NO];
 
 
 NSDictionary *parameters;
 __block NSDictionary* json;
 parameters = [NSDictionary dictionaryWithObjectsAndKeys:
 
 nil];
 NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETCOUNTRY];
 NSLog(@"URL====%@",URL);
 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
 [request setHTTPMethod:@"POST"];
 AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
 manager.responseSerializer = [AFHTTPResponseSerializer serializer];
 NSLog(@"URL==%@",URL);
 // NSLog(@"parameters==%@",parameters);
 
 [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
 
 [hud removeFromSuperview];
 [self.view setUserInteractionEnabled:YES];
 
 NSError *err;
 json = [NSJSONSerialization JSONObjectWithData:responseObject
 options:kNilOptions
 error:&err];
 
 NSMutableArray *allcountryArr = [[NSMutableArray alloc]init];
 allcountryArr = [[json objectForKey:@"data"]objectForKey:@"countries"];
 
 [countryArr removeAllObjects];
 [countryCodeArr removeAllObjects];
 [countryPrefix removeAllObjects];
 for (int i=0; i<[allcountryArr count]; i++) {
 [countryArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryname"]];
 [countryCodeArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"id"]];
 [countryPrefix addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryprefix"]];
 }
 
 //for drop down
 CGFloat phoneX = self.textCountry.frame.origin.x;
 CGFloat phoneY = self.textCountry.frame.origin.y;
 CGFloat phoneWidth = self.textCountry.frame.size.width;
 CGFloat phoneHeight = self.textCountry.frame.size.height;
 
 dropcountry = [[KPDropMenu alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneWidth, phoneHeight)];
 dropcountry.delegate = self;
 dropcountry.items = countryArr;
 //dropcountry.title = @"Select Country";
 dropcountry.titleColor=[UIColor whiteColor];
 dropcountry.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
 dropcountry.titleTextAlignment = NSTextAlignmentLeft;
 dropcountry.DirectionDown = YES;
 [self.scrEditPrfl insertSubview:dropcountry aboveSubview:self.textCountry];
 
 //NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
 
 // NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
 // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
 
 
 }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
 
 
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
 [alert show];
 NSLog(@"error:%@",error.description);
 //return error;
 json = nil;
 
 }];
 }
 
 -(void)loadstate:(NSString *)countrycode
 {
 hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
 hud.mode = MBProgressHUDModeIndeterminate;
 hud.label.text =@"Please Wait";
 
 [self.view addSubview:hud];
 [self.view setUserInteractionEnabled:NO];
 
 
 NSDictionary *parameters;
 __block NSDictionary* json;
 parameters = [NSDictionary dictionaryWithObjectsAndKeys:
 countrycode,@"country_id",
 nil];
 NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETSTATES];
 NSLog(@"URL====%@",URL);
 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
 [request setHTTPMethod:@"POST"];
 AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
 manager.responseSerializer = [AFHTTPResponseSerializer serializer];
 NSLog(@"URLURL--==%@",URL);
 NSLog(@"parameters==%@",parameters);
 
 [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
 
 [hud removeFromSuperview];
 [self.view setUserInteractionEnabled:YES];
 
 NSError *err;
 json = [NSJSONSerialization JSONObjectWithData:responseObject
 options:kNilOptions
 error:&err];
 NSLog(@"stateresponseObject---%@",json);
 // NSString *status= [json objectForKey:@"status"];
 //if([status isEqualToString:@"1"]){
 NSMutableArray *allstateArr = [[NSMutableArray alloc]init];
 allstateArr = [[json objectForKey:@"data"]objectForKey:@"states"];
 //NSLog(@"allstateArr=%@",allstateArr);
 //*stateArr,*statecode;
 [stateArr removeAllObjects];
 [statecode removeAllObjects];
 for (int j=0; j<[allstateArr count]; j++) {
 // [stateArr addObject:[[allstateArr objectAtIndex:j]objectForKey:@"state_name"]];
 //[statecode addObject:[[allstateArr objectAtIndex:j]objectForKey:@"id"]];
 [stateArr addObject:[[allstateArr objectAtIndex:j]objectForKey:@"state_name"]];
 [statecode addObject:[[allstateArr objectAtIndex:j]objectForKey:@"id"]];
 }
 
 //for drop down
 CGFloat stateX = self.textState.frame.origin.x;
 CGFloat stateY = self.textState.frame.origin.y;
 CGFloat stateWidth = self.textState.frame.size.width;
 CGFloat stateHeight = self.textState.frame.size.height;
 
 dropState = [[KPDropMenu alloc] initWithFrame:CGRectMake(stateX, stateY, stateWidth, stateHeight)];
 dropState.delegate = self;
 dropState.items = stateArr;
 dropState.itemsIDs=statecode;
 //dropState.title = @"Select State";
 dropState.titleColor=[UIColor whiteColor];
 dropState.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
 dropState.titleTextAlignment = NSTextAlignmentLeft;
 dropState.DirectionDown = NO;
 [self.scrEditPrfl insertSubview:dropState aboveSubview:self.textState];
 
 
 //NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
 
 // NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
 // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
 
 
 }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
 
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
 [alert show];
 NSLog(@"error:%@",error.description);
 //return error;
 json = nil;
 
 }];
 }
 

 //**********************

- (IBAction)BtnActionSubmit:(id)sender {
    NSLog(@"hello");
   /* NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
 
    //city
    if([city.text isEqualToString:@""] || [numerictest evaluateWithObject:city.text] == YES){
 
 
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"City name shoultnot be Blank" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //address
    else if([address.text isEqualToString:@""] || [self validatePhone:address.text]){
 
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Address shoultnot be Blank" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //zipcode
    else if([zipcode.text isEqualToString:@""] || [numerictest evaluateWithObject:zipcode.text] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper zipcode" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    
    
    //busnessName
    else if([busnessName.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select proper busnessName" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //cPassword
    else if([cPassword.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Confarm your password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //password
    else if([password.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if(![cPassword.text isEqualToString:password.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@" password not match" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    else if([turm isEqualToString:@"false"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Are you aggred with the turms? " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else{
        
        
        [self doRegistation];
        
    }
*/
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
