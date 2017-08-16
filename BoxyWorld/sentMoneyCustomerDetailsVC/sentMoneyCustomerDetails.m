//
//  sentMoneyCustomerDetails.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 06/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "sentMoneyCustomerDetails.h"
#import "config.h"
#import "exploreVC.h"
#import "recipientVC.h"
#import "UserAccessSession.h"
#import "SWRevealViewController.h"
#import "reviewVC.h"
#import "paymentVC.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
@interface sentMoneyCustomerDetails ()
{
     MBProgressHUD *hud;
    UserAccessSession *sessions;
    NSString *countrycode,*stateCode;
    NSString *countryName,*stateName;
}

@end

@implementation sentMoneyCustomerDetails
@synthesize name,lblEmail,lblPhone,lblAddress,lblZipCode,lblState,lblCountry,lblCity,imgGovernment,btnSendMoney;
@synthesize customerListArr;
@synthesize tabController;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"customerListArr=%@",customerListArr);
   countrycode= [NSString stringWithFormat:@"%@",[customerListArr valueForKey:@"country"]];
    stateCode = [NSString stringWithFormat:@"%@",[customerListArr valueForKey:@"state"]];
    NSLog(@"countrycode=%@",countrycode);
     NSLog(@"stateCode=%@",stateCode);
    [self getCountryName];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"customerListArr===%@,customerListArrCount--%d",customerListArr,[customerListArr count]);
     NSLog(@"customerListArr===%@",customerListArr);
        self.title = @"Send Money Details";
        btnSendMoney.layer.cornerRadius = 5.0f;
        [self barButtonFunction];
    
    //UserSession* customer_session = [UserSession new];
   // customer_session.previousController = @"login";
    //@synthesize customer_id,customer_Name,customer_email,customer_phNo,customer_address,customer_zip,customer_state,customer_country,customer_city;
    
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
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSendMoneyAction:(id)sender {
    
    
   // SecondViewController *secondTab = [[SecondViewController alloc] init];
    exploreVC *firstTab = [self.storyboard instantiateViewControllerWithIdentifier:@"tabExplore"];
     recipientVC *secondTab = [self.storyboard instantiateViewControllerWithIdentifier:@"tabRecipient"];
    
    paymentVC *thirdTab = [self.storyboard instantiateViewControllerWithIdentifier:@"tabPayment"];
    reviewVC *fourthTab = [self.storyboard instantiateViewControllerWithIdentifier:@"tabreview"];
    firstTab.title = @"EXPLORE"; //TabTitle
    firstTab.tabBarItem.image = [UIImage imageNamed:@"ic5.png"];
    secondTab.title = @"RECIPIENT"; //TabTitle
    secondTab.tabBarItem.image = [UIImage imageNamed:@"ic6"];
    
    thirdTab.title = @"PAYMENT"; //TabTitle
    thirdTab.tabBarItem.image = [UIImage imageNamed:@"ic7.png"];
    
    fourthTab.title = @"REVIEW"; //TabTitle
    fourthTab.tabBarItem.image = [UIImage imageNamed:@"ic8.png"];
    
    tabController = [[UITabBarController  alloc] init];
    tabController.viewControllers = [[NSArray  alloc] initWithObjects:firstTab,secondTab,thirdTab,fourthTab, nil];//secondTab
    
    [tabController setSelectedIndex:0];
    [self.navigationController pushViewController:tabController animated:YES];
    //[self presentViewController:tabController animated:YES completion:NULL];
    /*NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    exploreVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"tabExplore"];
    [revealController pushFrontViewController:frontNavigationController animated:YES];
     */
}

-(void)getCountryName
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETCOUNTRY];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==%@",URL);
    // NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        //NSString *status= [json objectForKey:@"status"];
        //if([status isEqualToString:@"1"]){
            
        
        NSMutableArray *allcountryArr = [[NSMutableArray alloc]init];
        allcountryArr = [[json objectForKey:@"data"]objectForKey:@"countries"];
        
        NSLog(@"allcountryArr==%@",allcountryArr);
        
        for (int i=0; i<[allcountryArr count]; i++) {
            NSString *cname = [NSString stringWithFormat:@"%@",[[allcountryArr objectAtIndex:i]objectForKey:@"id"]];
            if([cname isEqualToString:[NSString stringWithFormat:@"%@",countrycode]]){
            countryName = [[allcountryArr objectAtIndex:i]objectForKey:@"countryname"];
               
            }
        }
         NSLog(@"countryName=%@",countryName);
        [self getStateName];
            
            
       // }
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        
        json = nil;
        
    }];
}

