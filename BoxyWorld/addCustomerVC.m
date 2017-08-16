//
//  addCustomerVCViewController.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 21/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//
#import "config.h"
#import "SWRevealViewController.h"
#import "addCustomerVC.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "ViewController.h"
#import "customerListVC.h"

@interface addCustomerVC ()
{
     AppDelegate *appDel;
    NSMutableArray *countryArr,*countryCodeArr,*countryPrefix;
    NSMutableArray *stateArr,*statecode;
    NSString *country_Id;
    NSString *state_Id;
    NSString *userId ;
    NSString *athenticationKey;
     BOOL _isThumbSelected;
     UIImage* _imgThumb;
    NSString *ImgStr;
    NSString *prePhone;
    MBProgressHUD *hud;
    NSString *countrycode,*countryName;
}
@end

@implementation addCustomerVC
@synthesize dropcountry,dropState,scrView,txtFName,txtLName,txtEmail,txtCCode,txtPhone,txtCountry,txtState,txtAddress,txtZipCode,btnSubmit,txtcity;
@synthesize btnGallery,btnCamera,ivPickedImage;
@synthesize editCustomerId,type;
@synthesize customerDetailsArr;


-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:YES];
    stateArr = [[NSMutableArray alloc]init];
    statecode = [[NSMutableArray alloc]init];
    if([type isEqualToString:@"edit"]){
        NSLog(@"customerDetailsArr==%@",customerDetailsArr);
        countrycode= [NSString stringWithFormat:@"%@",[customerDetailsArr valueForKey:@"country"]];
        editCustomerId = [NSString stringWithFormat:@"%@",[customerDetailsArr valueForKey:@"customerId"]];
        
        [self getCountryName];
        }
    else{
        countryArr = [[NSMutableArray alloc]init];
        countryCodeArr = [[NSMutableArray alloc]init];
        countryPrefix = [[NSMutableArray alloc]init];
        
        [self loadCountry];
    }
    
    appDel = [AppDelegate instance];
    [self makeLayout];
    [self barButtonFunction];
 }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
      [self registerForKeyboardNotifications];
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
    self.txtPhone.inputAccessoryView = accessoryView;
    self.txtZipCode.inputAccessoryView = accessoryView;
    if([type isEqualToString:@"edit"]){
       [self showediedata];
        
    }
  }
