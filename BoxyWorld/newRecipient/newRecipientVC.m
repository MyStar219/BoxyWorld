//
//  newRecipientVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 17/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "newRecipientVC.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "recipientVC.h"

@interface newRecipientVC ()<UIScrollViewDelegate,KPDropMenuDelegate,UITextFieldDelegate>
{
    NSString *userId,*athenticationKey,*country_Id,*country_preFix,*customer_id,*flag,*amount;
    NSMutableArray *countryArr,*countryCodeArr,*countryPrefix;
    MBProgressHUD *hud;
    NSString *currncyCode;
    NSMutableArray *allBanksArr,*allBanksIdArr,*allBankName;
    NSString *bank_Id,*prePhno,*countryId,*CountryName,*receipt;
    
}
@end

@implementation newRecipientVC
@synthesize txtFName,txtLName,txtMName,txtMail,txtPrePh,txtPhno,txtCountry,txtBank,txtACNo,txtConfrmACNo,txtselectBox,btnAddAsContact,scrNewRecipent,btnSelectBox;
@synthesize dropcountry,dropBank;
;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    countryArr = [[NSMutableArray alloc]init];
    countryCodeArr = [[NSMutableArray alloc]init];
    countryPrefix = [[NSMutableArray alloc]init];
    allBanksArr= [[NSMutableArray alloc]init];
    allBanksIdArr= [[NSMutableArray alloc]init];
    allBankName= [[NSMutableArray alloc]init];
   // stateArr = [[NSMutableArray alloc]init];
   // statecode = [[NSMutableArray alloc]init];
    receipt=@"0";
    txtselectBox.hidden=YES;
   
   // [self loadCountry];
    
}

- (void)viewDidLoad {
    txtselectBox.hidden=YES;
    [super viewDidLoad];
    [self setTitle:@"Add New Recipient"];
    
    [self barButtonFunction];
    [self makeLayout];
    [self registerForKeyboardNotifications];
    amount = [[NSUserDefaults standardUserDefaults] objectForKey:@"Sm_Amount"];
    
    UserSession *addCustomer = [UserAccessSession getUserSession];
    NSLog(@"addCustomer===%@",addCustomer);
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    customer_id =addCustomer.customer_id;
    countryId =addCustomer.sentMoney_CountyID;
    CountryName =addCustomer.sentMoney_countryname;
    prePhno =addCustomer.sentMoney_countryprefix;
    txtCountry.text =CountryName;
    txtPrePh.text =prePhno;
     [self sentMoneyRequest];
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
    //NSLog(@"ghjghjghkghj");
    //[self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)makeLayout{
    
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
    self.txtLName.layer.borderWidth = 1.3;
    self.txtLName.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtLName.layer.cornerRadius = 5.0f;
    txtLName.delegate=self;
    
    UIView *paddingtxtMName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtMName.leftView = paddingtxtMName;
    txtMName.leftViewMode = UITextFieldViewModeAlways;
    self.txtMName.layer.borderWidth = 1.3;
    self.txtMName.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtMName.layer.cornerRadius = 5.0f;
    txtMName.delegate=self;
    
    UIView *paddingtxtMail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtMail.leftView = paddingtxtMail;
    txtMail.leftViewMode = UITextFieldViewModeAlways;
    txtMail.delegate=self;
    self.txtMail.layer.borderWidth = 1.3;
    self.txtMail.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtMail.layer.cornerRadius = 5.0f;
    
    UIView *paddingtxtPrePhno = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtPrePh.leftView = paddingtxtPrePhno;
    txtPrePh.leftViewMode = UITextFieldViewModeAlways;
    txtPrePh.delegate=self;
    self.txtPrePh.layer.borderWidth = 1.3;
    self.txtPrePh.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtPrePh.layer.cornerRadius = 5.0f;
    
    UIView *paddingtxtPhNo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtPhno.leftView = paddingtxtPhNo;
    txtPhno.leftViewMode = UITextFieldViewModeAlways;
    txtPhno.delegate=self;
    self.txtPhno.layer.borderWidth = 1.3;
    self.txtPhno.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtPhno.layer.cornerRadius = 5.0f;
    
    
    UIView *paddingtxtcountry = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtCountry.leftView = paddingtxtcountry;
    txtCountry.leftViewMode = UITextFieldViewModeAlways;
    txtCountry.delegate=self;
    self.txtCountry.layer.borderWidth = 1.3;
    self.txtCountry.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCountry.layer.cornerRadius = 5.0f;
    
    UIView *paddingtxtBank = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtBank.leftView = paddingtxtBank;
    txtBank.leftViewMode = UITextFieldViewModeAlways;
    txtBank.delegate=self;
    self.txtBank.layer.borderWidth = 1.3;
    self.txtBank.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtBank.layer.cornerRadius = 5.0f;
    UIButton *btnBank = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBank addTarget:self action:@selector(btnBankPressed:) forControlEvents:UIControlEventTouchUpInside];
    btnBank.frame = CGRectMake(self.txtBank.bounds.size.width -30, 10, 20, 20);
    [btnBank setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtBank addSubview:btnBank];
    
    UIView *paddingtxtACNo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtACNo.leftView = paddingtxtACNo;
    txtACNo.leftViewMode = UITextFieldViewModeAlways;
    txtACNo.delegate=self;
    self.txtACNo.layer.borderWidth = 1.3;
    self.txtACNo.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtACNo.layer.cornerRadius = 5.0f;
    
    UIView *paddingconfrmACNo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtConfrmACNo.leftView = paddingconfrmACNo;
    txtConfrmACNo.leftViewMode = UITextFieldViewModeAlways;
    txtConfrmACNo.delegate=self;
    self.txtConfrmACNo.layer.borderWidth = 1.3;
    self.txtConfrmACNo.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtConfrmACNo.layer.cornerRadius = 5.0f;
    
    //UIView *paddingtxtFName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
   //txtmoneySentTo.leftView = paddingtxtFName;
   // txtmoneySentTo.delegate=self;
    self.txtselectBox.layer.borderWidth = 1.3;
    self.txtselectBox.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtselectBox.layer.cornerRadius = 5.0f;
    
    //self.btnSubmit.layer.borderWidth = 1.3;
    self.btnAddAsContact.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnAddAsContact.layer.cornerRadius = 5.0f;
    
    self.btnSelectBox.layer.borderWidth = 1.3;
    self.btnSelectBox.layer.borderColor =textFieldBorderColor.CGColor;
    self.btnSelectBox.layer.cornerRadius = 5.0f;
}