-(void)getStateName
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  countrycode,@"country_id",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETSTATES];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URLURL--==%@",URL);
    NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"stateresponseObject---%@",json);
        
        NSMutableArray *allstateArr = [[NSMutableArray alloc]init];
        allstateArr = [[json objectForKey:@"data"]objectForKey:@"states"];
          for (int j=0; j<[allstateArr count]; j++) {
              NSString *sName = [NSString stringWithFormat:@"%@",[[allstateArr objectAtIndex:j]objectForKey:@"id"]];
              if([sName isEqualToString:[NSString stringWithFormat:@"%@",stateCode]]){
              stateName = [[allstateArr objectAtIndex:j]objectForKey:@"state_name"];
           
              }
          }
         NSLog(@"stateName=%@",stateName);
        [self getData];
        }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}

-(void)getData{
    
     UserSession *session = [UserAccessSession getUserSession];
    
    session.customer_id = [NSString stringWithFormat:@"%@",[customerListArr valueForKey:@"id"]];
    session.customer_Name =[NSString stringWithFormat:@"%@",[customerListArr valueForKey:@"customerName"]];
    
    session.customer_email =[NSString stringWithFormat:@"%@",[customerListArr valueForKey:@"email"]];
    
    session.customer_phNo = [NSString stringWithFormat:@"%@",[customerListArr valueForKey:@"phNo"]];
    
    session.customer_address = [NSString stringWithFormat:@"%@",[customerListArr valueForKey:@"address"]];
    
    session.customer_zip =[NSString stringWithFormat:@"%@",[customerListArr valueForKey:@"zip"]];
    
    session.customer_state = [NSString stringWithFormat:@"%@",stateName];//[customerListArr valueForKey:@"state"]];
    
    session.customer_country = [NSString stringWithFormat:@"%@",countryName];//[customerListArr valueForKey:@"country"]];
    
    session.customer_city = [NSString stringWithFormat:@"%@",[customerListArr valueForKey:@"city"]];
    
    [UserAccessSession storeUserSession:session];
    
    NSLog(@"=====IDDD==%@",[NSString stringWithFormat:@"%@",[customerListArr valueForKey:@"id"]]);
    NSLog(@"session USER ID==%@", session.customer_id);
    
    
    name.text = [customerListArr valueForKey:@"customerName"];
    lblEmail.text = [customerListArr valueForKey:@"email"];
    lblPhone.text = [customerListArr valueForKey:@"phNo"];
    lblAddress.text = [customerListArr valueForKey:@"address"];
    lblZipCode.text = [customerListArr valueForKey:@"zip"];
    lblState.text = [NSString stringWithFormat:@"%@",stateName];//[customerListArr valueForKey:@"state"];
    lblCountry.text =[NSString stringWithFormat:@"%@",countryName];//[customerListArr valueForKey:@"country"];
    lblCity.text = [customerListArr valueForKey:@"city"];
    
    /* name.text = @"";
     lblEmail.text = @"";
     lblPhone.text = @"";
     lblAddress.text = @"";
     lblZipCode.text = @"";
     lblState.text = @"";
     lblCountry.text = @"";
     lblCity.text = @"";
     */
    
    NSString *customerImg = [[customerListArr valueForKey:@"customerPhotos"] isKindOfClass:[NSNull class]]?@"":[customerListArr valueForKey:@"customerPhotos"];
    //NSLog(@"imageName%d---%@",indexPath.row,customerImg);
    
    if(![customerImg isEqualToString:@""])
    {
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@",customerImg]];;
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse * response,
                                                   NSData * data,
                                                   NSError * error) {
                                   if (!error){
                                       UIImage  *image = [[UIImage alloc] initWithData:data];
                                       NSLog(@"customer image789456==%@",image);
                                       //[cell.customerImg setImage:image];
                                       imgGovernment.layer.cornerRadius = imgGovernment.frame.size.width / 2;
                                       imgGovernment.clipsToBounds = YES;
                                       
                                       [imgGovernment setImage:image];
                                   }
                                   else{
                                       imgGovernment.layer.cornerRadius = imgGovernment.frame.size.width / 2;
                                       imgGovernment.clipsToBounds = YES;
                                       // [cell.profileImage setImage:[UIImage imageNamed:@"userIcon"]];
                                       [imgGovernment setImage:[UIImage imageNamed:@"01_logo_screen-1.png"]];
                                   }
                                   
                               }];
        
        
    }
    else{
        
        [imgGovernment setImage:[UIImage imageNamed:@"01_logo_screen-1.png"]];
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
