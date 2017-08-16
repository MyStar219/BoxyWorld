//
//  changePwdVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 27/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "changePwdVC.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"

@interface changePwdVC ()<UITextFieldDelegate>
{
     MBProgressHUD *hud;
     AppDelegate *appDel;
    NSString *userId;
    NSString *athenticationKey;
    NSString *oldPassword;
}

@end

@implementation changePwdVC
@synthesize fldOldPwd,fldNewPwd,fldConfrmPwd,btnChangePwd,viewCP;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeLayout];
    [self barButtonFunction];
     appDel = [AppDelegate instance];
    _theTextField.returnKeyType = UIReturnKeyDone;
    [_theTextField setDelegate:self];

    // Do any additional setup after loading the view.
}
-(void)makeLayout{
    
    self.title = @"Change Password";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIView *paddingfldOldPwd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    fldOldPwd.leftView = paddingfldOldPwd;
    fldOldPwd.leftViewMode = UITextFieldViewModeAlways;
    fldOldPwd.layer.cornerRadius=8.0f;
    fldOldPwd.layer.masksToBounds=YES;
    fldOldPwd.layer.borderColor=[[UIColor grayColor]CGColor];
    fldOldPwd.layer.borderWidth= 1.0f;
    fldOldPwd.delegate =self;
    
    UIView *paddingfldNewPwd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    fldNewPwd.leftView = paddingfldNewPwd;
    fldNewPwd.leftViewMode = UITextFieldViewModeAlways;
    fldNewPwd.layer.cornerRadius=8.0f;
    fldNewPwd.layer.masksToBounds=YES;
    fldNewPwd.layer.borderColor=[[UIColor grayColor]CGColor];
    fldNewPwd.layer.borderWidth= 1.0f;
    fldNewPwd.delegate =self;
    
    UIView *paddingConfrmPwd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    fldConfrmPwd.leftView = paddingConfrmPwd;
    fldConfrmPwd.leftViewMode = UITextFieldViewModeAlways;
    fldConfrmPwd.layer.cornerRadius=8.0f;
    fldConfrmPwd.layer.masksToBounds=YES;
    fldConfrmPwd.layer.borderColor=[[UIColor grayColor]CGColor];
    fldConfrmPwd.layer.borderWidth= 1.0f;
    fldConfrmPwd.delegate =self;
    
    //self.btnSubmit.layer.borderWidth = 1.0;
    //[btnChangePwd setBackgroundColor:[UIColor colorWithRed:1.00 green:0.59 blue:0.00 alpha:1.0]];
    self.btnChangePwd.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnChangePwd.layer.cornerRadius = 6.0f;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    
    return YES;
}
-(void)changePassword
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *changePwd = [UserAccessSession getUserSession];
    userId =changePwd.reseller_id;
    athenticationKey =changePwd.res_user_login_key;
    oldPassword =changePwd.reseller_password;
    NSLog(@"oldPassword==%@",changePwd.reseller_password);
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  fldNewPwd.text,@"password",
                  fldConfrmPwd.text,@"cpassword",
                   fldOldPwd.text,@"old_password",
                                   nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_CHANGEPASSWORD];
    NSLog(@"summaryURL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"summaryParameter====%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        
        NSLog(@"change password json %@",json);
        
        NSString *status = [NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"successfull" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            [appDel setBothMenus];
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsuccessfull" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        //[[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}


- (IBAction)btnActionChangePwd:(id)sender {
    
    //old password
    if([fldOldPwd.text isEqualToString:@""])  {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:@"Enter old Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    /*else if(![fldOldPwd.text isEqualToString:[NSString stringWithFormat:@"%@",oldPassword]]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:@"Enter old Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }*/
    //new password
    else if([fldNewPwd.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:@"Enter New Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //cornfirm password
    else if([fldConfrmPwd.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:@"Re-enter Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if(![fldConfrmPwd.text isEqualToString:[NSString stringWithFormat:@"%@",fldNewPwd.text]]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:@"Re-enter Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else{
        [self changePassword];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
