//
//  sendMoneyCustomerList.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 06/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "sendMoneyCustomerList.h"
#import "customerListCell.h"
#import "config.h"
#import "SWRevealViewController.h"
#import "addCustomerVC.h"
#import "AppDelegate.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "ViewController.h"
#import "sentMoneyCustomerDetails.h"
@interface sendMoneyCustomerList ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    MBProgressHUD *hud;
    AppDelegate *appDel;
    NSString *userId ;
    NSString *athenticationKey ;
    NSMutableArray *searchArrCustomer,*dummyArr;
    NSMutableArray *temp;
    NSString *searchErrTxt;
    BOOL searchActive;
}

@end

@implementation sendMoneyCustomerList
@synthesize tableCustomaerList,btnAddCustomer,btnAddCustomerImg,searchBarCustomerList;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSLog(@"sdgsdgsgsd");
    appDel = [AppDelegate instance];
    searchArrCustomer = [[NSMutableArray alloc]init];
    dummyArr = [[NSMutableArray alloc]init];
    [self searchBarLayout];
    [self barButtonFunction];
    self.title = @"Send Money";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    btnAddCustomer.layer.cornerRadius = 6.0f;
    [btnAddCustomer setTitle:@"  Add New Customer" forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
    customerListArray = [[NSMutableArray alloc]init];
    [searchBarCustomerList setDelegate:self];
    
    [tableCustomaerList registerNib:[UINib nibWithNibName:@"sendMoneyCustomerListCell" bundle:nil]forCellReuseIdentifier:@"sendMoneyCustomerListCell"];
    
    [self getDashBoardData];
    [tableCustomaerList setDataSource:self];
    [tableCustomaerList setDelegate:self];
    //[tableCustomaerList reloadData];
}