-(void)loadRecipient
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
    NSLog(@"addCustomer===%@",addCustomer);
        NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  customer_id,@"customer_id",
                  txtFName.text,@"firstname",
                  txtLName.text,@"lastname",
                  txtMName.text,@"middlename",
                  txtPhno.text,@"phone",
                  txtMail.text,@"email",
                  countryId,@"country",
                   bank_Id,@"bank_id",
                   txtACNo.text,@"account_no",
                  txtConfrmACNo.text,@"confirm_account_no",
                   receipt,@"receipt",
                  nil];
    

    
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETADDNEWCONTACT];
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
        NSLog(@"explore==%@",json);
        NSString *status =[NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        NSLog(@"jsfdsgafgsafhjf-----status %@",status);
        if([status isEqualToString:@"1"])
        {
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
       /* NSMutableArray *allcountryArr = [[NSMutableArray alloc]init];
        allcountryArr = [json objectForKey:@"data"];//valueForKey:@"countryname"];
        // NSLog(@"allcountryArr*****%@",allcountryArr);
        for (int i=0; i<[allcountryArr count]; i++) {
            [countryArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryname"]];
            [countryCodeArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"id"]];
            [countryPrefix addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryprefix"]];
        }
        //NSLog(@"countryArr*****%@",countryArr);
        //NSLog(@"countryPrefix*****%@",countryPrefix);
        //for drop down
        CGFloat phoneX = txtCountry.frame.origin.x;
        CGFloat phoneY = txtCountry.frame.origin.y;
        CGFloat phoneWidth = self.txtCountry.frame.size.width;
        CGFloat phoneHeight = self.txtCountry.frame.size.height;
       
        dropcountry = [[KPDropMenu alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneWidth, phoneHeight)];
        dropcountry.delegate = self;
        dropcountry.items = countryArr;
        //dropcountry.title = @"Select Country";
        dropcountry.titleColor=[UIColor blackColor];
        dropcountry.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropcountry.titleTextAlignment = NSTextAlignmentLeft;
        dropcountry.DirectionDown = YES;
        [self.scrNewRecipent insertSubview:dropcountry aboveSubview:self.txtCountry];
        
        //NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        
        // NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
        // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
        */
        
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
    
    /*if(dropMenu == dropcountry){
        
        //preph.text=countryPrefix[atIntedex];
        txtCountry.text=countryArr[atIntedex];
        country_Id=countryCodeArr[atIntedex];
        country_preFix = countryPrefix[atIntedex];
        [self sentMoneyRequest];
        //NSLog(@"%@ with TAG : %ld", dropMenu.items[atIntedex], (long)dropMenu.tag);
    }*/
    if(dropMenu == dropBank){
        txtBank.text = allBankName[atIntedex];
        bank_Id = allBanksIdArr[atIntedex];
        
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
-(void)sentMoneyRequest
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    /*UserSession *addCustomer = [UserAccessSession getUserSession];
    NSLog(@"addCustomer===%@",addCustomer);
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    customer_id =addCustomer.customer_id;
    NSLog(@"customer Id=====%@",addCustomer.customer_id);*/
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
        txtCountry.text =CountryName;
    txtPrePh.text =prePhno;
    
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
        NSLog(@"new Recipaint==%@",json);
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
        [self.scrNewRecipent insertSubview:dropBank aboveSubview:self.txtBank];
        

        
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
    scrNewRecipent.contentInset = contentInsets;
    scrNewRecipent.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrNewRecipent setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrNewRecipent.contentInset = contentInsets;
    scrNewRecipent.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

//
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
   
   /* if (textField == txtFName)
    {
        [txtFName resignFirstResponder];
        [txtLName becomeFirstResponder];
    }
    else if (textField == txtLName){
        [txtLName resignFirstResponder];
        [txtMName becomeFirstResponder];
    }
    else if (textField == txtMName){
        [txtMName resignFirstResponder];
        [txtMail becomeFirstResponder];
    }
    
    else if (textField == txtMail){
        [txtMail resignFirstResponder];
        [txtPhno becomeFirstResponder];
    }
    else if (textField == txtPhno){
        [txtPhno resignFirstResponder];
        [txtBank becomeFirstResponder];
    }
        else if (textField == txtBank){
        [txtBank resignFirstResponder];
        [txtACNo becomeFirstResponder];
    }
    else if (textField == txtACNo){
        [txtACNo resignFirstResponder];
        [txtConfrmACNo becomeFirstResponder];
    }
    else if (textField == txtConfrmACNo){
        [txtConfrmACNo resignFirstResponder];
        //[txtConfrmACNo becomeFirstResponder];
    }
    
    else
    {
        [textField resignFirstResponder];
    }
    */
     [textField resignFirstResponder];
    return YES;
}
- (IBAction)btnSelextAction:(id)sender {
    //[btnSelectBox setImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
    if( [receipt isEqualToString:@"0"]){
        receipt = @"1";
        //btnSelectBox.backgroundColor = [UIColor redColor];
         //[btnSelectBox setImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
         [btnSelectBox setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
    }
    else{
        receipt = @"0";
        //btnSelectBox.backgroundColor = [UIColor whiteColor];
        //[btnSelectBox setImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
        [btnSelectBox setBackgroundImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
        
    }
  
}
- (IBAction)btnAddNewRecipient:(id)sender {
   
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
    //middle name
    else if([txtMName.text isEqualToString:@""] || [numerictest evaluateWithObject:txtMName.text] == YES){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter middle Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
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
    
   
    //Phone Number
    else if([txtPhno.text isEqualToString:@""]|| [numerictest evaluateWithObject:txtPhno.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Phone Number should not be blank and must be number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    //ac no
    else if([txtACNo.text isEqualToString:@""] || [numerictest evaluateWithObject:txtACNo.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter account number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if([txtConfrmACNo.text isEqualToString:@""] || [numerictest evaluateWithObject:txtConfrmACNo.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please reenter account number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if(![txtConfrmACNo.text isEqualToString:[NSString stringWithFormat:@"%@",txtConfrmACNo.text]] ){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Account no does not match" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else{
        [self loadRecipient];
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