-(void)makeLayout{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    if([type isEqualToString:@"edit"]){
        [self setTitle:@"Edit Customer"];
        //self.btnSubmit.layer.cornerRadius = 5.0f;
        [self.btnSubmit setTitle: @"UPDATE" forState: UIControlStateNormal];
    }
    else{
    [self setTitle:@"Add Customer"];
    }
    UIView *paddingtxtFName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtFName.leftView = paddingtxtFName;
    txtFName.leftViewMode = UITextFieldViewModeAlways;
    txtFName.delegate=self;
    self.txtFName.layer.borderWidth = 1.3;
    self.txtFName.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtFName.layer.cornerRadius = 5.0f;
    
    UIView *paddingtxtLName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtLName.leftView = paddingtxtLName;
    txtLName.leftViewMode = UITextFieldViewModeAlways;
    txtLName.delegate=self;
    self.txtLName.layer.borderWidth = 1.3;
    self.txtLName.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtLName.layer.cornerRadius = 5.0f;
    
    UIView *paddingtxtEmail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtEmail.leftView = paddingtxtEmail;
    txtEmail.leftViewMode = UITextFieldViewModeAlways;
    txtEmail.delegate=self;
    self.txtEmail.layer.borderWidth = 1.3;
    self.txtEmail.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtEmail.layer.cornerRadius = 5.0f;
    
    UIView *paddingtxtCCode = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtCCode.leftView = paddingtxtCCode;
    txtCCode.leftViewMode = UITextFieldViewModeAlways;
    txtCCode.delegate=self;
    self.txtCCode.layer.borderWidth = 1.3;
    self.txtCCode.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCCode.layer.cornerRadius = 5.0f;
    
    UIView *paddingtxtPhone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtPhone.leftView = paddingtxtPhone;
    txtPhone.leftViewMode = UITextFieldViewModeAlways;
    txtPhone.delegate=self;
    self.txtPhone.layer.borderWidth = 1.3;
    self.txtPhone.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtPhone.layer.cornerRadius = 5.0f;
    
    UIView *paddingtxtAddress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtAddress.leftView = paddingtxtAddress;
    txtAddress.leftViewMode = UITextFieldViewModeAlways;
    txtAddress.delegate=self;
    self.txtAddress.layer.borderWidth = 1.3;
    self.txtAddress.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtAddress.layer.cornerRadius = 5.0f;
    
    UIView *paddingtxtCountry = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtCountry.leftView = paddingtxtCountry;
    txtCountry.leftViewMode = UITextFieldViewModeAlways;
    txtCountry.delegate=self;
    self.txtCountry.layer.borderWidth = 1.3;
    self.txtCountry.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCountry.layer.cornerRadius = 5.0f;
    UIButton *btnCountry = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCountry addTarget:self action:@selector(btnCountryPressed:) forControlEvents:UIControlEventTouchUpInside];
    btnCountry.frame = CGRectMake(self.txtCountry.bounds.size.width -30, 10, 20, 20);
    [btnCountry setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtCountry addSubview:btnCountry];
    
    UIView *paddingtxtState = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtState.leftView = paddingtxtState;
    txtState.leftViewMode = UITextFieldViewModeAlways;
    txtState.delegate=self;
    self.txtState.layer.borderWidth = 1.3;
    self.txtState.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtState.layer.cornerRadius = 5.0f;
    UIButton *btnState = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnState addTarget:self action:@selector(btnStatePressed:) forControlEvents:UIControlEventTouchUpInside];
    btnState.frame = CGRectMake(self.txtState.bounds.size.width -80, 10, 20, 20);
    [btnState setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtState addSubview:btnState];
    
    UIView *paddingtxtcity = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtcity.leftView = paddingtxtcity;
    txtcity.leftViewMode = UITextFieldViewModeAlways;
    txtcity.delegate=self;
    self.txtcity.layer.borderWidth = 1.3;
    self.txtcity.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtcity.layer.cornerRadius = 5.0f;
    
    UIView *paddingtxtZipCode = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtZipCode.leftView = paddingtxtZipCode;
    txtZipCode.leftViewMode = UITextFieldViewModeAlways;
    txtZipCode.delegate=self;
    self.txtZipCode.layer.borderWidth = 1.3;
    self.txtZipCode.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtZipCode.layer.cornerRadius = 5.0f;
    
   
    self.btnSelectImg.layer.borderWidth = 1.3;
    self.btnSelectImg.layer.borderColor = textFieldBorderColor.CGColor;
    self.btnSelectImg.layer.cornerRadius = 5.0f;
   
    //self.btnSubmit.layer.borderWidth = 1.3;
    self.btnSubmit.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnSubmit.layer.cornerRadius = 5.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// for nevigation bar
