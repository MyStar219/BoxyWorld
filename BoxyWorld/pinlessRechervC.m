//
//  pinlessRechervC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 04/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "pinlessRechervC.h"
#import "AppDelegate.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "config.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "pinlessRechargevC2.h"


@interface pinlessRechervC ()<UITextFieldDelegate>
{
    AppDelegate *appDel;
     MBProgressHUD *hud;
    NSString *userId ;
    NSString *athenticationKey,*phoneNo ;
    NSString *flag;
}
@end

@implementation pinlessRechervC
@synthesize fldCustomerph,fldrechargeAmt,btnSubmit,scrPinless,lblMsgBox,fldFName,fldLName,fldEmail,lblFName,lblLName,lblEmail;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Pinless Recharge";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
     [self barButtonFunction];
     [self makeLayout];
     [self makeLayout_hidden];
     flag =@"0";
     fldCustomerph.delegate = self;
     fldrechargeAmt.delegate =  self;
    
     appDel = [AppDelegate instance];
     [self registerForKeyboardNotifications];
    // Do any additional setup after loading the view.
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
    self.fldCustomerph.inputAccessoryView = accessoryView;
    self.fldrechargeAmt.inputAccessoryView = accessoryView;

}

- (void)selectDoneButton {
    if(![fldCustomerph.text isEqualToString:@""]){
        
        if(activeField == fldCustomerph){
            [self.fldCustomerph resignFirstResponder];
            //self.fldrechargeAmt.text =@"";
            [self get_userDetailsByPhno];
        }
        else{
            // self.fldrechargeAmt.text =@"";
            if(![fldCustomerph.text isEqualToString:@""]){
                [self.fldrechargeAmt resignFirstResponder];
                [self.fldCustomerph resignFirstResponder];
            }
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Customer phone number required" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        [self.fldCustomerph resignFirstResponder];
        
    }
    
    
    
}
/*- (void)selectDoneButton {
    if(![fldCustomerph.text isEqualToString:@""]){
 
         [self.fldCustomerph resignFirstResponder];
        if([flag isEqualToString:@"0"]){
            flag =@"1";
         [self get_userDetailsByPhno];
            
            
        }
        
    }
    if([fldCustomerph.text isEqualToString:@""]){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Customer phone number required" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
         [self.fldCustomerph resignFirstResponder];
    }
    if(![fldrechargeAmt.text isEqualToString:@""]){
        
         [self.fldrechargeAmt resignFirstResponder];
     
    }
    
    [self.fldCustomerph resignFirstResponder];
    [self.fldrechargeAmt resignFirstResponder];

   
   
    
}*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)makeLayout{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //fldCustomerph,fldrechargeAmt,btnSubmit,scrPinless,lblMsgBox,fldFName,fldLName,fldEmail
   // customerphone no
    UIView *paddingCpHno = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.fldCustomerph.leftView = paddingCpHno;
    self.fldCustomerph.leftViewMode = UITextFieldViewModeAlways;
    self.fldCustomerph.layer.borderWidth = 1.3;
    self.fldCustomerph.layer.borderColor = textFieldBorderColor.CGColor;
    self.fldCustomerph.layer.cornerRadius = 5.0f;
    
    
    //Recharge Amount
    UIView *paddingRechargeAmt = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.fldrechargeAmt.leftView = paddingRechargeAmt;
    self.fldrechargeAmt.leftViewMode = UITextFieldViewModeAlways;
    self.fldrechargeAmt.layer.borderWidth = 1.3;
    self.fldrechargeAmt.layer.borderColor = textFieldBorderColor.CGColor;
    self.fldrechargeAmt.layer.cornerRadius = 5.0f;
    
    //msg Box
    //UIView *paddingmsgbox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    //self.lblMsgBox.leftView = paddingmsgbox;
   // self.lblMsgBox.leftViewMode = UITextFieldViewModeAlways;
    self.lblMsgBox.layer.borderWidth = 1.3;
    self.lblMsgBox.layer.borderColor = textFieldBorderColor.CGColor;
    self.lblMsgBox.layer.cornerRadius = 5.0f;
    

    //first name
    UIView *paddingFname = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.fldFName.leftView = paddingFname;
    self.fldFName.leftViewMode = UITextFieldViewModeAlways;
    self.fldFName.layer.borderWidth = 1.3;
    self.fldFName.layer.borderColor = textFieldBorderColor.CGColor;
    self.fldFName.layer.cornerRadius = 5.0f;
    

    //last name
    UIView *paddingLName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.fldLName.leftView = paddingLName;
    self.fldLName.leftViewMode = UITextFieldViewModeAlways;
    self.fldLName.layer.borderWidth = 1.3;
    self.fldLName.layer.borderColor = textFieldBorderColor.CGColor;
    self.fldLName.layer.cornerRadius = 5.0f;
   

    //email
    UIView *paddingMail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.fldEmail.leftView = paddingMail;
    self.fldEmail.leftViewMode = UITextFieldViewModeAlways;
    self.fldEmail.layer.borderWidth = 1.3;
    self.fldEmail.layer.borderColor = textFieldBorderColor.CGColor;
    self.fldEmail.layer.cornerRadius = 5.0f;
    
    //submit Button
    self.btnSubmit.layer.borderWidth = 1.3;
    self.btnSubmit.layer.borderColor = textFieldBorderColor.CGColor;
    self.btnSubmit.layer.cornerRadius = 5.0f;
    
    }
-(void)makeLayout_hidden{
    self.lblMsgBox.hidden=YES;
    self.fldFName.hidden=YES;
    self.lblFName.hidden=YES;
    self.fldLName.hidden=YES;
    self.lblLName.hidden=YES;
    self.fldEmail.hidden=YES;
    self.lblEmail.hidden=YES;
}
-(void)makeLayout_show{
    self.lblMsgBox.hidden=NO;
    self.fldFName.hidden=NO;
    self.lblFName.hidden=NO;
    self.fldLName.hidden=NO;
    self.lblLName.hidden=NO;
    self.fldEmail.hidden=NO;
    self.lblEmail.hidden=NO;
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
}


//for keypad hide/show
- (void)registerForKeyboardNotifications
{
    NSLog(@"registerForKeyboardNotifications");
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
    NSLog(@"keyboardWasShown");
    //NSLog(@"keyboard==%@",aNotification);
    NSDictionary* info = [aNotification userInfo];
    //NSLog(@"text y==%f",activeField.frame.origin.y);
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrPinless.contentInset = contentInsets;
    scrPinless.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrPinless setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrPinless.contentInset = contentInsets;
    scrPinless.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

//
-(BOOL)textFieldShouldReturn:(UITextField *)textField
//fldCustomerph,fldrechargeAmt,btnSubmit
{
  
    NSLog(@"textFieldShouldReturn");
    if (textField == fldCustomerph)
    {
        [fldCustomerph resignFirstResponder];
        //[self get_userDetailsByPhno];
       //[fldrechargeAmt becomeFirstResponder];
    }
             else
    {
        [textField resignFirstResponder];
    }
    
    return YES;
}
//apicall
-(void)get_userDetailsByPhno
{
    NSLog(@"get_userDetailsByPhno");
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    UserSession *getcustomerdetails = [UserAccessSession getUserSession];
    userId =getcustomerdetails.reseller_id;
    athenticationKey =getcustomerdetails.res_user_login_key;
    phoneNo=fldCustomerph.text;
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  phoneNo,@"phone",
                
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_CHECKCUSTOMERINPINLESS];
    //NSLog(@"URL====%@",URL);
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
           /* UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"successfull" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            */
           // fldCustomerph,fldrechargeAmt,btnSubmit,scrPinless,lblMsgBox,fldFName,fldLName,fldEmail,lblFName,lblLName,lblEmail;
            [self makeLayout];
            [self makeLayout_show];
            self.fldCustomerph.text=[NSString stringWithFormat:@"%@",phoneNo];
            self.lblMsgBox.text=[NSString stringWithFormat:@"  %@",[json objectForKey:@"msg"]];
            self.fldFName.text=[NSString stringWithFormat:@"%@",[json objectForKey:@"firstname"]];
            self.fldLName.text=[NSString stringWithFormat:@"%@",[json objectForKey:@"lastname"]];
             self.fldEmail.text=[NSString stringWithFormat:@"%@",[json objectForKey:@"email"]];
           
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            
            [self makeLayout];
            [self makeLayout_show];
            self.fldCustomerph.text= [NSString stringWithFormat:@"%@",phoneNo];
            self.lblMsgBox.text=[NSString stringWithFormat:@"%@",[json objectForKey:@"msg"]];
            self.fldFName.text=@""; //[NSString stringWithFormat:@"%@",[json objectForKey:@"firstname"]];
            self.fldLName.text=@""; //[NSString stringWithFormat:@"%@",[json objectForKey:@"lastname"]];
            self.fldEmail.text=@""; //[NSString stringWithFormat:@"%@",[json objectForKey:@"email"]];
           /* id superview = self.view.superview;
            [self.view removeFromSuperview];
           
            //UIView *someView
            //pinlessRechargevC2 *vc2
             UIView *someView  = [[[NSBundle mainBundle] loadNibNamed:@"pinlessRechargevC2"
                                                              owner:self
                                                            options:nil] objectAtIndex:0];
            self.view = someView;
            [superview addSubview:self.view];*/
           
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

//SubmitPinlessRecharge API
-(void)SubmitPinlessRecharge
{
    NSLog(@"SubmitPinlessRecharge");
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    UserSession *getcustomerdetails = [UserAccessSession getUserSession];
    userId =getcustomerdetails.reseller_id;
    athenticationKey =getcustomerdetails.res_user_login_key;
    phoneNo=fldCustomerph.text;
        //fldCustomerph,fldrechargeAmt,btnSubmit,scrPinless,lblMsgBox,fldFName,fldLName,fldEmail,lblFName,lblLName,lblEmail;
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  fldCustomerph.text,@"customer_phone",
                  fldrechargeAmt.text,@"amount",
                  fldFName.text,@"firstname",
                  fldLName.text,@"lastname",
                   fldEmail.text,@"email",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_SUBMITPINLESS];
   // NSLog(@"URL====%@",URL);
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
        NSString  *status = [NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
       // NSLog(@"get_userDetailsByPhno==%@",json);
        if([status isEqualToString:@"1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"successfull" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
           /* UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            recipientVC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"tabRecipient"];
            // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
            [[self navigationController] pushViewController:vc animated:YES];
            */
            
            [appDel setBothMenus];
            // fldCustomerph,fldrechargeAmt,btnSubmit,scrPinless,lblMsgBox,fldFName,fldLName,fldEmail,lblFName,lblLName,lblEmail;
            [self makeLayout];
            [self makeLayout_show];
            self.fldCustomerph.text=[NSString stringWithFormat:@"%@",phoneNo];
            self.lblMsgBox.text=[NSString stringWithFormat:@"%@",[json objectForKey:@"msg"]];
            self.fldFName.text=[NSString stringWithFormat:@"%@",[json objectForKey:@"firstname"]];
            self.fldLName.text=[NSString stringWithFormat:@"%@",[json objectForKey:@"lastname"]];
            self.fldEmail.text=[NSString stringWithFormat:@"%@",[json objectForKey:@"email"]];
            
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed " message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            
            [self makeLayout];
            [self makeLayout_show];
            self.fldCustomerph.text=[NSString stringWithFormat:@"%@",phoneNo];
            self.lblMsgBox.text=[NSString stringWithFormat:@"%@",[json objectForKey:@"msg"]];
            self.fldFName.text=[NSString stringWithFormat:@"%@",[json objectForKey:@"firstname"]];
            self.fldLName.text=[NSString stringWithFormat:@"%@",[json objectForKey:@"lastname"]];
            self.fldEmail.text=[NSString stringWithFormat:@"%@",[json objectForKey:@"email"]];
            /* id superview = self.view.superview;
             [self.view removeFromSuperview];
             
             //UIView *someView
             //pinlessRechargevC2 *vc2
             UIView *someView  = [[[NSBundle mainBundle] loadNibNamed:@"pinlessRechargevC2"
             owner:self
             options:nil] objectAtIndex:0];
             self.view = someView;
             [superview addSubview:self.view];*/
            
        }
        
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // [[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed " message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}
- (IBAction)submitBtnAction:(id)sender {
    NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];

if(![fldCustomerph.text isEqualToString:@""]|| ![fldrechargeAmt.text isEqualToString:@""]){
    
        //Phone Number
    /*
     if([self.fldCustomerph.text isEqualToString:@""]|| [numerictest evaluateWithObject:self.fldCustomerph.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Phone Number should not be blank and must be number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    */
    //amount
     if([fldrechargeAmt.text isEqualToString:@""]|| [numerictest evaluateWithObject:self.fldrechargeAmt.text] == NO){
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter amount" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
         [alert show];
     }
    

    else if([fldFName.text isEqualToString:@""] || [numerictest evaluateWithObject:fldFName.text] == YES){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter first Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //lastname
    else if([fldLName.text isEqualToString:@""] || [numerictest evaluateWithObject:fldLName.text] == YES){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter last Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //email
    else if([fldEmail.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    
    else if ([emailTest evaluateWithObject:fldEmail.text] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else{
            [self SubmitPinlessRecharge];
        
    }
}
else{
    
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Phone Number and Amount is required" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];

 }

}

//for focus out
/*- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    [_getpwd resignFirstResponder];
    if ([[touch.view class] isSubclassOfClass:[UITableView class]])
    {
        [_getpwd resignFirstResponder];
        [self.view endEditing:YES];
    }
}*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
