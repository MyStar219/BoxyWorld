//
//  IMTUrechargeVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 23/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "IMTUrechargeVC.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"


@interface IMTUrechargeVC ()<UIScrollViewDelegate,KPDropMenuDelegate>
{
    AppDelegate *appDel;
     NSMutableArray *countryArr,*countryCodeArr,*countryPrefix,*countryIDS;
    NSMutableArray *networkArr,*networkecode;
    NSMutableArray *networkMethodArr;
    NSMutableArray *amoutDisply,*amoutOrg;
    NSString *userId ;
    NSString *athenticationKey;
    NSString *country_Id;
     NSString *phno;
    NSString *network_id;
    NSString *amount_id;
    NSString *from,*to;
    NSString *finalAmount;
    NSString *network_method;
     NSString *discount;
     NSString *willCollectU;
    NSString *country_code;
    
     MBProgressHUD *hud;
   }
@end

@implementation IMTUrechargeVC
@synthesize dropcountry,scrVWIMTURe,dropNetwork,dropAmount,txtNetwork,txtCCode,txtCountry,txtPhone,txtAmmount;
//@synthesize country,phnoe,actualAmt,network;


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self barButtonFunction];
    [self buttonShowHide];
    [self makeLayout];
    appDel = [AppDelegate instance];
    [self loadCountry];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    countryArr = [[NSMutableArray alloc]init];
    countryCodeArr = [[NSMutableArray alloc]init];
    countryPrefix = [[NSMutableArray alloc]init];
      countryIDS = [[NSMutableArray alloc]init];
    
    networkArr = [[NSMutableArray alloc]init];
    networkecode = [[NSMutableArray alloc]init];
    amoutDisply = [[NSMutableArray alloc]init];
    amoutOrg = [[NSMutableArray alloc]init];
    networkMethodArr = [[NSMutableArray alloc]init];
   
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
   // self.fldCustomerph.inputAccessoryView = accessoryView;
    self.txtPhone.inputAccessoryView = accessoryView;
     self.txtAmmount.inputAccessoryView = accessoryView;

    
    
}
- (void)selectDoneButton {
   
        
        [self.txtPhone resignFirstResponder];
     [self.txtAmmount resignFirstResponder];
    [self loadnetwork];
}

-(void)makeLayout{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIView *paddingNphno = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtPhone.leftView = paddingNphno;
    txtPhone.leftViewMode = UITextFieldViewModeAlways;
    txtPhone.delegate=self;
    self.txtPhone.layer.borderWidth = 1.3;
    self.txtPhone.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtPhone.layer.cornerRadius = 5.0f;
    
   /* self.txtCountry.layer.borderWidth = 1.3;
    self.txtCountry.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCountry.layer.cornerRadius = 5.0f;*/
    
    self.txtCountry.layer.borderWidth = 1.3;
    self.txtCountry.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCountry.layer.cornerRadius = 5.0f;
    
    self.txtCCode.layer.borderWidth = 1.3;
    self.txtCCode.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCCode.layer.cornerRadius = 5.0f;
    
    UIView *paddingNetwork = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtNetwork.leftView = paddingNetwork;
    txtNetwork.leftViewMode = UITextFieldViewModeAlways;
    txtNetwork.delegate=self;
    self.txtNetwork.layer.borderWidth = 1.3;
    self.txtNetwork.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtNetwork.layer.cornerRadius = 5.0f;
    
    UIView *paddingAmount = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtAmmount.leftView = paddingAmount;
    txtAmmount.leftViewMode = UITextFieldViewModeAlways;
    txtAmmount.delegate=self;
    self.txtAmmount.layer.borderWidth = 1.3;
    self.txtAmmount.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtAmmount.layer.cornerRadius = 5.0f;
    
    //self.btnSubmit.layer.borderWidth = 1.0;
    self.btnContinue.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnContinue.layer.cornerRadius = 6.0f;
    self.viewBtn.hidden =YES;
    self.lblHeading.hidden =YES;
}

