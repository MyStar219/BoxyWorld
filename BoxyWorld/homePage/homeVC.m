//
//  homeVC.m
//  BoxyWorld
//
//  Created by Sambaran DAS on 15/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//
#import "addFundsvC.h"
#import "homeVC.h"
#import "config.h"
#import "SWRevealViewController.h"
#import "customerListVC.h"
#import "addCustomerVC.h"
#import "headerview.h"
#import "UserAccessSession.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "sendMoneyCustomerList.h"
#import "sentMoneyTableViewCell.h"
#import "pinlessRechervC.h"
#import "IMTUrechargeVC.h"

@interface homeVC ()<UITableViewDelegate,UITableViewDataSource>{
     MBProgressHUD *hud;
    NSString *currentBlnc;
    NSString *userId ;
    NSString *athenticationKey ;
    //NSMutableDictionary *dict1 ;
}

@end

@implementation homeVC
@synthesize myListTableView;
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
     mylistingArray = [[NSMutableArray alloc]init];
    
    [self getDashBoardData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //dict1 = [[NSMutableDictionary alloc]init];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mobileBg.png"]]];
    //headerViewObj = [[headerview alloc]initWithNibName:@"View" bundle:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
    
    
    
    //NSLog(@"mylistingArray==%@",mylistingArray);
    
    [myListTableView registerNib:[UINib nibWithNibName:@"sentMoney" bundle:nil] forCellReuseIdentifier:@"sentMoney"];
    [myListTableView registerNib:[UINib nibWithNibName:@"headerView" bundle:nil] forCellReuseIdentifier:@"headerView"];
    [myListTableView registerNib:[UINib nibWithNibName:@"addfunds" bundle:nil] forCellReuseIdentifier:@"addfunds"];
    
    
    myListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [myListTableView setDelegate:self];
    [myListTableView setDataSource:self];
    [myListTableView reloadData];
    
    //[self loadingIndicator];
    //[self performSelectorOnMainThread:@selector(startLoadig) withObject:nil waitUntilDone:YES];
    //[self performSelectorOnMainThread:@selector(loadingUserAddedData) withObject:nil waitUntilDone:YES];
    
    [self barButtonFunction];
    [super viewDidLoad];
}

