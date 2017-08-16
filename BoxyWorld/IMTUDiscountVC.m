//
//  IMTUDiscountVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 10/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "IMTUDiscountVC.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"

@interface IMTUDiscountVC ()
{
    AppDelegate *appDel;
     MBProgressHUD *hud;
    NSString *amountDeliver;
     NSString *phFormat;
    NSString *userId ;
    NSString *athenticationKey;
    
   

}
@end

@implementation IMTUDiscountVC
@synthesize lblCountry,lblPhno,lblNetwork,lblActualAmt,lblDiscount,lblCommisn,lblAmtWillDebit,LocalAmtDelivr,btnBack,btnSUBMIT;
@synthesize country,phnoe,actualAmt,network_Id,networkMethod,country_Id,discountIMTU,willCollectFrmU,network_name,phonePre,countryCode;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
      self.title = @"IMTU Discount";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self barButtonFunction];
   
    [self makeLayout];
     [self get_localAmount];
  
    appDel = [AppDelegate instance];
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //country,phnoe,actualAmt,network_Id,networkMethod,country_Id,discountIMTU,willCollectFrmU;
    NSLog(@"discountIMTU%@",discountIMTU);
     NSLog(@"willCollectFrmU%@",willCollectFrmU);
     NSLog(@"amountDeliver%@",amountDeliver);
    NSString *simble=@"%";
    lblCountry.text = country;
    lblPhno.text = phnoe;
    lblNetwork.text = network_name;
    lblActualAmt.text = [NSString stringWithFormat:@"$%@",actualAmt];
    lblDiscount.text = [NSString stringWithFormat:@"%@ %@",discountIMTU,simble];
    lblCommisn.text = @"$0.00";
    lblAmtWillDebit.text = [NSString stringWithFormat:@"$%@",willCollectFrmU];;
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)makeLayout{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
      btnBack.layer.borderWidth = 1.0;
    btnBack.layer.borderColor = [UIColor clearColor].CGColor;
    btnBack.layer.cornerRadius = 6.0f;
    
    btnSUBMIT.layer.borderWidth = 1.0;
    btnSUBMIT.layer.borderColor = [UIColor clearColor].CGColor;
    btnSUBMIT.layer.cornerRadius = 6.0f;
}
//Back Button Action
- (IBAction)btnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)IMTUsubmitAction:(id)sender {
    [self loadIMTU];
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
    //[appDel setBothMenus];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)get_localAmount
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
  
    phFormat =[NSString stringWithFormat:@"%@%@",phonePre,phnoe];
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  @"1",@"getExchangeRate",
                  phFormat,@"phone",
                  country_Id,@"country",
                  network_Id,@"operator",
                  actualAmt,@"rechargeAmount",
                  networkMethod,@"topup_method",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@",URL_GETRECHARGEDTLS];
    NSLog(@"URL=discount===%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL=local delivert=%@",URL);
    NSLog(@"local delivert==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"get local delivert%@",json);
        NSString *status1=[NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        
        //**********alert
        if([status1 isEqualToString:@"success"]){
            NSLog(@"status1==%@",status1);
             amountDeliver = [NSString stringWithFormat:@"%@",[json objectForKey:@"AMOUNT_DELIVERED"]];
            NSLog(@"amountDeliver%@",amountDeliver);
             LocalAmtDelivr.text = amountDeliver;
            
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
//submission IMTU recharge
-(void)loadIMTU
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
                  phnoe,@"phone",
                 network_Id,@"network",
                  actualAmt,@"amount",
                  phonePre,@"country_prefix",
                  actualAmt,@"org_amount",
                   networkMethod,@"topup_method",
                   @"boxypay",@"pay_with",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_DOTOPUP];
    //NSLog(@"URL=discount===%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //NSLog(@"URL=local delivert=%@",URL);
   // NSLog(@"local delivert==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        //NSLog(@"get local delivert%@",json);
        NSString *status1=[NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        
        //**********alert
        if([status1 isEqualToString:@"1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            [appDel setBothMenus];
            
           // NSLog(@"statusIMTULOAD==%@",status1);
           // amountDeliver = [NSString stringWithFormat:@"%@",[json objectForKey:@"AMOUNT_DELIVERED"]];
            //NSLog(@"amountDeliver%@",amountDeliver);
           // LocalAmtDelivr.text = amountDeliver;
            
        }
        else{
            //NSLog(@"status.......NOT LOAD==%@",status1);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
