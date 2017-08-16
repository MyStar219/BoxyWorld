//
//  leftMenuVC.m
//  BoxyWorld
//
//  Created by Sambaran DAS on 15/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "leftMenuVC.h"
#import "config.h"
#import "SWRevealViewController.h"
#import "homeVC.h"
#import "AppDelegate.h"
#import "customerListVC.h"
#import "addEmployee.h"
#import "subAgentVC.h"
#import "IMTUrechargeVC.h"
#import "allTransactionVC.h"
#import "UserAccessSession.h"
#import "ViewController.h"
#import "pinlessRechervC.h"
#import "FAQ-catagoryVC.h"
#import "helpVC.h"
#import "callingRateVC.h"
#import "sendMoneyCustomerList.h"
#import "earningVC.h"
#import "earingSendMoneyVC.h"
//#import "fundsHistoryVC.h"
#import "historyPageVC.h"
#import "EmployeeListVC.h"
@interface leftMenuVC ()<UITableViewDataSource,UITableViewDelegate>{
    AppDelegate *appDel;
    UIAlertView* _alertConfirmation;
    NSString *selected;

}

@end

@implementation leftMenuVC
@synthesize myMenuView;
@synthesize tabController;
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    [myMenuView reloadData];
    [super viewWillAppear:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDel = [AppDelegate instance];
    self.revealViewController.rearViewRevealOverdraw = 0.0f;
    // Do any additional setup after loading the view.
    myMenuListArray =[[NSMutableArray alloc]init];
    //menulist
    NSMutableDictionary *menu1 = [[NSMutableDictionary alloc]init];
    [menu1 setObject:@"Home" forKey:@"name"];
    [menu1 setObject:@"home" forKey:@"photos"];
   // [menu1 setObject:@"$599.99" forKey:@"price"];
    
    NSMutableDictionary *menu2 = [[NSMutableDictionary alloc]init];
    [menu2 setObject:@"Master Reseller" forKey:@"name"];
    [menu2 setObject:@"master_reseller" forKey:@"photos"];
    //[menu2 setObject:@"$1839.69" forKey:@"price"];
    
    NSMutableDictionary *menu3 = [[NSMutableDictionary alloc]init];
    [menu3 setObject:@"Customer" forKey:@"name"];
    [menu3 setObject:@"customers" forKey:@"photos"];
    //[menu3 setObject:@"$599.99" forKey:@"price"];
    
    NSMutableDictionary *menu4 = [[NSMutableDictionary alloc]init];
    [menu4 setObject:@"Pinless Recharge" forKey:@"name"];
    [menu4 setObject:@"pinless_recharge-1" forKey:@"photos"];
    //[menu4 setObject:@"$599.99" forKey:@"price"];
    
    NSMutableDictionary *menu5 = [[NSMutableDictionary alloc]init];
    [menu5 setObject:@"IMTU Recharge" forKey:@"name"];
    [menu5 setObject:@"imtu_recharge-1" forKey:@"photos"];
    //[menu5 setObject:@"$599.99" forKey:@"price"];
    
    NSMutableDictionary *menu6 = [[NSMutableDictionary alloc]init];
    [menu6 setObject:@"Send Money" forKey:@"name"];
    [menu6 setObject:@"send_money-1" forKey:@"photos"];
    //[menu6 setObject:@"$1839.69" forKey:@"price"];
    
    NSMutableDictionary *menu7 = [[NSMutableDictionary alloc]init];
    [menu7 setObject:@"Transactions" forKey:@"name"];
    [menu7 setObject:@"transactions" forKey:@"photos"];
    //[menu7 setObject:@"$599.99" forKey:@"price"];
    
    NSMutableDictionary *menu8 = [[NSMutableDictionary alloc]init];
    [menu8 setObject:@"Earning" forKey:@"name"];
    [menu8 setObject:@"earnings" forKey:@"photos"];
    //[menu8 setObject:@"$599.99" forKey:@"price"];
    
    NSMutableDictionary *menu9 = [[NSMutableDictionary alloc]init];
    [menu9 setObject:@"Employee" forKey:@"name"];
    [menu9 setObject:@"employee" forKey:@"photos"];
    //[menu9 setObject:@"$599.99" forKey:@"price"];
    
    NSMutableDictionary *menu10 = [[NSMutableDictionary alloc]init];
    [menu10 setObject:@"FAQ" forKey:@"name"];
    [menu10 setObject:@"faq" forKey:@"photos"];
    //[menu10 setObject:@"$1839.69" forKey:@"price"];
    
    NSMutableDictionary *menu11 = [[NSMutableDictionary alloc]init];
    [menu11 setObject:@"Help" forKey:@"name"];
    [menu11 setObject:@"help" forKey:@"photos"];
    
    NSMutableDictionary *menu11a = [[NSMutableDictionary alloc]init];
    [menu11a setObject:@"Access Numbers" forKey:@"name"];
    [menu11a setObject:@"access_number" forKey:@"photos"];
    
    NSMutableDictionary *menu11b = [[NSMutableDictionary alloc]init];
    [menu11b setObject:@"Calling Rates" forKey:@"name"];
    [menu11b setObject:@"calling_rate" forKey:@"photos"];
    
    
    NSMutableDictionary *menu12 = [[NSMutableDictionary alloc]init];
    [menu12 setObject:@"Log Out" forKey:@"name"];
    [menu12 setObject:@"logout" forKey:@"photos"];
    //[menu11 setObject:@"$599.99" forKey:@"price"];
    
    [myMenuListArray addObject:menu1];
    [myMenuListArray addObject:menu2];
    [myMenuListArray addObject:menu3];
    [myMenuListArray addObject:menu4];
    [myMenuListArray addObject:menu5];
    [myMenuListArray addObject:menu6];
    [myMenuListArray addObject:menu7];
    [myMenuListArray addObject:menu8];
    [myMenuListArray addObject:menu9];
    [myMenuListArray addObject:menu10];
    [myMenuListArray addObject:menu11];
    [myMenuListArray addObject:menu11a];
    [myMenuListArray addObject:menu11b];
     [myMenuListArray addObject:menu12];
    
    
    [myMenuView registerNib:[UINib nibWithNibName:@"leftMenuHeader" bundle:nil]forCellReuseIdentifier:@"leftMenuHeader"];
    [myMenuView registerNib:[UINib nibWithNibName:@"addfunds" bundle:nil]forCellReuseIdentifier:@"addfunds"];
    
    [myMenuView setSeparatorColor:[UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.2]];
    myMenuView.backgroundColor = navigationBarColor;
    myMenuView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [myMenuView setDataSource:self];
    [myMenuView setDelegate:self];
    [myMenuView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        static NSString *cellIdentifier = @"leftMenuHeader";
        menuHeadercellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[menuHeadercellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
        }
        return cell.frame.size.height;
    }
    else
    {
        static NSString *cellIdentifier = @"addfunds";
        addFunds *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[addFunds alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
        }
        return cell.frame.size.height;
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return myMenuListArray.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        static NSString *cellIdentifier = @"leftMenuHeader";
        
        menuHeadercellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[menuHeadercellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                      reuseIdentifier:cellIdentifier] ;
        }
        //cell.profileImg.layer.cornerRadius=cell.profileImg.frame.size.width/2;
        UserSession *lHeader = [UserAccessSession getUserSession];
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@",lHeader.profile_pic]];;
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse * response,
                                                   NSData * data,
                                                   NSError * error) {
                                   if (!error){
                                       UIImage  *image = [[UIImage alloc] initWithData:data];
                                       [cell.profileImg setImage:image];
                                       cell.profileImg.layer.cornerRadius = cell.profileImg.frame.size.width / 2;
                                       cell.profileImg.clipsToBounds = YES;
                                       
                                   }
                                   else{
                                       [cell.profileImg setImage:[UIImage imageNamed:@"userIcon"]];
                                       cell.profileImg.layer.cornerRadius = cell.profileImg.frame.size.width / 2;
                                       cell.profileImg.clipsToBounds = YES;

                                       
                                   }
                                   
                               }];
        
        
        NSString *res_Fname =lHeader.reseller_firstname;
        NSString *res_Lname =lHeader.reseller_lastname;
        NSString *mail =lHeader.reseller_email;
        
        if(![res_Fname isEqualToString:@""] ||![res_Lname isEqualToString:@""]){
            [cell.namelbl setText:[NSString stringWithFormat:@"%@ %@",res_Fname,res_Lname]];
        }
        else{
            [cell.namelbl setText:@""];
        }
        if(![mail isEqualToString:@""]){
            [cell.mailLbl setText:[NSString stringWithFormat:@"%@",mail]];
        }
        else{
            [cell.mailLbl setText:@""];
        }

        //cell.namelbl.text = @"Chig'z Rathod";
        //cell.mailLbl.text = @"nextgenchigzrathod@gmail.com";
        cell.backgroundColor = navigationBarColor;
        return cell;
    }
    else
    {
        NSLog(@"myMenuListArray=%@",myMenuListArray);
        // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addFundsId"];
        static NSString *cellIdentifier = @"addfunds";
        
        addFunds *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[addFunds alloc] initWithStyle:UITableViewCellStyleSubtitle
                                   reuseIdentifier:cellIdentifier] ;
        }
        
        NSString *lMenuTital = [[[myMenuListArray objectAtIndex:(indexPath.row)-1]objectForKey:@"name"] isKindOfClass:[NSNull class]]?@"":[[myMenuListArray objectAtIndex:(indexPath.row)-1]objectForKey:@"name"];
        [cell.addFundsLbl setText:lMenuTital];
        cell.addFundsLbl.layer.masksToBounds=YES;
        [cell.addFundsLbl setTextAlignment:NSTextAlignmentCenter];
         [cell.addFundsLbl setFrame:CGRectMake(0,0,300,30)];
        
        NSString *menuIcon = [[[myMenuListArray objectAtIndex:(indexPath.row)-1]objectForKey:@"photos"] isKindOfClass:[NSNull class]]?@"":[[myMenuListArray objectAtIndex:(indexPath.row)-1]objectForKey:@"photos"];
        //NSLog(@"imageName%d---%@",indexrow+1,imageName2);
        if(![menuIcon isEqualToString:@""]){
            
            [cell.currencyImage setImage:[UIImage imageNamed:menuIcon]];
        }
        else
        {
            
             [cell.currencyImage setImage:[UIImage imageNamed:@"01_logo_screen-1.png"]];
        }
        [cell.currencyImage setTintColor:[UIColor whiteColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.userInteractionEnabled = YES;
        [cell.addBtn setHidden:YES];
        cell.addFundsLbl.textColor = [UIColor whiteColor];
        cell.backgroundColor = navigationBarColor;
        return cell;
        
    }
    
    
    return nil;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"HOME----");
    SWRevealViewController *revealController = self.revealViewController;
    // selecting row
    NSInteger row = indexPath.row;
    if(indexPath.row == 1)
    {
        [appDel setBothMenus];
        /*
        homeVC *hVC = [[homeVC alloc]initWithNibName:@"homeVC" bundle:nil];
        [[self navigationController] pushViewController:hVC animated:YES];
        */
       // UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
    }
     else if(indexPath.row == 2){
         NSString * storyboardName = @"Main";
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
         customerListVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"subAgentlist"];
         // [revealController setFrontViewPosition:vc1 animated:YES];
         
         UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
         [revealController pushFrontViewController:frontNavigationController animated:YES];
         
         
         
        

         
     }
    else if(indexPath.row == 3){
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        customerListVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"customerList"];
       // [revealController setFrontViewPosition:vc1 animated:YES];
       
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
        [revealController pushFrontViewController:frontNavigationController animated:YES];

        /*
        
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        customerListVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"customerList"];
        [self.navigationController pushViewController:vc1 animated:YES];
        leftMenuVC *rearViewController = [[leftMenuVC alloc]initWithNibName:@"leftMenuVC" bundle:nil];
         NSLog(@"HOME not");*/
      }
    else if(indexPath.row == 4){
        NSLog(@"pinlessRecharge");
        /*pinlessRechargeVC1 * pinless_obj = [[pinlessRechargeVC1 alloc]initWithNibName:@"pinlessRechargeVC1" bundle:nil];
        [pinless_obj detailPageArray:mylistingArray selectedIndex:(int)[sender tag]];
        [self.navigationController pushViewController:pinless_obj animated:YES];*/
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        pinlessRechervC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"SBPinless"];
        // [revealController setFrontViewPosition:vc1 animated:YES];
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
        [revealController pushFrontViewController:frontNavigationController animated:YES];
    }
    else if(indexPath.row == 5)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        IMTUrechargeVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"SBimtuRchrg"];
        // [revealController setFrontViewPosition:vc1 animated:YES];
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
        [revealController pushFrontViewController:frontNavigationController animated:YES];
    }
    else if(indexPath.row == 6)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        IMTUrechargeVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"SBsendMoneyCustomerList"];
        // [revealController setFrontViewPosition:vc1 animated:YES];
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
        [revealController pushFrontViewController:frontNavigationController animated:YES];
        
        /*UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        sendMoneyCustomerList *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"SBsendMoneyCustomerList"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        [[self navigationController] pushViewController:vc animated:YES];*/

    }

    
    
    
    else if(indexPath.row == 7)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboards = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        
        allTransactionVC *firstTab = [storyboards instantiateViewControllerWithIdentifier:@"SBTransaction"];
        allTransactionVC *secondTab = [storyboards instantiateViewControllerWithIdentifier:@"SBTransaction"];
        
        allTransactionVC *thirdTab = [storyboards instantiateViewControllerWithIdentifier:@"SBTransaction"];
        allTransactionVC *fourthTab = [storyboards instantiateViewControllerWithIdentifier:@"SBTransaction"];
        
        firstTab.title = @"ALL"; //TabTitle
        firstTab.selfTitle = @"all";
        firstTab.tabBarItem.image = [UIImage imageNamed:@"all"];
        secondTab.title = @"FUND"; //TabTitle
        secondTab.tabBarItem.image = [UIImage imageNamed:@"fund"];
        secondTab.selfTitle = @"fund";
        
        thirdTab.title = @"PINLESS"; //TabTitle
        thirdTab.tabBarItem.image = [UIImage imageNamed:@"pinless"];
        thirdTab.selfTitle = @"pinless";
        
        fourthTab.title = @"IMTU"; //TabTitle
        fourthTab.tabBarItem.image = [UIImage imageNamed:@"imtu"];
        fourthTab.selfTitle = @"imtu";
        
        
        
        tabController = [[UITabBarController  alloc] init];
        tabController.viewControllers = [[NSArray  alloc] initWithObjects:firstTab,secondTab,thirdTab,fourthTab, nil];//secondTab
        [tabController setSelectedIndex:0];
        self.tabController.delegate=self;
        
        //UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:tabController];
        //[revealController pushFrontViewController:frontNavigationController animated:YES];
        UIWindow *window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        self.window = window;
        self.window.rootViewController = tabController;
        [self.window makeKeyAndVisible];
      //[self.navigationController pushViewController:tabController animated:YES];
        //[self presentViewController:tabController animated:YES completion:NULL];
        

       /* NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        allTransactionVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"SBTransaction"];
        // [revealController setFrontViewPosition:vc1 animated:YES];
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
        [revealController pushFrontViewController:frontNavigationController animated:YES];*/
    }
    
    else if(indexPath.row == 8)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboards = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        
       // allTransactionVC *firstTab = [storyboards instantiateViewControllerWithIdentifier:@"SBTransaction"];
        earningVC *secondTab = [storyboards instantiateViewControllerWithIdentifier:@"SBEarning"];
        
        earningVC *thirdTab = [storyboards instantiateViewControllerWithIdentifier:@"SBEarning"];
        earingSendMoneyVC *fourthTab = [storyboards instantiateViewControllerWithIdentifier:@"SBEarningSendMoney"];
        
       
        secondTab.title = @"PINLESS"; //TabTitle
        secondTab.tabBarItem.image = [UIImage imageNamed:@"pinless"];
        secondTab.selfTitle = @"pinless";
        
        thirdTab.title = @"IMTU"; //TabTitle
        thirdTab.tabBarItem.image = [UIImage imageNamed:@"imtu"];
        thirdTab.selfTitle = @"imtu";
        
        fourthTab.title = @"SEND MONEY"; //TabTitle
        fourthTab.tabBarItem.image = [UIImage imageNamed:@"fund"];
        fourthTab.selfTitle = @"sendMoney";
        
        
        
        tabController = [[UITabBarController  alloc] init];
        tabController.viewControllers = [[NSArray  alloc] initWithObjects:secondTab,thirdTab,fourthTab, nil];//secondTab
        [tabController setSelectedIndex:0];
        self.tabController.delegate=self;
        
        //UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:tabController];
        //[revealController pushFrontViewController:frontNavigationController animated:YES];
        UIWindow *window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        self.window = window;
        self.window.rootViewController = tabController;
        [self.window makeKeyAndVisible];
        
        
    }

    
    else if(indexPath.row == 9)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        EmployeeListVC *vc1 = [storyboard instantiateViewControllerWithIdentifier:@"EmplyeeList"];
        // [revealController setFrontViewPosition:vc1 animated:YES];
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
        [revealController pushFrontViewController:frontNavigationController animated:YES];
        
           }
    else if(indexPath.row == 10)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        addEmployee * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"faqCatagory"];
        // [revealController setFrontViewPosition:vc1 animated:YES];
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
        [revealController pushFrontViewController:frontNavigationController animated:YES];
        
    }
    else if(indexPath.row == 11)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        helpVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"help"];
        // [revealController setFrontViewPosition:vc1 animated:YES];
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
        [revealController pushFrontViewController:frontNavigationController animated:YES];
        
    }
    //accessNo
    else if(indexPath.row == 12)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        callingRateVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"accessNo"];
        // [revealController setFrontViewPosition:vc1 animated:YES];
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
        [revealController pushFrontViewController:frontNavigationController animated:YES];
        
    }

    //CallingRate
    else if(indexPath.row == 13)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        callingRateVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"CallingRate"];
        // [revealController setFrontViewPosition:vc1 animated:YES];
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
        [revealController pushFrontViewController:frontNavigationController animated:YES];
        
    }
        else if(indexPath.row == 14)
    {
        
        [self didClickLogout];
    }

    else {
        NSLog(@"HOME not");
    }
}
//****************
- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
{
    //NSLog(@"controller class: %@", NSStringFromClass([viewController class]));
    NSLog(@"controller title: %@", viewController.title);
    /*
    if ([viewController.title isEqualToString:@"FUND"])
    {
       selected =@"fund";
    }
    else if ([viewController.title isEqualToString:@"PINLESS"])
    {
         selected =@"pinless";
    }
    else if ([viewController.title isEqualToString:@"IMTU"])
    {
         selected =@"imtu";
    }
    else{
         selected =@"all";
    }
*/
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",viewController.title] forKey:@"tabSelected2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"tabSelectedSAM%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"tabSelected2"]);
    
/* UserSession *setectedTab = [UserAccessSession getUserSession];
    setectedTab.setectedTabHis = selected;
 [UserAccessSession storeUserSession:setectedTab];*/
}



//********************
//**************************
 -(void)didClickLogout{
 [self showAlertExit];
 }
 -(void)showAlertExit {
 
 if(_alertConfirmation == nil) {
 _alertConfirmation = [[UIAlertView alloc] initWithTitle:@"User Logout"
 message:@"Do you want to logout?"
 delegate:self
 cancelButtonTitle:@"No"
 otherButtonTitles:@"Yes", nil];
 
 _alertConfirmation.tag = 2;
 }
 [_alertConfirmation show];
 }
 
 -(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
     
 
if(alertView.cancelButtonIndex == buttonIndex){
    
     NSLog(@"buttonIndex");
 
 }
 else {
 
     [UserAccessSession clearAllSession];
      NSLog(@"clickedButtonAtIndex");
      SWRevealViewController *revealController = self.revealViewController;
     NSString * storyboardName = @"Main";
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
     ViewController * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"loginSB"];
     // [revealController setFrontViewPosition:vc1 animated:YES];
     UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
     [revealController pushFrontViewController:frontNavigationController animated:YES];
     
    
     
     
     
    // [appDel goToLoginPage];
     
    

 }
 
 }


 //**************************

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