#pragma Uitableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        static NSString *cellIdentifier = @"headerView";
        headerview *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[headerview alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
        }
        return cell.frame.size.height;
    }
    else if(indexPath.row == 1)
    {
        static NSString *cellIdentifier = @"addfunds";
        addFunds *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[addFunds alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
        }
        return cell.frame.size.height;
    }
    else  if(indexPath.row == 2)
    {
        return 40.0;
    }
    else
    {
        return 320.0f;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection==%lu",([mylistingArray count]/2)+([mylistingArray count]%2));
    
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"==mylistingArray==%@",mylistingArray);
    if(indexPath.row == 0){
        static NSString *cellIdentifier = @"headerView";
        
        headerview *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[headerview alloc] initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:cellIdentifier] ;
        }
        //*******************
       
        
        UserSession *homeHeader = [UserAccessSession getUserSession];
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@",homeHeader.profile_pic]];;
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse * response,
                                                   NSData * data,
                                                   NSError * error) {
                                   if (!error){
                                       UIImage  *image = [[UIImage alloc] initWithData:data];
                                      
                                       [cell.profileImage setImage:image];
                                       cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2;
                                       cell.profileImage.clipsToBounds = YES;
                                   }
                                   else{
                                       cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2;
                                       cell.profileImage.clipsToBounds = YES;
                                       [cell.profileImage setImage:[UIImage imageNamed:@"userIcon"]];
                                   }
                                   
                               }];
        
        
        NSString *res_Fname =homeHeader.reseller_firstname;
        NSString *res_Lname =homeHeader.reseller_lastname;
        
        if(![res_Fname isEqualToString:@""] ||![res_Lname isEqualToString:@""]){
            [cell.nameLbl setText:[NSString stringWithFormat:@"%@ %@",res_Fname,res_Lname]];
        }
        else{
            [cell.nameLbl setText:@""];
        }
        currentBlnc=([currentBlnc isKindOfClass:[NSNull class]] || currentBlnc == nil)?@"0.00":currentBlnc;
        NSLog(@"currentBlnc==%@",[NSString stringWithFormat:@"%@",currentBlnc]);
        [cell.priceLbl setText:[NSString stringWithFormat:@"Cash Balance: $%@",currentBlnc]];
        cell.priceLbl.textAlignment=NSTextAlignmentCenter;
        
        //****************************
        return cell;
    }
    if(indexPath.row == 1){
        // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addFundsId"];
        static NSString *cellIdentifier = @"addfunds";
        
        addFunds *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[addFunds alloc] initWithStyle:UITableViewCellStyleSubtitle
                                   reuseIdentifier:cellIdentifier] ;
        }
        [cell.addBtn addTarget:self action:@selector(addFunds:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }
    if(indexPath.row == 2){
        // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addFundsId"];
        static NSString *cellIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:cellIdentifier] ;
        }
        cell.textLabel.text = @"You currently have no active sales";
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.font = [UIFont fontWithName:@"helvetica" size:16.0];
        return cell;
        
    }
    else{
        
        
        static NSString *cellIdentifier = @"sentMoney";
        sentMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[sentMoneyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                 reuseIdentifier:cellIdentifier] ;
        }
        
        
        [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundColor:[UIColor clearColor]];
        @try {
            
            int indexrow = (int) (indexPath.row -3) * 2;
            NSLog(@"indexrow==%d",indexrow);
            
            
            
          // if()
            NSLog(@"hello");
            //btn1
            
            [cell.btnSentMoney addTarget:self action:@selector(selectedproduct:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnSentMoney setTag:(int)0];
            cell.btnSentMoney.layer.borderWidth = 0.5;
            cell.btnSentMoney.layer.borderColor=[UIColor lightGrayColor].CGColor;
            //indexrow
             NSString *priceSM = [[[mylistingArray objectAtIndex:0]objectForKey:@"price"] isKindOfClass:[NSNull class]]?@"":[[mylistingArray objectAtIndex:0]objectForKey:@"price"];
           
            [cell.SM_TotalSale setText:priceSM];
            cell.SM_TotalSale.textColor = [UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0];
            
            
            
            
            //btn 2
           
            [cell.btnPinlessRchrg addTarget:self action:@selector(selectedproduct:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnPinlessRchrg setTag:(int)1];
            cell.btnPinlessRchrg.layer.borderWidth = 0.5;
            cell.btnPinlessRchrg.layer.borderColor=[UIColor lightGrayColor].CGColor;
            //indexrow
             NSString *pricePR = [[[mylistingArray objectAtIndex:1]objectForKey:@"price"] isKindOfClass:[NSNull class]]?@"":[[mylistingArray objectAtIndex:1]objectForKey:@"price"];
            [cell.PR_TotalSale setText:pricePR];
            cell.PR_TotalSale.textColor = [UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0];
             NSLog(@"priceSM==%@",priceSM);
            
            //btn3
            [cell.btnIMTUrchrg addTarget:self action:@selector(selectedproduct:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnIMTUrchrg setTag:(int)2];
            cell.btnIMTUrchrg.layer.borderWidth = 0.5;
            cell.btnIMTUrchrg.layer.borderColor=[UIColor lightGrayColor].CGColor;
            
             NSString *priceIMTU = [[[mylistingArray objectAtIndex:2]objectForKey:@"price"] isKindOfClass:[NSNull class]]?@"":[[mylistingArray objectAtIndex:2]objectForKey:@"price"];
            [cell.IMPU_TotalSale setText:priceIMTU];
            cell.IMPU_TotalSale.textColor = [UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0];
            //btn3
           
            [cell.btnAddCash addTarget:self action:@selector(selectedproduct:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnAddCash setTag:(int)3];
            cell.btnAddCash.layer.borderWidth = 0.5;
            cell.btnAddCash.layer.borderColor=[UIColor lightGrayColor].CGColor;
            
             NSString *priceAC = [[[mylistingArray objectAtIndex:3]objectForKey:@"price"] isKindOfClass:[NSNull class]]?@"":[[mylistingArray objectAtIndex:3]objectForKey:@"price"];
            [cell.AC_TotalSale setText:priceAC];
            cell.AC_TotalSale.textColor = [UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0];
            
            
            /*
            
            NSString *pname = [[[mylistingArray objectAtIndex:indexrow]objectForKey:@"name"] isKindOfClass:[NSNull class]]?@"":[[mylistingArray objectAtIndex:indexrow]objectForKey:@"name"];
            //product title
            UILabel * productName = [[UILabel alloc] init];
            //[productName setFont:[UIFont fontWithName:@"product Title" size:12]];
            [productName setText:pname];
            [productName setTextColor:[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0]];
            [productName setBackgroundColor:[UIColor whiteColor]];
            [productName setTextAlignment:NSTextAlignmentCenter];
            productName.layer.cornerRadius=2;
            productName.layer.masksToBounds=YES;
            productName.numberOfLines=0;
            productName.lineBreakMode=NSLineBreakByWordWrapping;
            [productName setFrame:CGRectMake(5,LikedProductImgView.frame.origin.y+LikedProductImgView.frame.size.height,((contentview.frame.size.width/2)-20),30)];
            [contentview addSubview:productName];
            //product title 2
            //product title
            
            NSString *pname2 = [[[mylistingArray objectAtIndex:indexrow+1]objectForKey:@"name"] isKindOfClass:[NSNull class]]?@"":[[mylistingArray objectAtIndex:indexrow+1]objectForKey:@"name"];
            UILabel * productName2view = [[UILabel alloc] init];
            //[productName2view setFont:[UIFont fontWithName:@"product Title" size:12]];
            [productName2view setText:pname2];
            [productName2view setTextColor:[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0]];
            [productName2view setBackgroundColor:[UIColor whiteColor]];
            [productName2view setTextAlignment:NSTextAlignmentCenter];
            productName2view.layer.cornerRadius=2;
            productName2view.layer.masksToBounds=YES;
            productName2view.numberOfLines=0;
            productName2view.lineBreakMode=NSLineBreakByWordWrapping;
            [productName2view setFrame:CGRectMake(((contentview.frame.size.width/2)+10),LikedProductImgViewOne.frame.origin.y+LikedProductImgViewOne.frame.size.height,((contentview.frame.size.width/2)-20),30)];
            [contentview addSubview:productName2view];
            
            
            //total sales
            UILabel * total_salesLabel = [[UILabel alloc] init];
            total_salesLabel.font = [UIFont fontWithName:@"Helvetica-light" size:13];
            [total_salesLabel setText:@"Total sales:"];
            [total_salesLabel setTextColor:[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0]];
            [total_salesLabel setBackgroundColor:[UIColor whiteColor]];
            [total_salesLabel setTextAlignment:NSTextAlignmentRight];
            total_salesLabel.layer.borderWidth = 0;
            //total_salesLabel.layer.cornerRadius=2;
            //total_salesLabel.layer.masksToBounds=YES;
            total_salesLabel.numberOfLines=0;
            [total_salesLabel setFrame:CGRectMake(15,productName.frame.origin.y+productName.frame.size.height,(((contentview.frame.size.width/2)-20)/2),15)];
            [contentview addSubview:total_salesLabel];
            
            UILabel * total_sales2Label = [[UILabel alloc] init];
            total_sales2Label.font = [UIFont fontWithName:@"Helvetica-light" size:13];
            [total_sales2Label setText:@"Total sales:"];
            [total_sales2Label setTextColor:[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0]];
            [total_sales2Label setBackgroundColor:[UIColor whiteColor]];
            [total_sales2Label setTextAlignment:NSTextAlignmentRight];
            total_sales2Label.layer.borderWidth = 0;
            //total_sales2Label.layer.cornerRadius=2;
            //total_sales2Label.layer.masksToBounds=YES;
            total_sales2Label.numberOfLines=0;
            [total_sales2Label setFrame:CGRectMake(((contentview.frame.size.width/2)+20),productName2view.frame.origin.y+productName2view.frame.size.height,(((contentview.frame.size.width/2)-20)/2),15)];
            [contentview addSubview:total_sales2Label];
            
            //price
            
            NSString *price = [[[mylistingArray objectAtIndex:indexrow]objectForKey:@"price"] isKindOfClass:[NSNull class]]?@"":[[mylistingArray objectAtIndex:indexrow]objectForKey:@"price"];
            
            UILabel * total_salesPrice = [[UILabel alloc] init];
            total_salesPrice.font = [UIFont fontWithName:@"Helvetica" size:11];
            [total_salesPrice setText:price];
            [total_salesPrice setTextColor:[UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0]];
            [total_salesPrice setBackgroundColor:[UIColor whiteColor]];
            [total_salesPrice setTextAlignment:NSTextAlignmentLeft];
            total_salesPrice.layer.borderWidth = 0;
            // total_salesPrice.layer.cornerRadius=2;
            // total_salesPrice.layer.masksToBounds=YES;
            total_salesPrice.numberOfLines=0;
            [total_salesPrice setFrame:CGRectMake(total_salesLabel.frame.origin.x+total_salesLabel.frame.size.width+6,productName.frame.origin.y+productName.frame.size.height+1,(((contentview.frame.size.width/2)-20)/2)-3,15)];
            [contentview addSubview:total_salesPrice];
            
            
            NSString *price2 = [[[mylistingArray objectAtIndex:indexrow+1]objectForKey:@"price"] isKindOfClass:[NSNull class]]?@"":[[mylistingArray objectAtIndex:indexrow+1]objectForKey:@"price"];
            UILabel * total_sales2Price = [[UILabel alloc] init];
            total_sales2Price.font = [UIFont fontWithName:@"Helvetica" size:11];
            [total_sales2Price setText:price2];
            [total_sales2Price setTextColor:[UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0]];
            [total_sales2Price setBackgroundColor:[UIColor whiteColor]];
            [total_sales2Price setTextAlignment:NSTextAlignmentLeft];
            //total_sales2Price.layer.cornerRadius=2;
            //total_sales2Price.layer.masksToBounds=YES;
            total_sales2Price.layer.borderWidth = 0;
            total_sales2Price.numberOfLines=0;
            [total_sales2Price setFrame:CGRectMake(((contentview.frame.size.width/2)+20)+(total_salesPrice.frame.size.width),productName2view.frame.origin.y+productName2view.frame.size.height+1,(((contentview.frame.size.width/2)-20)/2),15)];
            [contentview addSubview:total_sales2Price];
            
            [cell.contentView addSubview:contentview];
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
             
             */
             
            [cell setBackgroundColor:[UIColor clearColor]];
            cell.contentView.userInteractionEnabled = NO;
        }
        @catch (NSException *exception) {
        } @finally {
        }
        
        return cell;
        //for else part
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 1)
    {
        NSLog(@"addFunds Clicked");
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        addFundsvC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"addFunds"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        [[self navigationController] pushViewController:vc animated:YES];
    }
    if(indexPath.row == 2)
    {
       
        
        /*UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        "addCustomerVC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@""SBaddCustomer"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        [[self navigationController] pushViewController:vc animated:YES];*/
    }
    if(indexPath.row == 3)
    {
        
        int indexrow = (int) (indexPath.row -3) * 2;
        NSLog(@"test===%d",indexrow);
        if(indexrow == 0)
        {
            NSLog(@"test2===%d",indexrow);
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            sendMoneyCustomerList *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"SBsendMoneyCustomerList"];
            // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
            [[self navigationController] pushViewController:vc animated:YES];
        }
        
    }

    
    
}
-(void)addFunds:(UIButton *)sender
{
    NSLog(@"addFunds Clicked");
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    addFundsvC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"addFunds"];
    // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
    [[self navigationController] pushViewController:vc animated:YES];
}
-(void)selectedproduct:(UIButton *)sender
{
    int tag = (int)sender.tag;
   if(tag == 0)
   {
       NSLog(@"test2===%d",tag);
       UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
       sendMoneyCustomerList *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"SBsendMoneyCustomerList"];
       // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
       [[self navigationController] pushViewController:vc animated:YES];
   }
   else if(tag == 1)
    {
        NSLog(@"test2===%d",tag);
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
         pinlessRechervC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"SBPinless"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        [[self navigationController] pushViewController:vc animated:YES];
    }
   else if(tag == 2)
   {
       NSLog(@"test2===%d",tag);
       UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
       IMTUrechargeVC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"SBimtuRchrg"];
       // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
       [[self navigationController] pushViewController:vc animated:YES];
   }
   else if(tag == 3)
   {
       NSLog(@"test2===%d",tag);
       UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
       addFundsvC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"addFunds"];
       // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
       [[self navigationController] pushViewController:vc animated:YES];
       
   }

}

