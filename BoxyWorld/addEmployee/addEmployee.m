//
//  addEmployee.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 22/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "addEmployee.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "ViewController.h"
#import "EmployeeListVC.h"
@interface addEmployee ()<UIScrollViewDelegate,KPDropMenuDelegate>
{
    AppDelegate *appDel;
    NSMutableArray *countryArr,*countryCodeArr,*countryPrefix;
    NSMutableArray *stateArr,*statecode;
    NSString *country_Id;
    NSString *state_Id;
    NSString *userId ;
    NSString *athenticationKey;
     NSString *prephno;
    //BOOL _isThumbSelected;
    //UIImage* _imgThumb;
    //NSString *ImgStr;
    NSString *pinless;
    NSString *imut ;
    NSString *sentMoney;
    
   
    MBProgressHUD *hud;
    NSString *countrycode,*editEmployeeid,*countryName;
    NSString *sentMoney1,*imut1,*pinless1;
}
@end

@implementation addEmployee
@synthesize scrvwAddEmp,txtFName,txtLName,txtEmail,txtCCode,txtPhone,txtCountry,txtState,txtAddress,txtZipCode,txtCity,txtPwd,txtCPWD,btnPinlessAccess,btnIMTUaccess,btnSendMoney;
@synthesize dropcountry,dropState;
@synthesize editEmployeeId,type;
@synthesize employeeDetailsArr;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    stateArr = [[NSMutableArray alloc]init];
    statecode = [[NSMutableArray alloc]init];
    if([type isEqualToString:@"edit"]){
        NSLog(@"employeeDetailsArr==%@",employeeDetailsArr);
        countrycode = [NSString stringWithFormat:@"%@",[employeeDetailsArr valueForKey:@"countryId"]];
        editEmployeeid = [NSString stringWithFormat:@"%@",[employeeDetailsArr valueForKey:@"employeeId"]];
                [self getCountryName];
    }
    else{
        countryArr = [[NSMutableArray alloc]init];
        countryCodeArr = [[NSMutableArray alloc]init];
        countryPrefix = [[NSMutableArray alloc]init];
        pinless=@"0";
        imut =@"0";
        sentMoney = @"0";
        [self loadCountry];
    }
    

    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //[self loadCountry];
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDel = [AppDelegate instance];
      //[self registerForKeyboardNotifications];
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
    [self barButtonFunction];
    [self makeLayout];

}
-(void)makeLayout{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    if([type isEqualToString:@"edit"]){
        [self setTitle:@"Edit Employee"];
       NSString *editPinless = [NSString stringWithFormat:@"%@",[employeeDetailsArr valueForKey:@"pinless"]];
         NSString  *editImut = [NSString stringWithFormat:@"%@",[employeeDetailsArr valueForKey:@"imtu"]];
        NSString  *editSentMoney = [NSString stringWithFormat:@"%@",[employeeDetailsArr valueForKey:@"sentMoney"]];

        NSLog(@"editPinless==%@",editPinless);
         NSLog(@"editImut==%@",editImut);
         NSLog(@"editSentMoney==%@",editSentMoney);
        if([editPinless isEqualToString:@"No"])
        {
            
           NSLog(@"editSentMoneyjjjjj==%@",editSentMoney);
            [self.btnPinlessAccess setBackgroundImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
             pinless1=@"0";
             pinless = @"0";
            editPinless =@"";
        }
        else{
            
            NSLog(@"editSentMoneyddddddddd==%@",editSentMoney);
             [self.btnPinlessAccess setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
              pinless1 =@"1";
            pinless =@"1";
            editPinless =@"";
        }
        
        if([editImut isEqualToString:@"No"])
        {
            
            [self.btnIMTUaccess setBackgroundImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
            imut1=@"0";
            imut=@"0";
            editImut =@"";
        }
        else{
           
            [self.btnIMTUaccess setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
             imut1=@"1";
             imut=@"1";
            editImut =@"";
        }
        
        
        if([editSentMoney isEqualToString:@"No"])
        {
            
            [self.btnSendMoney setBackgroundImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
            sentMoney1=@"0";
             sentMoney=@"0";
            editSentMoney =@"";
        }
        else{
        
        [self.btnSendMoney setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
            sentMoney1=@"1";
            sentMoney=@"1";
            editSentMoney =@"";
        }
        txtCPWD.hidden = YES;
        txtPwd.hidden = YES;
        self.lblPWD.hidden = YES;
        self.lblcPWD.hidden = YES;
        [self.btnSubmit setTitle: @"UPDATE" forState: UIControlStateNormal];
        [self showediedata];
    }
    else{
        [self setTitle:@"Add Employee"];
    }

    
    UIView *paddingtxtFName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtFName.leftView = paddingtxtFName;
    txtFName.leftViewMode = UITextFieldViewModeAlways;
    self.txtFName.layer.borderWidth = 1.3;
    self.txtFName.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtFName.layer.cornerRadius = 5.0f;
    txtFName.delegate=self;
    
    UIView *paddingtxtLName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtLName.leftView = paddingtxtLName;
    txtLName.leftViewMode = UITextFieldViewModeAlways;
     txtLName.delegate=self;
    self.txtLName.layer.borderWidth = 1.3;
    self.txtLName.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtLName.layer.cornerRadius = 5.0f;
    
    UIView *paddingmail= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtEmail.leftView = paddingmail;
    txtEmail.leftViewMode = UITextFieldViewModeAlways;
    txtEmail.delegate=self;
    self.txtEmail.layer.borderWidth = 1.3;
    self.txtEmail.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtEmail.layer.cornerRadius = 5.0f;
    
    
    UIView *paddingCCode= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtCCode.leftView = paddingCCode;
    txtCCode.leftViewMode = UITextFieldViewModeAlways;
    txtCCode.delegate=self;
    self.txtCCode.layer.borderWidth = 1.3;
    self.txtCCode.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCCode.layer.cornerRadius = 5.0f;
    
    UIView *paddingphno= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtPhone.leftView = paddingphno;
    txtPhone.leftViewMode = UITextFieldViewModeAlways;
    txtPhone.delegate=self;
    self.txtPhone.layer.borderWidth = 1.3;
    self.txtPhone.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtPhone.layer.cornerRadius = 5.0f;
    
    UIView *paddingAdd= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtAddress.leftView = paddingAdd;
    txtAddress.leftViewMode = UITextFieldViewModeAlways;
    txtAddress.delegate=self;
    self.txtAddress.layer.borderWidth = 1.3;
    self.txtAddress.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtAddress.layer.cornerRadius = 5.0f;
    
    UIView *paddingcountry= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtCountry.leftView = paddingcountry;
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
    
    UIView *paddingCity= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtCity.leftView = paddingCity;
    txtCity.leftViewMode = UITextFieldViewModeAlways;
    txtCity.delegate=self;
    self.txtCity.layer.borderWidth = 1.3;
    self.txtCity.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCity.layer.cornerRadius = 5.0f;
    
    UIView *paddingPWD= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtPwd.leftView = paddingPWD;
    txtPwd.leftViewMode = UITextFieldViewModeAlways;
    txtPwd.delegate=self;
    self.txtPwd.layer.borderWidth = 1.3;
    self.txtPwd.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtPwd.layer.cornerRadius = 5.0f;
    
    UIView *paddingCPWD= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtCPWD.leftView = paddingCPWD;
    txtCPWD.leftViewMode = UITextFieldViewModeAlways;
    txtCPWD.delegate=self;
    self.txtCPWD.layer.borderWidth = 1.3;
    self.txtCPWD.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCPWD.layer.cornerRadius = 5.0f;
    
    UIView *paddingState= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtState.leftView = paddingState;
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
    
    UIView *paddingZip= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtZipCode.leftView = paddingZip;
    txtZipCode.leftViewMode = UITextFieldViewModeAlways;
    txtZipCode.delegate=self;
    self.txtZipCode.layer.borderWidth = 1.3;
    self.txtZipCode.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtZipCode.layer.cornerRadius = 5.0f;
    
      self.btnIMTUaccess.layer.cornerRadius = 6.0f;
      self.btnPinlessAccess.layer.cornerRadius = 6.0f;
      self.btnSendMoney.layer.cornerRadius = 6.0f;
    self.btnIMTUaccess.layer.borderWidth = 1.0f;
    self.btnPinlessAccess.layer.borderWidth = 1.0f;
    self.btnSendMoney.layer.borderWidth = 1.0f;
    
   
      //[self.btnPinlessAccess setBackgroundColor:[UIColor grayColor]];
      //[self.btnIMTUaccess setBackgroundColor:[UIColor grayColor]];
     // [self.btnSendMoney setBackgroundColor:[UIColor grayColor]];
    
    //self.btnSubmit.layer.borderWidth = 1.0;
    self.btnSubmit.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnSubmit.layer.cornerRadius = 6.0f;
}
- (IBAction)btnActionpinless:(id)sender {
    /*if([pinless isEqualToString:@"0"]){
         pinless=@"1";
        [self.btnPinlessAccess setBackgroundColor:[UIColor colorWithRed:0.99 green:0.28 blue:0.27 alpha:1.0]];
    }
    else if([pinless isEqualToString:@"1"]){
             pinless=@"0";
            [self.btnPinlessAccess setBackgroundColor:[UIColor grayColor]];
        
    }*/
    if( [pinless1 isEqualToString:@"1"]){
        pinless = @"1";
        pinless1 = @"0";
        //btnSelectBox.backgroundColor = [UIColor redColor];
        //[btnSelectBox setImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
        [self.btnPinlessAccess setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
        //self.btnIMTUaccess.layer.cornerRadius = 6.0f;
        //self.btnPinlessAccess.layer.cornerRadius = 6.0f;
       // self.btnSendMoney.layer.cornerRadius = 6.0f;
        //[self.btnPinlessAccess setBackgroundColor:[UIColor grayColor]];
       // [self.btnIMTUaccess setBackgroundColor:[UIColor grayColor]];
       // [self.btnSendMoney setBackgroundColor:[UIColor grayColor]];
    }
    else{
        pinless = @"0";
        pinless1 = @"1";
        //btnSelectBox.backgroundColor = [UIColor whiteColor];
        //[btnSelectBox setImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
        [self.btnPinlessAccess setBackgroundImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
        self.btnPinlessAccess.layer.borderWidth = 1.0f;
        self.btnPinlessAccess.layer.cornerRadius = 6.0f;
        //self.btnIMTUaccess.layer.cornerRadius = 6.0f;
        //self.btnPinlessAccess.layer.cornerRadius = 6.0f;
        //self.btnSendMoney.layer.cornerRadius = 6.0f;
        //[self.btnPinlessAccess setBackgroundColor:[UIColor grayColor]];
        //[self.btnIMTUaccess setBackgroundColor:[UIColor grayColor]];
        //[self.btnSendMoney setBackgroundColor:[UIColor grayColor]];
        
    }

}
- (IBAction)btnActionIMTU:(id)sender {
   /* if([imut isEqualToString:@"0"]){
        imut=@"1";
        [self.btnIMTUaccess setBackgroundColor:[UIColor colorWithRed:0.99 green:0.28 blue:0.27 alpha:1.0]];
    }
    else if([imut isEqualToString:@"1"]){
        imut=@"0";
        [self.btnIMTUaccess setBackgroundColor:[UIColor grayColor]];
        
    }*/
    
    if( [imut1 isEqualToString:@"1"]){
        imut1 = @"0";
        imut = @"1";
        //btnSelectBox.backgroundColor = [UIColor redColor];
        //[btnSelectBox setImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
        [self.btnIMTUaccess setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
        self.btnIMTUaccess.layer.cornerRadius = 6.0f;
        //self.btnPinlessAccess.layer.cornerRadius = 6.0f;
        self.btnSendMoney.layer.cornerRadius = 6.0f;
        //[self.btnPinlessAccess setBackgroundColor:[UIColor grayColor]];
        [self.btnIMTUaccess setBackgroundColor:[UIColor grayColor]];
        //[self.btnSendMoney setBackgroundColor:[UIColor grayColor]];
    }
    else{
        imut1 = @"1";
        imut = @"0";
        //[self.btnIMTUaccess setBackgroundColor:[UIColor grayColor]];
        self.btnIMTUaccess.layer.borderWidth = 1.0f;
       
        self.btnIMTUaccess.layer.cornerRadius = 6.0f;
        //btnSelectBox.backgroundColor = [UIColor whiteColor];
        //[btnSelectBox setImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
        [self.btnIMTUaccess setBackgroundImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
        
        //self.btnPinlessAccess.layer.cornerRadius = 6.0f;
        //self.btnSendMoney.layer.cornerRadius = 6.0f;
        //[self.btnPinlessAccess setBackgroundColor:[UIColor grayColor]];
        
        //[self.btnSendMoney setBackgroundColor:[UIColor grayColor]];
        
    }
}
- (IBAction)btnActionSendMoney:(id)sender {
    /*if([sentMoney isEqualToString:@"0"]){
        sentMoney=@"1";
        [self.btnSendMoney setBackgroundColor:[UIColor colorWithRed:0.99 green:0.28 blue:0.27 alpha:1.0]];
    }
    else if([sentMoney isEqualToString:@"1"]){
        sentMoney=@"0";
        [self.btnSendMoney setBackgroundColor:[UIColor grayColor]];
        
    }*/
    if( [sentMoney1 isEqualToString:@"1"]){
        sentMoney = @"1";
        sentMoney1 =@"0";
        //btnSelectBox.backgroundColor = [UIColor redColor];
        //[btnSelectBox setImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
        [self.btnSendMoney setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
       // self.btnIMTUaccess.layer.cornerRadius = 6.0f;
        //self.btnPinlessAccess.layer.cornerRadius = 6.0f;
       // self.btnSendMoney.layer.cornerRadius = 6.0f;
       // [self.btnPinlessAccess setBackgroundColor:[UIColor grayColor]];
        //[self.btnIMTUaccess setBackgroundColor:[UIColor grayColor]];
        //[self.btnSendMoney setBackgroundColor:[UIColor grayColor]];
    }
    else{
         sentMoney = @"0";
         sentMoney1 =@"1";
        //btnSelectBox.backgroundColor = [UIColor whiteColor];
        //[btnSelectBox setImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
        [self.btnSendMoney setBackgroundImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
        self.btnSendMoney.layer.borderWidth = 1.0f;
        self.btnSendMoney.layer.cornerRadius = 6.0f;

        //self.btnIMTUaccess.layer.cornerRadius = 6.0f;
        //self.btnPinlessAccess.layer.cornerRadius = 6.0f;
       // self.btnSendMoney.layer.cornerRadius = 6.0f;
       // [self.btnPinlessAccess setBackgroundColor:[UIColor grayColor]];
        //[self.btnIMTUaccess setBackgroundColor:[UIColor grayColor]];
        //[self.btnSendMoney setBackgroundColor:[UIColor grayColor]];
        
    }


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
   //[appDel setBothMenus];
     [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectDoneButton {
    [self.txtPhone resignFirstResponder];
}
//*******************
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
        [self.scrvwAddEmp insertSubview:dropcountry aboveSubview:self.txtCountry];
        
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
        [self.scrvwAddEmp insertSubview:dropState aboveSubview:self.txtState];
        
        
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
                prephno = [[allcountryArr objectAtIndex:i]objectForKey:@"countryprefix"];
            }
        }
        txtCountry.text = [NSString stringWithFormat:@"%@",countryName];
        //prephno=
        [self loadstate:[NSString stringWithFormat:@"%@",countrycode]];
        
        
        // }
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        
        json = nil;
        
    }];
}

-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex{
    
    if(dropMenu == dropcountry){
        
        
        prephno = countryPrefix[atIntedex];
        self.txtCountry.text=countryArr[atIntedex];
        country_Id=countryCodeArr[atIntedex];
        [self loadstate:countryCodeArr[atIntedex]];
        //NSLog(@"%@ with TAG : %ld", dropMenu.items[atIntedex], (long)dropMenu.tag);
    }
    else if(dropMenu == dropState){
        NSLog(@"prephno==%@",prephno);
        txtState.text = stateArr[atIntedex];
        NSLog(@"value==%@",self.txtState.text);
        state_Id = statecode[atIntedex];
         self.txtCCode.text = prephno;
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
    NSLog(@"keyboard==%@",aNotification);
    NSDictionary* info = [aNotification userInfo];
    //NSLog(@"text y==%f",activeField.frame.origin.y);
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrvwAddEmp.contentInset = contentInsets;
    scrvwAddEmp.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrvwAddEmp setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrvwAddEmp.contentInset = contentInsets;
    scrvwAddEmp.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    //[textField resignFirstResponder];
    NSLog(@"textFieldShouldReturn");
    if (textField == txtFName)
    {
        [txtFName resignFirstResponder];
        [txtLName becomeFirstResponder];
    }
    else if (textField == txtLName){
        [txtLName resignFirstResponder];
        [txtEmail becomeFirstResponder];
    }
    else if (textField == txtEmail){
        [txtEmail resignFirstResponder];
        [txtPhone becomeFirstResponder];
    }
    else if (textField == txtPhone){
        [txtPhone resignFirstResponder];
        [txtAddress becomeFirstResponder];
        
    }
        else if (textField == txtAddress){
        [txtAddress resignFirstResponder];
        [txtCity becomeFirstResponder];
        
    }
    else if (textField == txtCity){
        
        [txtCity  resignFirstResponder];
        [txtZipCode becomeFirstResponder];
        
    }
    else if (textField == txtZipCode){
        [txtZipCode resignFirstResponder];
        [txtPwd becomeFirstResponder];
        
    }
    else if (textField == txtPwd){
        [txtPwd resignFirstResponder];
        [txtCPWD becomeFirstResponder];
        
    }
    else if (textField == txtCPWD){
        [txtCPWD resignFirstResponder];
       // [self.txtBusinessName becomeFirstResponder];
        
    }
        else
    {
        [textField resignFirstResponder];
    }    return YES;
}
/*- (IBAction)addcustomerActionBtn:(id)sender {
    
   }*/
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
   // NSString *image= [NSString stringWithFormat:@"data:image/jpeg;base64;%@",ImgStr];
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  userId,@"from_reseller_id",
                  @"2",@"user_role",
                  txtFName.text,@"firstname",
                  txtLName.text,@"lastname",
                   country_Id,@"country",
                  phno,@"phone",
                  txtEmail.text,@"email",
                  state_Id,@"state",
                  txtAddress.text,@"address",
                  txtCity.text,@"city",
                  txtZipCode.text,@"zipcode",
                  txtPwd.text,@"password",
                  txtCPWD.text,@"cpassword",
                   pinless,@"pinless_active",
                   imut,@"imtu_active",
                   sentMoney,@"sendmoney_active",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_ADDEMPLOYEE];
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
            EmployeeListVC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"EmplyeeList"];
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

//SubmitEdit
-(void)SubmitEditEmployee
{
    NSLog(@"SubmitEditEmployee");
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    UserSession *addCustomer = [UserAccessSession getUserSession];
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    NSString *phno=[NSString stringWithFormat:@"%@%@",txtCCode.text,txtPhone.text];
    // NSString *image= [NSString stringWithFormat:@"data:image/jpeg;base64;%@",ImgStr];
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                 editEmployeeid,@"employee_id",
                  txtFName.text,@"firstname",
                  txtLName.text,@"lastname",
                  countrycode,@"country",
                  state_Id,@"state",
                  txtAddress.text,@"address",
                  txtCity.text,@"city",
                  txtZipCode.text,@"zipcode",
                  txtPwd.text,@"password",
                  txtCPWD.text,@"cpassword",
                  pinless,@"pinless_active",
                  imut,@"imtu_active",
                  sentMoney,@"sendmoney_active",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_UPDATEEMPLOYEE];
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
            EmployeeListVC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"EmplyeeList"];
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



- (IBAction)btnActionsubmit:(id)sender {
    //NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    //NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
    //BOOL phoneValidates = [phoneTest evaluateWithObject:phoneNumber];
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if([type isEqualToString:@"edit"]){
      txtPwd.text = @"1";
        txtCPWD.text = @"1";
    }
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
    //txtAddress
    else if([self.txtAddress.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter your address" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    //city
    else if([self.txtCity.text isEqualToString:@""] || [numerictest evaluateWithObject:self.txtCity.text] == YES){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"City name shoultnot be Blank" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    

    //zipcode
    else if([self.txtZipCode.text isEqualToString:@""] || [numerictest evaluateWithObject:self.txtZipCode.text] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper zipcode" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    //password
    else if([self.txtPwd.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //cPassword
    else if([self.txtCPWD.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Confarm your password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if(![self.txtCPWD.text isEqualToString:self.txtPwd.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@" password not match" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    else{
        
        if([type isEqualToString:@"edit"]){
            [self SubmitEditEmployee];
                    }
        else{
            [self SubmitAddCustomer];
        }
        

        
    }
}

//******************
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showediedata {
    
      
    txtFName.text =[NSString stringWithFormat:@"%@",[employeeDetailsArr valueForKey:@"fname"]];
    txtLName.text =[NSString stringWithFormat:@"%@",[employeeDetailsArr valueForKey:@"lastname"]];
    txtEmail.text =[NSString stringWithFormat:@"%@",[employeeDetailsArr valueForKey:@"email"]];
    txtPhone.text =[NSString stringWithFormat:@"%@",[employeeDetailsArr valueForKey:@"phNo"]];;
    txtAddress.text =[NSString stringWithFormat:@"%@",[employeeDetailsArr valueForKey:@"address"]];
    txtZipCode.text =[NSString stringWithFormat:@"%@",[employeeDetailsArr valueForKey:@"zip"]];
    txtCity.text =[NSString stringWithFormat:@"%@",[employeeDetailsArr valueForKey:@"city"]];
    
    
   
    
    txtEmail.userInteractionEnabled = NO;
    txtCCode.userInteractionEnabled = NO;
    txtCountry.userInteractionEnabled = NO;
    txtPhone.userInteractionEnabled = NO;
    
    txtEmail.backgroundColor = [UIColor colorWithRed:0.94 green:0.97 blue:1.00 alpha:1.0];
    txtCCode.backgroundColor = [UIColor colorWithRed:0.94 green:0.97 blue:1.00 alpha:1.0];
    txtCountry.backgroundColor = [UIColor colorWithRed:0.94 green:0.97 blue:1.00 alpha:1.0];
    txtPhone.backgroundColor = [UIColor colorWithRed:0.94 green:0.97 blue:1.00 alpha:1.0];
    
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
