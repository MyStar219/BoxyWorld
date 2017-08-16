//
//  recipientVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 17/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//
#import "paymentVC.h"
#import "recipientVC.h"
#import "newRecipientVC.h"
#import "addMobileNoVC.h"
#import "addBankVC.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"

@interface recipientVC ()<UIScrollViewDelegate,KPDropMenuDelegate,UITextFieldDelegate>
{
     NSString *userId,*athenticationKey,*country_Id,*customer_id,*amount,*fName,*lName;
    NSString *flag,*main_Id,*bankId_Id,*recipint_ph;
    NSMutableArray *mainIdArr,*nameArr,*phnoArr;
    NSMutableArray *allBanksIdArr,*allBankName,*allBanksArr;
    NSMutableArray *allNetworkArr,*networkNameArr,*networkIDArr;
    NSString *option_id,*network_Id;
    NSMutableArray *allmobileNoArr,*mNoArr;
    SWRevealViewController *revealController;
    MBProgressHUD *hud;
}
@end

@implementation recipientVC
@synthesize lblHead,btnAddRecipient,lblFirst,txtFirst,lblSecond,fldSecond,lblThird,fldThird,btnAddAcc,btnSaveANDCon,flagTransBy,scrRecipient,dropRecipient,dropBank,dropMobile;
@synthesize dropNewwork;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"flagTransBy==%@",flagTransBy);
   [self sentMoneyRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     nameArr = [[NSMutableArray alloc]init];
    mainIdArr = [[NSMutableArray alloc]init];
    allBanksIdArr = [[NSMutableArray alloc]init];
    allBankName = [[NSMutableArray alloc]init];
    allBanksArr = [[NSMutableArray alloc]init];
    networkIDArr =[[NSMutableArray alloc]init];
   networkNameArr = [[NSMutableArray alloc]init];
    allmobileNoArr =[[NSMutableArray alloc]init];
    mNoArr =[[NSMutableArray alloc]init];
    phnoArr = [[NSMutableArray alloc]init];
    
    revealController = self.revealViewController;
   flag =[NSString stringWithFormat:@"%@",flagTransBy]; //flagTransBy;
    [self makeLayout];
     amount = [[NSUserDefaults standardUserDefaults] objectForKey:@"Sm_Amount"];
    if([flag isEqualToString:@"Mobile Money"])
    {
        NSLog(@"hello");
    [self mobile];
    // flag = @"Bank";
    }
    else{
         NSLog(@"hi");
        [self Bank];
        //flag = @"Mobile";
    }
   self.tabBarController.selectedIndex = 1;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)makeLayout{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setTitle:@"RECIPIENT"];
    
    UIView *paddingFfield = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtFirst.leftView = paddingFfield;
    txtFirst.leftViewMode = UITextFieldViewModeAlways;
    txtFirst.delegate=self;
    self.txtFirst.layer.borderWidth = 1.3;
    self.txtFirst.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtFirst.layer.cornerRadius = 5.0f;
    UIButton *btnFfield = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFfield addTarget:self action:@selector(btnFfieldPressed:) forControlEvents:UIControlEventTouchUpInside];
    btnFfield.frame = CGRectMake(self.txtFirst.bounds.size.width -30, 10, 20, 20);
    [btnFfield setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtFirst addSubview:btnFfield];
    
    UIView *paddingFld2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    fldSecond.leftView = paddingFld2;
    fldSecond.delegate=self;
    self.fldSecond.layer.borderWidth = 1.3;
    self.fldSecond.layer.borderColor = textFieldBorderColor.CGColor;
    self.fldSecond.layer.cornerRadius = 5.0f;
    UIButton *btnFld2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFld2 addTarget:self action:@selector(btnFld2Pressed:) forControlEvents:UIControlEventTouchUpInside];
    btnFld2.frame = CGRectMake(self.fldSecond.bounds.size.width -30, 10, 20, 20);
    [btnFld2 setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.fldSecond addSubview:btnFld2];
    
    UIView *paddingFld3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    fldThird.leftView = paddingFld3;
    fldThird.delegate=self;
    self.fldThird.layer.borderWidth = 1.3;
    self.fldThird.layer.borderColor = textFieldBorderColor.CGColor;
    self.fldThird.layer.cornerRadius = 5.0f;
    UIButton *btnFld3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFld3 addTarget:self action:@selector(btnFld3Pressed:) forControlEvents:UIControlEventTouchUpInside];
    btnFld3.frame = CGRectMake(self.fldThird.bounds.size.width -30, 10, 20, 20);
    [btnFld3 setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.fldThird addSubview:btnFld3];
    
 
    //self.btnAddRecipient.layer.borderWidth = 1.3;
  //  self.btnAddRecipient.layer.borderColor = textFieldBorderColor.CGColor;
    self.btnAddRecipient.layer.cornerRadius = 5.0f;
    
    //self.btnAddAcc.layer.borderWidth = 1.3;
    //  self.btnAddRecipient.layer.borderColor = textFieldBorderColor.CGColor;
   // self.btnAddAcc.layer.cornerRadius = 5.0f;

    
  
    //self.btnSubmit.layer.borderWidth = 1.3;
    self.btnSaveANDCon.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnSaveANDCon.layer.cornerRadius = 5.0f;
}
-(void)mobile{
    NSLog(@"MOBILE");
    [lblHead setBackgroundColor:[UIColor lightGrayColor]];
    lblHead.text =@"Bank depositsreflects within into nigeria bank accounts during both banking and non-banking hours. Regardless of time 1am,1pm 12 midnight ,your transfer is received in minutes.";
    //[lblHead sizeToFit];
    lblFirst.text = @"Recipent";
    lblFirst.textColor=[UIColor colorWithRed:0.99 green:0.40 blue:0.35 alpha:1.0];
    lblSecond.text =@"Select Network Provider";
    lblSecond.textColor=[UIColor colorWithRed:0.99 green:0.40 blue:0.35 alpha:1.0];
    lblThird.text = @"Select Mobile number";
    lblThird.textColor=[UIColor colorWithRed:0.99 green:0.40 blue:0.35 alpha:1.0];
    [self.btnAddAcc setTitle:@"Add new mobile number" forState:UIControlStateNormal];
}
-(void)Bank{
    NSLog(@"BANK");
     [lblHead setBackgroundColor:[UIColor lightGrayColor]];
    lblHead.text =@"Bank depositsreflects within into nigeria bank accounts during both banking and non-banking hours. Regardless of time 1am,1pm 12 midnight ,your transfer is received in minutes.";
    lblFirst.text = @"Recipent";
     lblFirst.textColor=[UIColor colorWithRed:0.99 green:0.40 blue:0.35 alpha:1.0];
    lblSecond.text =@"Bank Account";
    lblSecond.textColor=[UIColor colorWithRed:0.99 green:0.40 blue:0.35 alpha:1.0];
    lblThird.hidden=YES;
    fldThird.hidden = YES;
   [self.btnAddAcc setTitle:@"View/Edit/Add new Bank Account" forState:UIControlStateNormal];
}
- (IBAction)btnActionaddnewRecipent:(id)sender {
    
    /*
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    newRecipientVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"newPecipient"];
    // [revealController setFrontViewPosition:vc1 animated:YES];
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
    [revealController pushFrontViewController:frontNavigationController animated:YES];
    */
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    newRecipientVC * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"newPecipient"];
    [self.navigationController pushViewController:vc2 animated:YES];
    
    
    

   }