//for navigation bar
-(void) barButtonFunction
{
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"rightMenu"]
                                                                              style:UIBarButtonItemStylePlain target:revealController action:@selector(rightRevealToggle:)];
    
    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    UIImage * logoInNavigationBar = [UIImage imageNamed:@"logo"];
    UIImageView * logoView = [[UIImageView alloc] init];
    [logoView setImage:logoInNavigationBar];
    //self.navigationController.navigationItem.titleView = logoView;
    
    UIImage* logoImage = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
    
    
    [self.navigationController.navigationBar setBarTintColor:navigationBarColor];
    
}
-(void)OrientationChange:(NSNotification*)notification
{
    UIDeviceOrientation Orientation=[[UIDevice currentDevice]orientation];
    
    if(Orientation==UIDeviceOrientationLandscapeLeft || Orientation==UIDeviceOrientationLandscapeRight)
    {
        [myListTableView reloadData];
        NSLog(@"Landscape");
    }
    else if(Orientation==UIDeviceOrientationPortrait)
    {
        [myListTableView reloadData];
        NSLog(@"Portrait");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//for details of home page
-(void)getDashBoardData
{
    NSLog(@"getDashBoardData");
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *userData = [UserAccessSession getUserSession];
    userId =userData.reseller_id;
    athenticationKey =userData.res_user_login_key;
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                 userId,@"user_id",
                   athenticationKey,@"authentication_key",//athenticationKey
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_DASHBOARDDATA];
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
        NSLog(@"json-----%@",json);
        NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]) {
            currentBlnc=[[[json objectForKey:@"data"]objectForKey:@"current_balance"] isKindOfClass:[NSNull class]]?@"0.00":[[json objectForKey:@"data"]objectForKey:@"current_balance"];
            NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]init];
            [dict1 setObject:@"Sent Money" forKey:@"name"];
            [dict1 setObject:@"send_money.png" forKey:@"photos"];
            [dict1 setObject:[NSString stringWithFormat:@"$ %@", [json objectForKey:@"data"][@"total_sendmoney"]] forKey:@"price"];
            
            NSMutableDictionary *dict2 = [[NSMutableDictionary alloc]init];
            [dict2 setObject:@"Pinless Recharge" forKey:@"name"];
            [dict2 setObject:@"pinless_recharge.png" forKey:@"photos"];
            [dict2 setObject:[NSString stringWithFormat:@"$ %@", [json objectForKey:@"data"][@"total_pinless"]] forKey:@"price"];
            
            NSMutableDictionary *dict3 = [[NSMutableDictionary alloc]init];
            [dict3 setObject:@" IMTU Recharge" forKey:@"name"];
            [dict3 setObject:@"imtu_recharge.png" forKey:@"photos"];
            [dict3 setObject:[NSString stringWithFormat:@"$ %@", [json objectForKey:@"data"][@"total_imtu"]] forKey:@"price"];
            
            NSMutableDictionary *dict4 = [[NSMutableDictionary alloc]init];
            [dict4 setObject:@"Add Cash" forKey:@"name"];
            [dict4 setObject:@"add_cash.png" forKey:@"photos"];
            [dict4 setObject:@"$599.99" forKey:@"price"];
            
            [mylistingArray addObject:dict1];
            [mylistingArray addObject:dict2];
            [mylistingArray addObject:dict3];
            [mylistingArray addObject:dict4];
            
            NSLog(@"mylistingArray====%@",mylistingArray);
            
            [myListTableView setDataSource:self];
            [myListTableView setDelegate:self];
            [myListTableView reloadData];
            
            
            
           NSLog(@"mylistingArray======%@",mylistingArray);

        }
        else{
            if([[json objectForKey:@"msg"] isEqualToString:@"Authentication key is invalid."])
            {
                [UserAccessSession clearAllSession];
                NSLog(@"clickedButtonAtIndex");
                SWRevealViewController *revealController = self.revealViewController;
                NSString * storyboardName = @"Main";
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
                ViewController * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"loginSB"];
                // [revealController setFrontViewPosition:vc1 animated:YES];
                UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
                [revealController pushFrontViewController:frontNavigationController animated:YES];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            currentBlnc=@"0.00";
        }
        
        // NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
        // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
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