-(void)buttonShowHide
{
    self.lblHeading.layer.cornerRadius = 5.0f;
    self.viewBtn.layer.borderWidth = 1.0;
    self.viewBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.btnTopup1.layer.cornerRadius = 5.0f;
    self.btnTopup2.layer.cornerRadius = 5.0f;
    self.btnTopup3.layer.cornerRadius = 5.0f;
    self.btnTopup4.layer.cornerRadius = 5.0f;
    self.btnTopup5.layer.cornerRadius = 5.0f;
    self.btnTopup6.layer.cornerRadius = 5.0f;
    self.btnTopup7.layer.cornerRadius = 5.0f;
    self.btnTopup8.layer.cornerRadius = 5.0f;
    self.btnTopup9.layer.cornerRadius = 5.0f;
     [self.btnTopup7 setHidden:YES];
     [self.btnTopup8 setHidden:YES];
     [self.btnTopup9 setHidden:YES];
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
    [appDel setBothMenus];
    //[self.navigationController popViewControllerAnimated:YES];
}
// for country code
-(void)loadCountry
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETIMTUCOUNTRY];
    //NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // NSLog(@"URL==%@",URL);
    // NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
       // NSLog(@"countrydata%@",json);
        NSMutableArray *allcountryArr = [[NSMutableArray alloc]init];
        allcountryArr = [[json objectForKey:@"data"]objectForKey:@"countries"];
        [countryArr removeAllObjects];
        [countryCodeArr removeAllObjects];
        [countryPrefix removeAllObjects];
        [countryIDS removeAllObjects];
        for (int i=0; i<[allcountryArr count]; i++) {
            [countryArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"country_name"]];
            [countryCodeArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"country"]];
            [countryPrefix addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryprefix"]];
            [countryIDS addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"id"]];
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
        dropcountry.DirectionDown = YES;
        [self.scrVWIMTURe insertSubview:dropcountry aboveSubview:self.txtCountry];

                
       // NSLog(@"allcountryArr%@",allcountryArr);
      
        // NSLog(@"countryArr%@",countryArr);
        
        
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
//load network
-(void)loadnetwork
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
      phno = [NSString stringWithFormat:@"+%@%@",txtCCode.text,txtPhone.text];
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  country_Id,@"country",
                   phno,@"phone",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETIMTUNETWORKS];
   // NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //NSLog(@"URLURL--==%@",URL);
   // NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        //NSLog(@"stateresponseObject---%@",json);
        // NSString *status= [json objectForKey:@"status"];
        //if([status isEqualToString:@"1"]){
        NSMutableArray *allNetworkArr = [[NSMutableArray alloc]init];
        allNetworkArr = [json objectForKey:@"networks"];
        NSLog(@"allNetworkArr=%@",allNetworkArr);
        //*stateArr,*statecode;
        [networkArr removeAllObjects];
        [networkecode removeAllObjects];
        [networkMethodArr removeAllObjects];
               for (int j=0; j<[allNetworkArr count]; j++) {
            // [networkArr addObject:[[allstateArr objectAtIndex:j]objectForKey:@"state_name"]];
            //[statecode addObject:[[allstateArr objectAtIndex:j]objectForKey:@"id"]];
            [networkArr addObject:[[allNetworkArr objectAtIndex:j]objectForKey:@"text"]];
            [networkecode addObject:[[allNetworkArr objectAtIndex:j]objectForKey:@"value"]];
             [networkMethodArr addObject:[[allNetworkArr objectAtIndex:j]objectForKey:@"topup_method"]];
        }
       // NSLog(@"networkMethodArr==%@",networkMethodArr);
        //for drop down
        CGFloat stateX = self.txtNetwork.frame.origin.x;
        CGFloat stateY = self.txtNetwork.frame.origin.y;
        CGFloat stateWidth = self.txtNetwork.frame.size.width;
        CGFloat stateHeight = self.txtNetwork.frame.size.height;
        
        dropNetwork = [[KPDropMenu alloc] initWithFrame:CGRectMake(stateX, stateY, stateWidth, stateHeight)];
        dropNetwork.delegate = self;
        dropNetwork.items = networkArr;
        dropNetwork.itemsIDs=networkecode;
        //dropState.title = @"Select State";
        dropNetwork.titleColor=[UIColor whiteColor];
        dropNetwork.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropNetwork.titleTextAlignment = NSTextAlignmentLeft;
        dropNetwork.DirectionDown = NO;
        [self.scrVWIMTURe insertSubview:dropNetwork aboveSubview:self.txtNetwork];
        [self loadIMTUAmount];
        
        //NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        
        // NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
        // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        //registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        //[[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}
