//
//  forgetPasswordVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 27/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "forgetPasswordVC.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "ViewController.h"

@interface forgetPasswordVC ()
{
     MBProgressHUD *hud;
}

@end

@implementation forgetPasswordVC
@synthesize fldEmail,btnResetPwd,btnBack;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeLayout];
    [self registerForKeyboardNotifications];
    [self.navigationController setNavigationBarHidden:YES];
    
    // Do any additional setup after loading the view.
    //(button color code)[UIColor colorWithRed:1.00 green:0.59 blue:0.00 alpha:1.0];
}
-(void)makeLayout{
    
    //self.title = @"REVIEW";
    //[self.navigationController.navigationBar setTitleTextAttributes:
    // @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIView *paddingUserEmail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    fldEmail.leftView = paddingUserEmail;
    fldEmail.leftViewMode = UITextFieldViewModeAlways;
    fldEmail.layer.cornerRadius=8.0f;
    fldEmail.layer.masksToBounds=YES;
    fldEmail.layer.borderColor=[[UIColor whiteColor]CGColor];
    fldEmail.layer.borderWidth= 1.0f;
    fldEmail.delegate =self;
    
    //self.btnSubmit.layer.borderWidth = 1.0;
    [btnResetPwd setBackgroundColor:[UIColor colorWithRed:1.00 green:0.59 blue:0.00 alpha:1.0]];
    self.btnResetPwd.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnResetPwd.layer.cornerRadius = 6.0f;
    
    self.btnBack.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnBack.layer.cornerRadius = 6.0f;
    NSLog(@"testttttt=======");
}

-(void)forgetPass
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  fldEmail.text,@"email",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_FORGOTPASSWORD];
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
         NSLog(@"parameters==%@",json);
        NSString *status =[NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"successfull" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
        }
                
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        
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
    self.scrforgetPWD.contentInset = contentInsets;
     self.scrforgetPWD.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [ self.scrforgetPWD setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
     self.scrforgetPWD.contentInset = contentInsets;
     self.scrforgetPWD.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

//
-(BOOL)textFieldShouldReturn:(UITextField *)textField


{
    NSLog(@"textFieldShouldReturn");
        [textField resignFirstResponder];
    
    return YES;
}
- (IBAction)btnActionResetPWD:(id)sender {
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    //email
     if([fldEmail.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    
    else if ([emailTest evaluateWithObject:fldEmail.text] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else{
        [self forgetPass];
    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnTabBack:(id)sender {
    ViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"loginSB"];
    // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