- (IBAction)btnactionaddNewBankmobile:(id)sender {
   
    
    if([flag isEqualToString:@"Mobile Money"])
    {
         NSString * storyboardName = @"Main";
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
         addMobileNoVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"addNewMobile"];
          //[revealController setFrontViewPosition:vc1 animated:YES];
        [self.navigationController pushViewController:vc1 animated:YES];
         /*UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
         [revealController pushFrontViewController:frontNavigationController animated:YES];
          */
    }
    else{
        if(![txtFirst.text isEqualToString:@""])
        {
        
         NSString * storyboardName = @"Main";
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
         addBankVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"addBank"];
          //[revealController setFrontViewPosition:vc1 animated:YES];
         [self.navigationController pushViewController:vc1 animated:YES];
         /*UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
         [revealController pushFrontViewController:frontNavigationController animated:YES];
        */
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select Recipient" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }
        
    }

    
}
//SentMoneyRequest
-(void)sentMoneyRequest
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
    country_Id =addCustomer.sentMoney_CountyID;
    NSLog(@"customer Id=====%@",addCustomer.customer_id);
    NSLog(@"userId=====%@",userId);
    NSLog(@"main_Id=====%@",main_Id);
    //NSLog(@"customer Id=====%@",addCustomer.customer_id);
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  customer_id,@"customer_id",
                  amount,@"amount",
                  country_Id,@"country_id",
                  @"balance",@"pay_option_with",
                  @"1",@"rate_type",
                  @"get_data_by_country",@"type",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETSENDMONEYREQUEST];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // NSLog(@"URL==%@",URL);
    NSLog(@"sentMoneyRequest==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"sentMoneyRequest==%@",json);
        
        NSMutableArray *allcontaccArr = [[NSMutableArray alloc]init];
        allcontaccArr = [json objectForKey:@"contacts"];
        NSLog(@"allcontaccArr==**%@",allcontaccArr);
        [nameArr removeAllObjects];
        [nameArr removeAllObjects];
        for (int i=0; i<[allcontaccArr count]; i++) {
            fName=[[allcontaccArr objectAtIndex:i]objectForKey:@"firstname"];
            lName = [[allcontaccArr objectAtIndex:i]objectForKey:@"lastname"];
            [mainIdArr addObject:[[allcontaccArr objectAtIndex:i]objectForKey:@"main_id"]];
            [phnoArr addObject:[[allcontaccArr objectAtIndex:i]objectForKey:@"phone"]];
            [nameArr addObject:[NSString stringWithFormat:@"%@ %@",fName,lName]];
            
        }
        
        CGFloat phoneX = txtFirst.frame.origin.x;
        CGFloat phoneY = txtFirst.frame.origin.y;
        CGFloat phoneWidth = self.txtFirst.frame.size.width;
        CGFloat phoneHeight = self.txtFirst.frame.size.height;
        
        dropRecipient = [[KPDropMenu alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneWidth, phoneHeight)];
        dropRecipient.delegate = self;
        dropRecipient.items = nameArr;
        //dropRecipient.title = @"Select recipient";
        dropRecipient.titleColor=[UIColor blackColor];
        dropRecipient.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropRecipient.titleTextAlignment = NSTextAlignmentLeft;
        dropRecipient.DirectionDown = YES;
        [self.scrRecipient insertSubview:dropRecipient aboveSubview:self.txtFirst];
        
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
//load network API
-(void)loadMobileNetwork
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
    //NSLog(@"addCustomer===%@",addCustomer);
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    customer_id =addCustomer.customer_id;
    country_Id =addCustomer.sentMoney_CountyID;
    option_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"optionID"];
    //NSLog(@"customer Id=====%@",addCustomer.customer_id);
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  customer_id,@"customer_id",
                  country_Id,@"country_id",
                  option_id,@"option_id",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETPAYOUTNOTES];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==%@",URL);
    NSLog(@"loadMobileNetwork==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"loadMobileNetwork==%@",json);
        
       
        NSMutableArray *allcontaccArr = [[NSMutableArray alloc]init];
        allNetworkArr = [json objectForKey:@"network"];
        if([allNetworkArr count] !=0){
            
        
        NSLog(@"allNetworkArr==%@",allNetworkArr);
        [networkNameArr removeAllObjects];
        [networkIDArr removeAllObjects];
        for (int i=0; i<[allNetworkArr count]; i++) {
            //[networkNameArr addObject:[allNetworkArr objectAtIndex:i]];
            [networkNameArr addObject:[[allNetworkArr objectAtIndex:i]objectForKey:@"name"]];
            [networkIDArr addObject:[[allNetworkArr objectAtIndex:i]objectForKey:@"id"]];
        }
         fldSecond.text = networkNameArr[0];
         [self loadMobileNumber];
         NSLog(@"networkNameArr==%@",networkNameArr);
         NSLog(@"networkIDArr==%@",networkIDArr);
         CGFloat networkX = fldSecond.frame.origin.x;
         CGFloat networkY = fldSecond.frame.origin.y;
         CGFloat networkWidth = self.fldSecond.frame.size.width;
         CGFloat networkHeight = self.fldSecond.frame.size.height;
        
        dropNewwork = [[KPDropMenu alloc] initWithFrame:CGRectMake(networkX, networkY, networkWidth, networkHeight)];
        dropNewwork.delegate = self;
        dropNewwork.items = networkNameArr;
        //dropcountry.title = @"Select Country";
        dropNewwork.titleColor=[UIColor blackColor];
        dropNewwork.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropNewwork.titleTextAlignment = NSTextAlignmentLeft;
        dropNewwork.DirectionDown = YES;
        [self.scrRecipient insertSubview:dropNewwork aboveSubview:self.fldSecond];
        }
        else{
            NSLog(@"No number found");
        }
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



-(void)loadBank
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
    //NSLog(@"addCustomer===%@",addCustomer);
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    customer_id =addCustomer.customer_id;
    country_Id =addCustomer.sentMoney_CountyID;
    option_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"optionID"];
    //NSLog(@"customer Id=====%@",addCustomer.customer_id);
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                athenticationKey,@"authentication_key",
                  customer_id,@"customer_id",
                  main_Id,@"contact_id",
                  @"get_contact_banks",@"type",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETSENDMONEYREQUEST];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==%@",URL);
    NSLog(@"loadBank==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"loadBank==%@",json);
        
        allBanksArr = [json objectForKey:@"accounts"];
        [allBanksIdArr removeAllObjects];
        [allBankName removeAllObjects];
        for (int i=0; i<[allBanksArr count]; i++) {
            [allBanksIdArr addObject:[[allBanksArr objectAtIndex:i]objectForKey:@"bank_id"]];
            [allBankName addObject:[[allBanksArr objectAtIndex:i]objectForKey:@"bank_name"]];
            
            
            // [countryPrefix addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryprefix"]];
        }
        NSLog(@"allBankName==%@",allBankName);
        // NSLog(@"allBanksArr==%@",allBanksArr);
        //NSLog(@"allBankName==%@",allBankName);
        // NSLog(@"allBanksIdArr==%@",allBanksIdArr);
        CGFloat bankX = fldSecond.frame.origin.x;
        CGFloat bankY = fldSecond.frame.origin.y;
        CGFloat bankWidth = self.fldSecond.frame.size.width;
        CGFloat bankHeight = self.fldSecond.frame.size.height;
        
        dropBank = [[KPDropMenu alloc] initWithFrame:CGRectMake(bankX, bankY, bankWidth, bankHeight)];
        dropBank.delegate = self;
        dropBank.items = allBankName;
        //dropcountry.title = @"Select Country";
        dropBank.titleColor=[UIColor blackColor];
        dropBank.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropBank.titleTextAlignment = NSTextAlignmentLeft;
        dropBank.DirectionDown = YES;
        [self.scrRecipient insertSubview:dropBank aboveSubview:self.fldSecond];
     
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

//load mobile number API
-(void)loadMobileNumber
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
    //NSLog(@"addCustomer===%@",addCustomer);
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    customer_id =addCustomer.customer_id;
    country_Id =addCustomer.sentMoney_CountyID;
    option_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"optionID"];
    //NSLog(@"customer Id=====%@",addCustomer.customer_id);
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  customer_id,@"customer_id",
                   @"get_contact_banks",@"type",
                  main_Id,@"contact_id",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETSENDMONEYREQUEST];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==%@",URL);
    NSLog(@"parameters mobile number==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"recipient mobile no==%@",json);
        
        
        NSMutableArray *allcontaccArr = [[NSMutableArray alloc]init];
        allmobileNoArr = [json objectForKey:@"contact_phones"];
        NSLog(@"allmobileNoArr==%@",allmobileNoArr);
        
        [mNoArr removeAllObjects];

        for (int k=0; k<[allmobileNoArr count];k++){
            [mNoArr addObject:[[allmobileNoArr objectAtIndex:k]objectForKey:@"msf_number"]];
            
        }
         NSLog(@"mNoArr==%@",mNoArr);
         fldThird.text = mNoArr[0];
        CGFloat mobileX = fldThird.frame.origin.x;
        CGFloat mobileY = fldThird.frame.origin.y;
        CGFloat mobileWidth = self.fldThird.frame.size.width;
        CGFloat mobileHeight = self.fldThird.frame.size.height;
        
        dropMobile = [[KPDropMenu alloc] initWithFrame:CGRectMake(mobileX, mobileY, mobileWidth, mobileHeight)];
        dropMobile.delegate = self;
        dropMobile.items = mNoArr;
        //dropcountry.title = @"Select Country";
        dropMobile.titleColor=[UIColor blackColor];
        dropMobile.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropMobile.titleTextAlignment = NSTextAlignmentLeft;
        dropMobile.DirectionDown = NO;
        [self.scrRecipient insertSubview:dropMobile aboveSubview:self.fldThird];
        
         //[self loadMobileNumber];
        
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
    NSLog(@"didSelectItem");
    if(dropMenu == dropRecipient){
        txtFirst.text = nameArr[atIntedex];
        main_Id = mainIdArr[atIntedex];
        recipint_ph = phnoArr[atIntedex];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",main_Id] forKey:@"recipientId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if([flag isEqualToString:@"Mobile Money"])
        {
            [self loadMobileNetwork];
            NSLog(@"hello seny money mobile");
        }
        else{
            [self loadBank];
            NSLog(@"hello seny Bank");
        }
    }
   else if(dropMenu == dropBank){
       
       
        fldSecond.text = allBankName[atIntedex];
        bankId_Id = allBanksIdArr[atIntedex];
       
    }
   else if(dropMenu == dropNewwork){
       
       
           fldSecond.text = networkNameArr[atIntedex];
           network_Id = networkIDArr[atIntedex];
           [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", network_Id] forKey:@"partnerTD"];
           [[NSUserDefaults standardUserDefaults] synchronize];
       

      
       
   }
   else if(dropMenu == dropMobile){
     
       //bankId_Id = allBanksIdArr[atIntedex];
       
            fldThird.text = mNoArr[atIntedex];
       

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
    //NSLog(@"keyboard==%@",aNotification);
    NSDictionary* info = [aNotification userInfo];
    //NSLog(@"text y==%f",activeField.frame.origin.y);
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrRecipient.contentInset = contentInsets;
    scrRecipient.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrRecipient setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrRecipient.contentInset = contentInsets;
    scrRecipient.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    //NSLog(@"textFieldDidBeginEditing");
    activeField = textField;
}

//
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == fldSecond){
        if([txtFirst.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"please select Recipient" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
             [fldSecond resignFirstResponder];
        }
        else{
             [fldSecond resignFirstResponder];
        }
    }
    
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)btnActionSaveAContinue:(id)sender {
   // lblHead,btnAddRecipient,lblFirst,txtFirst,lblSecond,fldSecond,lblThird,fldThird,btnAddAcc
    if([txtFirst.text isEqualToString:@""] ){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"please select Recipient" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
           else{
              //***********
               UserSession *session = [UserAccessSession getUserSession];
               //UserSession* customer_session = [UserSession new];
               // customer_session.previousController = @"login";
               //@synthesize customer_id,customer_Name,customer_email,customer_phNo,customer_address,customer_zip,customer_state,customer_country,customer_city;
               session.recipent_Name = [NSString stringWithFormat:@"%@",txtFirst.text];
               session.recipent_phone =[NSString stringWithFormat:@"%@",recipint_ph];
               session.expSentMoneyBankOrMobile =[NSString stringWithFormat:@"%@",fldSecond.text];
               session.recipent_id =main_Id;
               session.recSelectedPhno =[NSString stringWithFormat:@"%@",fldThird.text];
               session.recBankId =bankId_Id;
               
               //fldThird.text
                             [UserAccessSession storeUserSession:session];
              //*************
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",amount] forKey:@"Sm_Amount"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        /* NSString * storyboardName = @"Main";
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
         recipientVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"tabRecipient"];
         vc1.flagTransBy = sentMoney_by;
         [revealController pushFrontViewController:vc1 animated:YES];*/
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        paymentVC * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"tabPayment"];
        
        
        
        [self.navigationController pushViewController:vc2 animated:YES];
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