-(void)getDashBoardData
{
    NSLog(@"getDashBoardData------");
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
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETCUSTOMER];
    //NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // NSLog(@"URL==%@",URL);
   /// NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        
        NSLog(@"sent....... money-----%@",json);
        NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]) {
            temp = [[NSMutableArray alloc]init];
            temp = [json objectForKey:@"data"];
            if([temp count] > 0)
            {
                for(int i=0;i<[temp count];i++)
                {
                    NSString *CustomerID = ([[[temp objectAtIndex:i]objectForKey:@"id"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"id"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"id"];
                    NSString *fname = ([[[temp objectAtIndex:i]objectForKey:@"firstname"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"firstname"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"firstname"];
                    
                    NSString *lastname = ([[[temp objectAtIndex:i]objectForKey:@"lastname"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"lastname"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"lastname"];
                    
                    NSString *date_created = ([[[temp objectAtIndex:i]objectForKey:@"date_created"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"date_created"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"date_created"];
                    
                    NSString *plain_phone = ([[[temp objectAtIndex:i]objectForKey:@"plain_phone"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"plain_phone"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"plain_phone"];
                    
                    NSString *address = ([[[temp objectAtIndex:i]objectForKey:@"address"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"address"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"address"];
                    
                    /*NSString *customerPhotos = ([[[temp objectAtIndex:i]objectForKey:@"customerPhotos"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"customerPhotos"] == nil)?@"userIcon":[[temp objectAtIndex:i]objectForKey:@"customerPhotos"];*/
                     NSString *customerPhotos = ([[[temp objectAtIndex:i]objectForKey:@"govtidpath"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"govtidpath"] == nil)?@"userIcon":[[temp objectAtIndex:i]objectForKey:@"govtidpath"];
                    
                    
                    NSString *email = ([[[temp objectAtIndex:i]objectForKey:@"email"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"email"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"email"];
                    
                    
                    NSString *state = ([[[temp objectAtIndex:i]objectForKey:@"state"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"state"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"state"];
                    
                    /*([[[temp objectAtIndex:i]objectForKey:@"state"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"state"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"state"];*/
                    
                    
                    NSString *zip = ([[[temp objectAtIndex:i]objectForKey:@"zip"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"zip"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"zip"];
                    
                    
                    NSString *country = ([[[temp objectAtIndex:i]objectForKey:@"country"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"country"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"country"];
                    
                    /*([[[temp objectAtIndex:i]objectForKey:@"country"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"country"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"country"];*/
                    
                    
                    NSString *city = ([[[temp objectAtIndex:i]objectForKey:@"city"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"city"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"city"];
                    
                    
                NSMutableDictionary *customer1 = [[NSMutableDictionary alloc]init];
                [customer1 setObject:CustomerID forKey:@"id"];
                [customer1 setObject:[NSString stringWithFormat:@"%@ %@",fname,lastname] forKey:@"customerName"];
                [customer1 setObject:customerPhotos forKey:@"customerPhotos"];
                [customer1 setObject:date_created forKey:@"memberFrom"];
                [customer1 setObject:plain_phone forKey:@"phNo"];
                [customer1 setObject:address forKey:@"address"];
                
                [customer1 setObject:email forKey:@"email"];
                [customer1 setObject:state forKey:@"state"];
                [customer1 setObject:zip forKey:@"zip"];
                [customer1 setObject:country forKey:@"country"];
                [customer1 setObject:city forKey:@"city"];
                    
                [customer1 setObject:@"NO" forKey:@"selected"];
                [customerListArray addObject:customer1];
                }
            }
            
            tableCustomaerList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
            [tableCustomaerList setDataSource:self];
            [tableCustomaerList setDelegate:self];
            [tableCustomaerList reloadData];
            
            
            
            NSLog(@"mylistingArray======%@",customerListArray);
            
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
           //currentBlnc=@"0.00";
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




-(void)searchBarLayout{
    searchBarCustomerList.delegate = self;
    [searchBarCustomerList setShowsScopeBar:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numOfSections = 0;
    
    if (searchActive) {
        if(searchArrCustomer.count < 1)
        {
            UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableCustomaerList.bounds.size.width, tableCustomaerList.bounds.size.height)];
            noDataLabel.text             = searchErrTxt;
            noDataLabel.textColor        = [UIColor blackColor];
            noDataLabel.textAlignment    = NSTextAlignmentCenter;
            tableCustomaerList.backgroundView = noDataLabel;
            tableCustomaerList.separatorStyle = UITableViewCellSeparatorStyleNone;
            numOfSections = 0;
        }
        else
        {
            numOfSections = 1;
            tableCustomaerList.backgroundView = nil;
            tableCustomaerList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
    }
    else
    {
        if(customerListArray.count < 1)
        {
            UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableCustomaerList.bounds.size.width, tableCustomaerList.bounds.size.height)];
            noDataLabel.text             = @"No data available";
            noDataLabel.textColor        = [UIColor blackColor];
            noDataLabel.textAlignment    = NSTextAlignmentCenter;
            tableCustomaerList.backgroundView = noDataLabel;
            tableCustomaerList.separatorStyle = UITableViewCellSeparatorStyleNone;
            numOfSections = 0;
        }
        else
        {
            numOfSections = 1;
            tableCustomaerList.backgroundView = nil;
            tableCustomaerList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        
    }
    
    return numOfSections;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (searchActive) {
        return searchArrCustomer.count;
    }
    else
    {
        if(customerListArray.count > 0)
        {
            return customerListArray.count;
        }
        else
            return 0;
    }
    return 0;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"sendMoneyCustomerListCell";
    customerListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[customerListCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    return cell.frame.size.height;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (searchActive) {
        dummyArr = searchArrCustomer;
    }
    else
    {
        dummyArr = customerListArray;
    }
    
    static NSString *cellIdentifier = @"sendMoneyCustomerListCell";
    customerListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[customerListCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    
    
    NSString *name = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"customerName"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"customerName"];
    
    [cell.customerNamelbl setText:name];
    cell.customerNamelbl.layer.masksToBounds=YES;
    [cell.customerNamelbl setTextAlignment:NSTextAlignmentLeft];
    [ cell.customerNamelbl setTextColor:[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0]];
    // [cell.prflSubnamelbl setFrame:CGRectMake(0,10,100,30)];
    
    NSString *memberSince = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"memberFrom"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"memberFrom"];
    
    [cell.memberSincelbl setText:[NSString stringWithFormat:@"Member Since : %@", memberSince]];
    cell.memberSincelbl.layer.masksToBounds=YES;
    [cell.memberSincelbl setTextAlignment:NSTextAlignmentLeft];
    [ cell.memberSincelbl setTextColor:[UIColor grayColor]];
    // cell.cardNoLbl.textColor = [UIColor blackColor];
    //button.layer.cornerRadius = 0.5 * button.bounds.size.width;
    //////////////
    NSString *phone_no = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"phNo"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"phNo"];
    
    [cell.phNolbl setText:phone_no];
    cell.phNolbl.layer.masksToBounds=YES;
    [cell.phNolbl setTextAlignment:NSTextAlignmentLeft];
    [ cell.phNolbl setTextColor:[UIColor grayColor]];
    
    
    NSString *address = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"address"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"address"];
    
    [cell.addresslbl setText:address];
    cell.addresslbl.layer.masksToBounds=YES;
    [cell.addresslbl setTextAlignment:NSTextAlignmentLeft];
    [ cell.addresslbl setTextColor:[UIColor grayColor]];
    
    /////////////////
    
    /*
    NSString *selected = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"selected"] isKindOfClass:[NSNull class]]?@"NO":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"selected"];
    //cell.customerSelectBtn.layer.cornerRadius = cell.selected.frame.size.width * 0.5;
    cell.customerSelectBtn.tag = indexPath.row;
    [cell.customerSelectBtn addTarget:self action:@selector(selectCardBtn:) forControlEvents:UIControlEventAllEvents];
    if ([selected isEqualToString:@"NO"]) {
        [cell.customerSelectBtn setBackgroundColor:[UIColor whiteColor]];
    }
    else
    {
        [cell.customerSelectBtn setBackgroundColor:[UIColor redColor]];
    }
    */
    
    NSString *customerImg = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"customerPhotos"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"customerPhotos"];
    NSLog(@"imageName%d---%@",indexPath.row,customerImg);
    
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
                                   cell.customerImg.layer.cornerRadius = cell.customerImg.frame.size.width / 2;
                                   cell.customerImg.clipsToBounds = YES;
                                   
                                   [cell.customerImg setImage:image];
                               }
                               else{
                                   cell.customerImg.layer.cornerRadius = cell.customerImg.frame.size.width / 2;
                                   cell.customerImg.clipsToBounds = YES;
                                  // [cell.profileImage setImage:[UIImage imageNamed:@"userIcon"]];
                                    [cell.customerImg setImage:[UIImage imageNamed:@"01_logo_screen-1.png"]];
                               }
                               
                           }];
    

    }
    else{
        
        [cell.customerImg setImage:[UIImage imageNamed:@"01_logo_screen-1.png"]];
    }
    
   /* if(![customerImg isEqualToString:@""]){
        [cell.customerImg setImage:[UIImage imageNamed:customerImg]];
    }
    else
    {
        [cell.customerImg setImage:[UIImage imageNamed:@"01_logo_screen-1.png"]];
    }
    */
    cell.customerSelectBtn.layer.cornerRadius = cell.customerSelectBtn.frame.size.width / 2;
    //cell.cardImg.contentMode =  UIViewContentModeScaleAspectFit;
    
    // [cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    //[cell.contentView.layer setBorderWidth:0.3f];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([temp count]> 0)
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        sentMoneyCustomerDetails *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"SBsentMoneyCustomerList"];
        if(searchActive)
        {
            vc.customerListArr = [searchArrCustomer objectAtIndex:indexPath.row];
        }
        else
        {
            vc.customerListArr = [customerListArray objectAtIndex:indexPath.row];
        }
        
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        [[self navigationController] pushViewController:vc animated:YES];
    }
    
    
    //static NSString *cellIdentifier = @"customerListCell";
   // customerListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    /*if (cell == nil)
     {
     cell = [[customerListCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
     }*/
    
    //[cell.customerSelectBtn setBackgroundColor:[UIColor redColor]];
    
    
}
// for nevigation bar
-(void) barButtonFunction
{
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"]
                                                                         style:UIBarButtonItemStylePlain target:self action:@selector(popView:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    /*
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
     */
    
    [self.navigationController.navigationBar setBarTintColor:navigationBarColor];
    
}
-(void)popView:(UIBarButtonItem *)sender
{
    [appDel setBothMenus];
}
- (IBAction)addCustomerBtnTapped:(id)sender {
    NSLog(@"You currently have no active sales");
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    addCustomerVC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"SBaddCustomer"];
    // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
    [[self navigationController] pushViewController:vc animated:YES];
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    searchBarCustomerList.showsCancelButton = YES;
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchDisplayControllerDidBeginSearch");
}
- (void)searchBar:(UISearchBar* )searchBar textDidChange:(NSString* )searchText
{
    // NSLog(@"textchange--%@",dealArray4);
    [searchArrCustomer removeAllObjects];
    for (int incr=0; incr<[customerListArray count]; incr++) {
        //NSRange fnameRange = [[[dealArray2 objectAtIndex:incr] valueForKey:@"fname"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
        NSRange customerName = [[[customerListArray objectAtIndex:incr] valueForKey:@"customerName"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        if (customerName.length > 0) {//fnameRange.length > 0 ||
            [searchArrCustomer addObject:[customerListArray objectAtIndex:incr]];
        }
        else
        {
            searchErrTxt = @"No search results found.";
        }
    }
   // NSLog(@"RequestSearchArr===%@",searchArrCustomer);
    searchActive = YES;
    //NSLog(@"Search Data Count: %lu", (unsigned long)self->searchDataArr.count);
    [self.tableCustomaerList reloadData];
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //[searchArrCustomer removeAllObjects];
    [searchBarCustomerList resignFirstResponder];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidEndEditing");
    searchActive = NO;
    [self.searchBarCustomerList resignFirstResponder];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarCancelButtonClicked");
    [self.searchBarCustomerList setShowsCancelButton:NO animated:YES];
    [self.searchBarCustomerList resignFirstResponder];
    searchActive = NO;
    [tableCustomaerList reloadData];
    self.searchBarCustomerList.text = @"";
}






@end