//for IMTU API call
-(void)loadIMTUAmount
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  country_Id,@"country",
                  network_id,@"network",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETIMTUAMOUNTS];
    //NSLog(@"URL====AMTU%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // NSLog(@"URL==%@",URL);
   // NSLog(@"parametersAMYU==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
       // NSLog(@"AMTUAMOUNTDATA%@",json);
         NSMutableArray *allIMTUamoutArr = [[NSMutableArray alloc]init];
        allIMTUamoutArr = [json objectForKey:@"amounts"];
        NSLog(@"allIMTUamoutArr==%@",allIMTUamoutArr);
        NSString *type=[json objectForKey:@"type"];
        if([type isEqualToString:@"series"]){
            [amoutDisply removeAllObjects];
            [amoutOrg removeAllObjects];
           
         for (int i=0; i<[allIMTUamoutArr count]; i++) {
        
       
         [amoutDisply addObject:[[allIMTUamoutArr objectAtIndex:i]objectForKey:@"display_amount"]];
          [amoutOrg addObject:[[allIMTUamoutArr objectAtIndex:i]objectForKey:@"org_amount"]];
         
         }
       
        //for drop down
        CGFloat phoneX = self.txtAmmount.frame.origin.x;
        CGFloat phoneY = self.txtAmmount.frame.origin.y;
        CGFloat phoneWidth = self.txtAmmount.frame.size.width;
        CGFloat phoneHeight = self.txtAmmount.frame.size.height;
        
        dropAmount = [[KPDropMenu alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneWidth, phoneHeight)];
        dropAmount.delegate = self;
        dropAmount.items = amoutDisply;
        //dropcountry.title = @"Select Country";
        dropAmount.titleColor=[UIColor whiteColor];
        dropAmount.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropAmount.titleTextAlignment = NSTextAlignmentLeft;
        dropAmount.DirectionDown = NO;
        [self.scrVWIMTURe insertSubview:dropAmount aboveSubview:self.txtAmmount];
        }
        else if([type isEqualToString:@"range"]){
            
          from=[[json objectForKey:@"amounts"]objectForKey:@"from"];
            to=[[json objectForKey:@"amounts"]objectForKey:@"to"];
            NSString *msg1= [NSString stringWithFormat:@"Enter value between %@ to %@",from,to];
            NSLog(@" from==%@", from);
            NSLog(@" to==%@", to);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"abc" message:msg1 delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
              [txtAmmount resignFirstResponder];
            
            [alert show];
           

        }
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


