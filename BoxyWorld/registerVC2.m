//
//  registerVC2.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 13/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "registerVC2.h"
#import "registerVC1.h"
#import "UserAccessSession.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "config.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

@interface registerVC2 ()
{
    AppDelegate *appDel;
    MBProgressHUD *hud;
    NSString *turm;
}

@end

@implementation registerVC2

@synthesize scrVwregVC2,city,address,zipcode,busnessName,cPassword,password,turmsBtn,btnBack;
@synthesize fname,lname,email,country,phno,state;
bool btnToggle;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"phone no==%@",phno);
    
     [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mobileBg.png"]]];
    // Do any additional setup after loading the view.
    turm=@"false";
    //city
     UIView *paddingCity = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    city.leftView = paddingCity;
    city.leftViewMode = UITextFieldViewModeAlways;
    city.layer.cornerRadius=8.0f;
    city.layer.masksToBounds=YES;
    city.layer.borderColor=[[UIColor whiteColor]CGColor];
    city.layer.borderWidth= 1.0f;
     city.delegate=self;
    
    //address
     UIView *paddingAddrs = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    address.leftView = paddingAddrs;
    address.leftViewMode = UITextFieldViewModeAlways;
    address.layer.cornerRadius=8.0f;
    address.layer.masksToBounds=YES;
    address.layer.borderColor=[[UIColor whiteColor]CGColor];
    address.layer.borderWidth= 1.0f;
     address.delegate=self;
    
    //zipcode
    UIView *paddingZip = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    zipcode.leftView = paddingZip;
    zipcode.leftViewMode = UITextFieldViewModeAlways;
    zipcode.layer.cornerRadius=8.0f;
    zipcode.layer.masksToBounds=YES;
    zipcode.layer.borderColor=[[UIColor whiteColor]CGColor];
    zipcode.layer.borderWidth= 1.0f;
    zipcode.delegate=self;
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
    self.zipcode.inputAccessoryView = accessoryView;

    
    //Busnessname
     UIView *paddingBusnessname = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    busnessName.leftView = paddingBusnessname;
    busnessName.leftViewMode = UITextFieldViewModeAlways;
    busnessName.layer.cornerRadius=8.0f;
    busnessName.layer.masksToBounds=YES;
    busnessName.layer.borderColor=[[UIColor whiteColor]CGColor];
    busnessName.layer.borderWidth= 1.0f;
    busnessName.delegate=self;
    
    //Conferm Password
    UIView *paddingCPassword = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
     cPassword.leftView = paddingCPassword;
     cPassword.leftViewMode = UITextFieldViewModeAlways;
    cPassword.layer.cornerRadius=8.0f;
    cPassword.layer.masksToBounds=YES;
    cPassword.layer.borderColor=[[UIColor whiteColor]CGColor];
    cPassword.layer.borderWidth= 1.0f;
    cPassword.delegate=self;
    
    //password
     UIView *paddingPassword = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    password.leftView = paddingPassword;
    password.leftViewMode = UITextFieldViewModeAlways;
    password.layer.cornerRadius=8.0f;
    password.layer.masksToBounds=YES;
    password.layer.borderColor=[[UIColor whiteColor]CGColor];
    password.layer.borderWidth= 1.0f;
    password.delegate=self;
    
    turmsBtn.layer.cornerRadius = 5;//(turmsBtn.frame.size.width / 2);
     self.btnBack.layer.cornerRadius = 5.0f;
    [self barButtonFunction];
    
    [self registerForKeyboardNotifications];
    
}
- (void)selectDoneButton {
    [self.zipcode resignFirstResponder];
    //[self.txtAltrPhone resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}
- (IBAction)turmsBtnTab:(id)sender {
    
    btnToggle = !btnToggle;
   
    if(btnToggle){
        turm=@"true";
        [self.turmsBtn setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];

    //[turmsBtn setBackgroundColor:[UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0]];
    }
    else{
         turm=@"false";
        //[turmsBtn setBackgroundColor:[UIColor whiteColor]];
         [self.turmsBtn setBackgroundImage:[UIImage imageNamed:@"whiteCheckBox"] forState:UIControlStateNormal];
    }
}


- (IBAction)submitBtnTab:(id)sender {
    NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
  
    //city
    if([city.text isEqualToString:@""] || [numerictest evaluateWithObject:city.text] == YES){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"City name should not be Blank" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //address
    else if([address.text isEqualToString:@""] || [self validatePhone:address.text]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Address should not be Blank" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
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
       /* NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        registerVC2 * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"register2"];
        [self.navigationController pushViewController:vc2 animated:YES];*/
            }

    
}
//validation phone no
- (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:phoneNumber];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)doRegistation{
    
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
        NSLog(@"first name ===%@",phno);
    
   
    NSDictionary *parameters;
    __block NSDictionary* json;
       parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                              fname,@"firstname",
                               lname,@"lastname",
                                email,@"email",
                                country,@"country",
                                phno,@"phone",
                                state,@"state",
                                city.text,@"city",
                                zipcode.text,@"zipcode",
                                busnessName.text,@"business_name",
                                password.text,@"password",
                                cPassword.text,@"cpassword",
                                password.text,@"address",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_REGISTER];
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
        
        NSLog(@"responseObject---%@",json);
         NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[json objectForKey:@"msg"]delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
           // [appDel setBothMenus];
        }
        else{
            registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
            [[self navigationController] pushViewController:vc animated:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
        }
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        [[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
    
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
    [self.navigationController popViewControllerAnimated:YES];
    //[appDel setBothMenus];
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
    scrVwregVC2.contentInset = contentInsets;
    scrVwregVC2.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrVwregVC2 setContentOffset:scrollPoint animated:YES];
    }
    
    
    
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrVwregVC2.contentInset = contentInsets;
    scrVwregVC2.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

//
-(BOOL)textFieldShouldReturn:(UITextField *)textField
//city,address,zipcode,busnessName,cPassword,password,
{
    //[textField resignFirstResponder];
    NSLog(@"textFieldShouldReturn");
    if (textField == city)
    {
        [city resignFirstResponder];
        [address becomeFirstResponder];
    }
    else if (textField == address){
        [address resignFirstResponder];
        [zipcode becomeFirstResponder];
    }
    else if (textField == zipcode){
        [zipcode resignFirstResponder];
        [busnessName becomeFirstResponder];
    }
    else if (textField == busnessName){
        [busnessName resignFirstResponder];
        [cPassword becomeFirstResponder];
    }
     else if (textField == cPassword){
     
     
     [cPassword resignFirstResponder];
      [password becomeFirstResponder];
     
     }
     else if (textField == password){
         
         
         [password resignFirstResponder];
         //[password becomeFirstResponder];
         
     }
    else
    {
        [textField resignFirstResponder];
    }
    
    return YES;
}
- (IBAction)btnTabBack:(id)sender {
    
    registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
    // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
    [[self navigationController] pushViewController:vc animated:YES];
}


@end

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



