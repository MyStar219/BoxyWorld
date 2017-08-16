//
//  ViewController.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 10/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "leftMenuVC.h"
#import "AppDelegate.h"
#import "config.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "forgetPasswordVC.h"

@interface ViewController ()<SWRevealViewControllerDelegate,UIGestureRecognizerDelegate>
{
    AppDelegate *appDel;
     UserSession *userSession;
    MBProgressHUD *hud;
}
@end

@implementation ViewController
@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize username,password,lblforgetPWD;
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO];
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mobileBg.png"]]];
    appDel = [AppDelegate instance];
    
    
    UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    username.leftView = paddingUserName;
    username.leftViewMode = UITextFieldViewModeAlways;
    username.layer.cornerRadius=8.0f;
    username.layer.masksToBounds=YES;
    username.layer.borderColor=[[UIColor whiteColor]CGColor];
    username.layer.borderWidth= 1.0f;
    username.delegate =self;
    //Password
    UIView *paddingLoginPW = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    password.leftView = paddingLoginPW;
    password.leftViewMode = UITextFieldViewModeAlways;
    password.layer.cornerRadius=8.0f;
    password.layer.masksToBounds=YES;
    password.layer.borderColor=[[UIColor whiteColor]CGColor];
    password.layer.borderWidth= 1.0f;
    password.delegate=self;
    
    lblforgetPWD.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(goToUserKaveWithId:)];
    tapGesture1.numberOfTapsRequired = 1;
    [tapGesture1 setDelegate:self];
    [lblforgetPWD addGestureRecognizer:tapGesture1];
    
    
    [self.navigationController.navigationBar setBarTintColor:navigationBarColor];
   // [self registerForKeyboardNotifications];
   
    // Do any additional setup after loading the view, typically from a nib.
    _theTextField.returnKeyType = UIReturnKeyDone;
    [_theTextField setDelegate:self];
}
- (void) goToUserKaveWithId:(UITapGestureRecognizer *)tapRecognizer
{
    NSLog(@"tapRecognizer");
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    forgetPasswordVC * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"SBforgetpwd"];
    [self.navigationController pushViewController:vc2 animated:YES];
}

- (IBAction)loginTaped:(id)sender {
    NSLog(@"hello");
   
    
    
    if([username.text isEqualToString:@""] || [password.text isEqualToString:@""])
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter Email/Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];

    }
    else
    {
        hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text =@"Please Wait";
        
        [self.view addSubview:hud];
        [self.view setUserInteractionEnabled:NO];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",password.text] forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSDictionary *parameters;
        __block NSDictionary* json;
        parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  username.text,@"email",
                  password.text,@"password",
                  nil];
        NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_LOGIN];
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
            NSLog(@"responseObject---%@",json);
            NSString* status = [NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
            
            if([status isEqualToString:@"1"]){
                NSString *Authentication_key = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"res_user_login_key"]];
                NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
                // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
                NSLog(@"Authentication_key---%@",Authentication_key);
                NSLog(@"status==%@",status);
                
                
                UserSession* session = [UserSession new];
                session.previousController = @"login";
                session.reseller_id = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_id"]];
                session.reseller_firstname =[NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_firstname"]];
                session.reseller_lastname =[NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_lastname"]];
                session.reseller_email = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_email"]];
                
                session.profile_pic = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"profile_pic"]];

                session.res_user_login_key = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"res_user_login_key"]];

                session.reseller_logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];

                session.user_role = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"user_role"]];
                
                 session.parent_id = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"parent_id"]];
                 session.pinless_active = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"pinless_active"]];
                 session.imtu_active = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"imtu_active"]];
                 session.sendmoney_active = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"sendmoney_active"]];
                session.reseller_password = password.text;

                [UserAccessSession storeUserSession:session];
       
             
                
               /* [[NSUserDefaults standardUserDefaults] setObject:username.text  forKey:@"UserLoginIdSession"];
                 [[NSUserDefaults standardUserDefaults] setObject:Authentication_key forKey:@"Authentication_key"];
                [[NSUserDefaults standardUserDefaults] setObject:password.text forKey:@"PasswordSession"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                NSString *str1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserLoginIdSession"];
                NSString *str2 = [[NSUserDefaults standardUserDefaults] valueForKey:@"Authentication_key"];
                 NSString *str3 = [[NSUserDefaults standardUserDefaults] valueForKey:@"PasswordSession"];
                NSLog(@"user==%@",str1);
                NSLog(@"Authentication_key==%@",str2);
                NSLog(@"userid==%@",str3);*/
             [appDel setBothMenus];
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
            ViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"loginSB"];
            // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
            [[self navigationController] pushViewController:vc animated:YES];
        }];
    }
    //return json;
    

  
    //NSURL *URL = URL_LOGIN;
   /* AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }]; */
    
   
    /*

    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    registerVC1 * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"main_screen"];
    [self.navigationController pushViewController:vc1 animated:YES];
     */
}
- (IBAction)registerBtnTab:(id)sender {
    NSLog(@"hello");
     /*NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    registerVC1 * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
     [self.navigationController pushViewController:vc2 animated:YES];
   
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    registerVC1 * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
    self.window.rootViewController = vc1;
    [self.window makeKeyAndVisible];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    registerVC1 *ivc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
    [(UINavigationController*)self.window.rootViewController presentViewController:ivc animated:NO completion:nil];
    */
    /*
    registerVC1 *loginVCObj =[[registerVC1 alloc]initWithNibName:@"registation1" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVCObj];
    [self presentViewController:nav animated:YES completion:nil];*/
    
   /* NSString * storyboardName = @"Main";
    NSString * viewControllerID = @"registation1";
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    registerVC1 * controller = (registerVC1 *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
    [self presentViewController:controller animated:YES completion:nil];*/
    
    registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
    // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
    [[self navigationController] pushViewController:vc animated:YES];
    
}
-(void)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
}
/*- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