-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex{
    
    if(dropMenu == dropcountry){
        
        self.txtCCode.text=countryPrefix[atIntedex];
        self.txtCountry.text=countryArr[atIntedex];
        country_Id=countryCodeArr[atIntedex];
        country_code=countryIDS[atIntedex];
        
        //countryIDS
       // [self loadstate:countryCodeArr[atIntedex]];
        //NSLog(@"%@ with TAG : %ld", dropMenu.items[atIntedex], (long)dropMenu.tag);
    }
    else if(dropMenu == dropNetwork){
        txtNetwork.text = networkArr[atIntedex];
        //NSLog(@"value==%@",self.txtState.text);
       network_id = networkecode[atIntedex];
        network_method = networkMethodArr[atIntedex];
         [self loadIMTUAmount];
    }
    else if(dropMenu == dropAmount){
        txtAmmount.text = amoutDisply[atIntedex];
        finalAmount = amoutDisply[atIntedex];
        //NSLog(@"value==%@",self.txtState.text);
        //orgAmount = networkecode[atIntedex];
    }

    else{
         NSLog(@"%@", dropMenu.items[atIntedex]);
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
    scrVWIMTURe.contentInset = contentInsets;
    scrVWIMTURe.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrVWIMTURe setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrVWIMTURe.contentInset = contentInsets;
    scrVWIMTURe.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
    //[textField resignFirstResponder];
    NSLog(@"textFieldShouldReturn");
    if (textField == txtPhone)
    {
        if(![txtPhone.text isEqualToString:@""] /*&& [numerictest evaluateWithObject:txtPhone.text] == YES*/){
           [txtPhone resignFirstResponder];
             [self loadnetwork];
           //[txtNetwork becomeFirstResponder];
                    }
        else{
            [txtPhone becomeFirstResponder];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Phone Number should not be blank and must be number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }
    }
    if (textField == txtNetwork){
       [textField resignFirstResponder];
       /* if(![txtNetwork.text isEqualToString:@""] && [numerictest evaluateWithObject:txtNetwork.text] == NO){
            [txtNetwork resignFirstResponder];
            [self loadIMTU_Amount];
            //[txtNetwork becomeFirstResponder];
        }
        else{
            [txtAmmount becomeFirstResponder];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Select network" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }*/

    }
 else
    {
        [textField resignFirstResponder];
    }    return YES;
}

- (IBAction)btnActionIMTUContinue:(id)sender {
    //NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    //NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
    //BOOL phoneValidates = [phoneTest evaluateWithObject:phoneNumber];
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    
    
         //country
     if([self.txtCountry.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select proper country" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //Phone Number
    else if([self.txtPhone.text isEqualToString:@""]/*|| [numerictest evaluateWithObject:self.txtPhone.text] == NO*/){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Phone Number should not be blank and must be number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //Amount
    else if([self.txtAmmount.text isEqualToString:@""] /*|| [numerictest evaluateWithObject:self.txtAmmount.text] == NO*/){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper Amount" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
       else{
           NSLog(@"hello");
           [self getDiscount];
           NSLog(@"discount===***%@",discount);
           
           
       
             }
}
//get recharege api index
//
//get discount API call
//URL_GETIMTUDISCOUNTS
-(void)getDiscount
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  country_Id,@"country",
                  phno,@"phone",
                  network_id,@"network",
                  finalAmount,@"org_amount",
                  finalAmount,@"amount",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETIMTUDISCOUNTS];
    NSLog(@"URL=discount===%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // NSLog(@"URL=discount=%@",URL);
  //  NSLog(@"parametersdiscount==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
       // NSLog(@"discountdata%@",json);
        NSString *status1=[NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        
        //**********alert
        if([status1 isEqualToString:@"1"]){
            NSLog(@"status1==%@",status1);
            discount= [json objectForKey:@"discount"];
            willCollectU = [json objectForKey:@"we_will_collect_from_you"];
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            IMTUDiscountVC *vc2=[mainStoryboard instantiateViewControllerWithIdentifier:@"IMTUDiscount"];
            // @synthesize country,phnoe,actualAmt,network;
            vc2.country=txtCountry.text;
            vc2.country_Id= country_Id;
            vc2.phnoe = txtPhone.text;
            vc2.actualAmt = finalAmount;
            vc2.network_Id = network_id;
            vc2.networkMethod = network_method;
            vc2.discountIMTU = discount;
            vc2.willCollectFrmU = willCollectU;
            vc2.network_name=txtNetwork.text;
            vc2.phonePre = txtCCode.text;
            vc2.countryCode =country_code  ;
            //vc2.comisn=
            
            // NSLog(@"discount==%@",discount);
            // NSLog(@"we_will_collect_from_you==%@",willCollectU);
            // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
            [[self navigationController] pushViewController:vc2 animated:YES];
        }
        else{
            NSLog(@"status.......==%@",status1);
            
        }
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