-(void) barButtonFunction
{
    
   
    
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"]
                                                                         style:UIBarButtonItemStylePlain target:self action:@selector(popView:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    /*
     SWRevealViewController *revealController = [self revealViewController];
     
     [self.view addGestureRecognizer:revealController.panGestureRecognizer];
     
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"rightMenu"]
                                                                              style:UIBarButtonItemStylePlain target:revealController action:@selector(rightRevealToggle:)];
    
    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
   
    
    UIImage * logoInNavigationBar = [UIImage imageNamed:@"logo"];
    UIImageView * logoView = [[UIImageView alloc] init];
    [logoView setImage:logoInNavigationBar];
    //self.navigationController.navigationItem.titleView = logoView;
    
    UIImage* logoImage = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
     */
    
    [self.navigationController.navigationBar setBarTintColor:navigationBarColor];
    
}
-(void)popView:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectDoneButton {
    [self.txtPhone resignFirstResponder];
     [self.txtZipCode resignFirstResponder];
}

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
        CGFloat phoneX = self.txtCountry.frame.origin.x;
        CGFloat phoneY = self.txtCountry.frame.origin.y;
        CGFloat phoneWidth = self.txtCountry.frame.size.width;
        CGFloat phoneHeight = self.txtCountry.frame.size.height;
        
        dropcountry = [[KPDropMenu alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneWidth, phoneHeight)];
        dropcountry.delegate = self;
        dropcountry.items = countryArr;
        //dropcountry.title = @"Select Country";
        dropcountry.titleColor=[UIColor whiteColor];
        dropcountry.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropcountry.titleTextAlignment = NSTextAlignmentLeft;
        dropcountry.DirectionDown = NO;
        [self.scrView insertSubview:dropcountry aboveSubview:self.txtCountry];
        
        //NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        
        // NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
        // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
       // registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        //[[self navigationController] pushViewController:vc animated:YES];
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
        CGFloat stateX = self.txtState.frame.origin.x;
        CGFloat stateY = self.txtState.frame.origin.y;
        CGFloat stateWidth = self.txtState.frame.size.width;
        CGFloat stateHeight = self.txtState.frame.size.height;
        
        dropState = [[KPDropMenu alloc] initWithFrame:CGRectMake(stateX, stateY, stateWidth, stateHeight)];
        dropState.delegate = self;
        dropState.items = stateArr;
        dropState.itemsIDs=statecode;
        //dropState.title = @"Select State";
        dropState.titleColor=[UIColor whiteColor];
        dropState.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropState.titleTextAlignment = NSTextAlignmentLeft;
        dropState.DirectionDown = NO;
        [self.scrView insertSubview:dropState aboveSubview:self.txtState];
        
        
        //NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        
        // NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
        // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
       
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
        
        prePhone=countryPrefix[atIntedex];
        self.txtCountry.text=countryArr[atIntedex];
        country_Id=countryCodeArr[atIntedex];
        [self loadstate:countryCodeArr[atIntedex]];
        //NSLog(@"%@ with TAG : %ld", dropMenu.items[atIntedex], (long)dropMenu.tag);
    }
    else if(dropMenu == dropState){
       
        NSLog(@"value==%@",self.txtState.text);
        state_Id = statecode[atIntedex];
        NSString *tempState = stateArr[atIntedex];
        txtState.text = tempState;
        
        if([type isEqualToString:@"edit"]){
            self.txtCCode.text = [NSString stringWithFormat:@"%@",[customerDetailsArr valueForKey:@"Ccountry"]];
        }
        else{
            self.txtCCode.text = prePhone;
        }
    }
    else{
        NSString *tempState = stateArr[atIntedex];
        txtState.text = tempState;
        state_Id = statecode[atIntedex];
        // NSLog(@"%@", dropMenu.items[atIntedex]);
    }
}

-(void)didShow:(KPDropMenu *)dropMenu{
    NSLog(@"didShow");
}

-(void)didHide:(KPDropMenu *)dropMenu{
    NSLog(@"didHide");
}

