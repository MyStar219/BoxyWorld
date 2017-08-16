//
//  addMobileNoVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 17/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "addMobileNoVC.h"
#import "config.h"
#import "AppDelegate.h"
#import "newRecipientVC.h"
#import "addMobileNoVC.h"
#import "addBankVC.h"
#import "SWRevealViewController.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "recipientVC.h"
@interface addMobileNoVC ()<UIScrollViewDelegate,KPDropMenuDelegate>
{
    NSString *userId,*athenticationKey,*country_Id,*customer_id,*contact_id,*partner_id,*recipientId;
     AppDelegate *appDel;
     MBProgressHUD *hud;
}
@end

@implementation addMobileNoVC
@synthesize txtAddPhNo,btnAddPhNo;
- (void)viewDidLoad {
     appDel = [AppDelegate instance];
    [super viewDidLoad];
    
     [self barButtonFunction];
     [self makeLayout];
   // [self.navigationController.navigationBar setTitleTextAttributes:
     //@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
     //[self.navigationController.navigationBar setBarTintColor:navigationBarColor];
    
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
    self.txtAddPhNo.inputAccessoryView = accessoryView;

}
- (void)selectDoneButton {
    [self.txtAddPhNo resignFirstResponder];
}
-(void)makeLayout{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
   [self setTitle:@"Add New Mobile "];
    
    UIView *paddingMobile = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtAddPhNo.leftView = paddingMobile;
    txtAddPhNo.leftViewMode = UITextFieldViewModeAlways;
    txtAddPhNo.delegate=self;
    self.txtAddPhNo.layer.borderWidth = 1.3;
    self.txtAddPhNo.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtAddPhNo.layer.cornerRadius = 5.0f;
    
      self.btnAddPhNo.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnAddPhNo.layer.cornerRadius = 5.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//for nevigation bar
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
     //[appDel setBothMenus];
    [self.navigationController popViewControllerAnimated:YES];
}

//add mobile no api
-(void)addmonileNo
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
    //country_Id =addCustomer.sentMoney_CountyID;
    // contact_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"optionID"];
    recipientId = [[NSUserDefaults standardUserDefaults] objectForKey:@"recipientId"];
    partner_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"partnerTD"];
    NSLog(@"customer Id=====%@",addCustomer.customer_id);
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  customer_id,@"customer_id",
                 recipientId,@"contact_id",
                  partner_id,@"partner_id",
                txtAddPhNo.text,@"phone",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETADDMOBILENUMBER];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // NSLog(@"URL==%@",URL);
    NSLog(@"parameters add mobile==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"add mobile==%@",json);
        NSString  *status = [NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        NSLog(@"get_userDetailsByPhno==%@",json);
        if([status isEqualToString:@"1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"successfull" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            recipientVC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"tabRecipient"];
            // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
            [[self navigationController] pushViewController:vc animated:YES];
        }
        else{
           
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                [alert show];
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
- (IBAction)btnActiobAddContact:(id)sender {
    NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
     if([txtAddPhNo.text isEqualToString:@""]|| [numerictest evaluateWithObject:txtAddPhNo.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Phone Number should not be blank and must be number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }

    else{
        [self addmonileNo];
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