-(void)getCountryName
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
        //NSString *status= [json objectForKey:@"status"];
        //if([status isEqualToString:@"1"]){
        
        
        NSMutableArray *allcountryArr = [[NSMutableArray alloc]init];
        allcountryArr = [[json objectForKey:@"data"]objectForKey:@"countries"];
        
        //NSLog(@"allcountryArr==%@",allcountryArr);
        
        for (int i=0; i<[allcountryArr count]; i++) {
            NSString *cname = [NSString stringWithFormat:@"%@",[[allcountryArr objectAtIndex:i]objectForKey:@"id"]];
            if([cname isEqualToString:[NSString stringWithFormat:@"%@",countrycode]]){
                countryName = [[allcountryArr objectAtIndex:i]objectForKey:@"countryname"];
                
            }
        }
       txtCountry.text = [NSString stringWithFormat:@"%@",countryName];
        [self loadstate:[NSString stringWithFormat:@"%@",countrycode]];
        
        
        // }
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        
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
    scrView.contentInset = contentInsets;
    scrView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrView.contentInset = contentInsets;
    scrView.scrollIndicatorInsets = contentInsets;
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
    /*
    if (textField == self.txtFName)
    {
        [self.txtFName resignFirstResponder];
        [self.txtLName becomeFirstResponder];
    }
    else if (textField == self.txtLName){
        [self.txtLName resignFirstResponder];
        [self.txtEmail becomeFirstResponder];
    }
    else if (textField == self.txtEmail){
        [self.txtEmail resignFirstResponder];
        [self.txtPhone becomeFirstResponder];
    }
    else if (textField == self.txtPhone){
        [self.txtPhone resignFirstResponder];
        [self.txtAddress becomeFirstResponder];
    }
     else if (textField == self.txtAddress){
     
     
     [self.txtAddress resignFirstResponder];
      [self.txtZipCode becomeFirstResponder];
     
     }
     else if (textField == self.txtZipCode){
         
         
         [self.txtZipCode resignFirstResponder];
         [self.txtcity becomeFirstResponder];
         
     }
     else if (textField == self.txtcity){
         
         
         [self.txtcity resignFirstResponder];
         //[self.self.txtcity becomeFirstResponder];
         
     }
  
    else
    {
     */
        [textField resignFirstResponder];
   // }
    
    return YES;
}
- (IBAction)addcustomerActionBtn:(id)sender {
    
    //NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    //NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
    //BOOL phoneValidates = [phoneTest evaluateWithObject:phoneNumber];
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    //firstName
    if([self.txtFName.text isEqualToString:@""] || [numerictest evaluateWithObject:self.txtFName.text] == YES){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter first Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //lastname
    else if([self.txtLName.text isEqualToString:@""] || [numerictest evaluateWithObject:self.txtLName.text] == YES){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter last Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //email
    else if([self.txtEmail.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    
    else if ([emailTest evaluateWithObject:self.txtEmail.text] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //Phone Number
    else if([self.txtPhone.text isEqualToString:@""]/*|| [numerictest evaluateWithObject:self.txtPhone.text] == NO*/){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Phone Number should not be blank and must be number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //country
    else if([self.txtCountry.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select proper country" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //state
    else if([self.txtState.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Select proper State" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //Address
    else if([self.txtZipCode.text isEqualToString:@""] || [numerictest evaluateWithObject:self.txtZipCode.text] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper zipcode" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    //zipcode
    else if([self.txtZipCode.text isEqualToString:@""] || [numerictest evaluateWithObject:self.txtZipCode.text] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper zipcode" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    //city
    else if([self.txtcity.text isEqualToString:@""] || [numerictest evaluateWithObject:self.txtcity.text] == YES){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"City name shoultnot be Blank" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    //for image
    else if([ImgStr isEqualToString:@""]){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"select image Please" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }


    else{
        if([type isEqualToString:@"edit"]){
            [self SubmitEditCustomer ];
            
                   }
        else{
             [self SubmitAddCustomer];
        }

       
    }

}
//SubmitAddCustomerAPI
-(void)SubmitAddCustomer
{
    NSLog(@"SubmitAddCustomer");
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    UserSession *addCustomer = [UserAccessSession getUserSession];
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    NSString *phno=[NSString stringWithFormat:@"%@%@",txtCCode.text,txtPhone.text];
     NSString *image= [NSString stringWithFormat:@"data:image/jpeg;base64;%@",ImgStr];
    NSLog(@"image= %@",image);
    
    /*
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
     *country_Id;
     NSString *state_Id;
     */
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                   userId,@"user_id",
                   athenticationKey,@"authentication_key",
                   txtFName.text,@"firstname",
                   txtLName.text,@"lastname",
                   txtEmail.text,@"email",
                   country_Id,@"country",
                   phno,@"phone",
                   state_Id,@"state",
                   txtAddress.text,@"address",
                   txtcity.text,@"city",
                   txtZipCode.text,@"zipcode",
                   image,@"govtidpath",
                 // image/*@""*/,@"govtidpath",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_ADDCUSTOMER];
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
        NSLog(@"get_userDetailsByPhno==%@",json);
        if([status isEqualToString:@"1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"successfull" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            customerListVC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"customerList"];
            // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
            [[self navigationController] pushViewController:vc animated:YES];

            
                }
        else{
            if([[json objectForKey:@"msg"] isEqualToString:@"Authentication key is invalid."])
            {
                [UserAccessSession clearAllSession];
                NSLog(@"clickedButtonAtIndex");
                SWRevealViewController *revealController = self.revealViewController;
                NSString * storyboardName = @"Main";
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
                ViewController * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"loginSB"];
                // [revealController setFrontViewPosition:vc1 animated:YES];
                UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
                [revealController pushFrontViewController:frontNavigationController animated:YES];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            
        }
        
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // [[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}

//submit edit option api
-(void)SubmitEditCustomer
{
    NSLog(@"SubmiteditCustomer");
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    UserSession *addCustomer = [UserAccessSession getUserSession];
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    NSString *phno=[NSString stringWithFormat:@"%@%@",txtCCode.text,txtPhone.text];
    NSString *image= [NSString stringWithFormat:@"data:image/jpeg;base64;%@",ImgStr];
    NSLog(@"image= %@",image);
    
       NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  editCustomerId,@"customer_id",
                  txtFName.text,@"firstname",
                  txtLName.text,@"lastname",
                  state_Id,@"state",
                  txtAddress.text,@"address",
                  txtcity.text,@"city",
                  txtZipCode.text,@"zipcode",
                  image,@"govtidpath",
                  // image/*@""*/,@"govtidpath",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_UPDATECUSTOMER];
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
        NSLog(@"get_userDetailsByPhno==%@",json);
        if([status isEqualToString:@"1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"successfull" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            customerListVC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"customerList"];
            // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
            [[self navigationController] pushViewController:vc animated:YES];
            
            
        }
        else{
            if([[json objectForKey:@"msg"] isEqualToString:@"Authentication key is invalid."])
            {
                [UserAccessSession clearAllSession];
                NSLog(@"clickedButtonAtIndex");
                SWRevealViewController *revealController = self.revealViewController;
                NSString * storyboardName = @"Main";
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
                ViewController * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"loginSB"];
                // [revealController setFrontViewPosition:vc1 animated:YES];
                UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
                [revealController pushFrontViewController:frontNavigationController animated:YES];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            
        }
        
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // [[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}


//for image upload

- (IBAction)btnGalleryClicked:(id)sender
{
    ipc= [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        [self presentViewController:ipc animated:YES completion:nil];
    else
    {
        popover=[[UIPopoverController alloc]initWithContentViewController:ipc];
        [popover presentPopoverFromRect:btnGallery.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

- (IBAction)btnCameraClicked:(id)sender
{
    ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ipc animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No Camera Available." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
}

#pragma mark - ImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToUse;
    //    ALAssetsLibrary* libraryFolder = [[ALAssetsLibrary alloc] init];
    
    // Handle a still image picked from a photo album
    
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        
        
        originalImage = (UIImage *)[info objectForKey: UIImagePickerControllerOriginalImage];
        
        NSLog(@"originalImage =%@",originalImage);
        
        imageToUse = originalImage;
        ImgStr=[self encodeToBase64String:originalImage];
        //NSLog(@"_imgThumb==%@",ImgStr);
        
         //Do something with imageToUse
        //if(_isThumbSelected) {
            //_imgThumb = imageToUse;
        
            
        //}
        
        
        
    }
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
// convert image to base 64 string

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
/*-(NSString *)imageToNSString:(UIImage *)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    return [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
*/


/*-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    } else {
        [popover dismissPopoverAnimated:YES];
    }
    ivPickedImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
}*/

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) {
        //[self uploadFileToServer:@”test.png”];
        //return;
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.allowsEditing=NO;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    } else if (buttonIndex == 0) {
        
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing=NO;
            [self presentViewController:picker animated:YES completion:nil];
        }
        else {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Can not find Camera Device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    
}
-(void)displayImage:(UIImageView*) imgView image:(UIImage*)img{
    CGSize size = imgView.frame.size;
    
    if([MGUtilities isRetinaDisplay]) {
        size.height *= 2;
        size.width *= 2;
    }
    NSLog(@"hello");
    //UIImage* croppedImage = [img imageByScalingAndCroppingForSize:size];
    //imgView.image = croppedImage;
}
-(NSData *)resizeImage:(UIImage*)img compression:(CGFloat)compressionSize{
    
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 250*1024;
    UIImage *images = [UIImage imageWithData:UIImageJPEGRepresentation(img, compressionSize)];
    NSData *imageData = UIImageJPEGRepresentation(img, compressionSize);
    
    while ([imageData length] > maxFileSize && compressionSize > maxCompression)
    {
        compressionSize -= 0.1;
        images = [UIImage imageWithData:UIImageJPEGRepresentation(img, compressionSize)];
        imageData = UIImageJPEGRepresentation(img, compressionSize);
    }
    //NSLog(@"imageData-%@",imageData);
    NSLog(@"image size--%lu",(unsigned long)[imageData length]);
    return imageData;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)SelectImgAction:(id)sender {
      _isThumbSelected = YES;
    UIActionSheet* popupQuery = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take New Picture", @"Choose From Library", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [popupQuery showInView:self.view];
}
- (void)showediedata {
    //dropcountry,dropState,scrView,txtFName,txtLName,txtEmail,txtCCode,txtPhone,txtCountry,txtState,txtAddress,txtZipCode,btnSubmit,txtcity
    NSLog(@"Ccountry==%@",[NSString stringWithFormat:@"%@",[customerDetailsArr valueForKey:@"Ccountry"]]);
    txtFName.text =[NSString stringWithFormat:@"%@",[customerDetailsArr valueForKey:@"fname"]];
    txtLName.text =[NSString stringWithFormat:@"%@",[customerDetailsArr valueForKey:@"lastname"]];
    txtEmail.text =[NSString stringWithFormat:@"%@",[customerDetailsArr valueForKey:@"email"]];
   // txtCCode.text =[NSString stringWithFormat:@"%@",[customerDetailsArr valueForKey:@"Ccountry"]];
    txtPhone.text =[NSString stringWithFormat:@"%@",[customerDetailsArr valueForKey:@"phNo"]];;
    txtAddress.text =[NSString stringWithFormat:@"%@",[customerDetailsArr valueForKey:@"address"]];
    txtZipCode.text =[NSString stringWithFormat:@"%@",[customerDetailsArr valueForKey:@"zip"]];
    txtcity.text =[NSString stringWithFormat:@"%@",[customerDetailsArr valueForKey:@"city"]];
    
    
    txtEmail.userInteractionEnabled = NO;
    txtCCode.userInteractionEnabled = NO;
    txtCountry.userInteractionEnabled = NO;
    txtPhone.userInteractionEnabled = NO;
    
    txtEmail.backgroundColor = [UIColor colorWithRed:0.94 green:0.97 blue:1.00 alpha:1.0];
    txtCCode.backgroundColor = [UIColor colorWithRed:0.94 green:0.97 blue:1.00 alpha:1.0];
    txtCountry.backgroundColor =[UIColor colorWithRed:0.94 green:0.97 blue:1.00 alpha:1.0];
    txtPhone.backgroundColor = [UIColor colorWithRed:0.94 green:0.97 blue:1.00 alpha:1.0];
 }
@end
