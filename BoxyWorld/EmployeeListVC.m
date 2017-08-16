//
//  EmployeeListVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 07/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "EmployeeListVC.h"
#import "EmployeeListCell.h"
#import "config.h"
#import "SWRevealViewController.h"
#import "addCustomerVC.h"
#import "AppDelegate.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "ViewController.h"
#import "addEmployee.h"
//#import "SWRevealViewController.h"
@interface EmployeeListVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    MBProgressHUD *hud;
    AppDelegate *appDel;
    NSString *userId ;
    NSString *athenticationKey ;
    NSMutableArray *searchArrEmployee,*dummyArr;
    NSString *searchErrTxt;
    BOOL searchActive;
}

@end

@implementation EmployeeListVC
@synthesize btnAddEmployee,btnSearch,tblEmplyList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDel = [AppDelegate instance];
    searchArrEmployee = [[NSMutableArray alloc]init];
    dummyArr = [[NSMutableArray alloc]init];
    [self searchBarLayout];
    [self barButtonFunction];
    self.title = @"Employees List";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    btnAddEmployee.layer.cornerRadius = 6.0f;
    [btnAddEmployee setTitle:@"  Add New Employee" forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
    employeeListArray = [[NSMutableArray alloc]init];
    [btnSearch setDelegate:self];
    
    [tblEmplyList registerNib:[UINib nibWithNibName:@"EmployeeListCell" bundle:nil]forCellReuseIdentifier:@"EmployeeListCell"];
    
    [self getDashBoardData];
    [tblEmplyList setDataSource:self];
    [tblEmplyList setDelegate:self];
    

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
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETEMPLOYEE];
   // NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // NSLog(@"URL==%@",URL);
    //NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"json- employee----%@",json);
        NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]) {
            NSMutableArray *temp = [[NSMutableArray alloc]init];
            temp = [json objectForKey:@"data"];
            if([temp count] > 0)
            {
                for(int i=0;i<[temp count];i++)
                {
                    NSString *fname = ([[[temp objectAtIndex:i]objectForKey:@"firstname"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"firstname"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"firstname"];
                    
                    NSString *lastname = ([[[temp objectAtIndex:i]objectForKey:@"lastname"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"lastname"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"lastname"];
                    
                      NSString *email = ([[[temp objectAtIndex:i]objectForKey:@"email"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"email"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"email"];
                    
                    NSString *created_at = ([[[temp objectAtIndex:i]objectForKey:@"created_at"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"created_at"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"created_at"];
                    
                    NSString *plain_phone = ([[[temp objectAtIndex:i]objectForKey:@"plain_phone"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"plain_phone"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"plain_phone"];
                    
                    NSString *imtu_active = ([[[temp objectAtIndex:i]objectForKey:@"imtu_active"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"imtu_active"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"imtu_active"];
                    NSString *imtuYN;
                    if([imtu_active isEqualToString:@"1"])
                    {
                      imtuYN=@"Yes";
                        
                    }
                    else{
                        imtuYN=@"No";
                    }
                    
                    NSString *pinless_active = ([[[temp objectAtIndex:i]objectForKey:@"pinless_active"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"pinless_active"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"pinless_active"];
                    NSString *pinlessYN;
                    if([pinless_active isEqualToString:@"1"])
                    {
                        pinlessYN=@"Yes";
                        
                    }
                    else{
                        pinlessYN=@"No";
                    }

                    
                    NSString *sendmoney_active = ([[[temp objectAtIndex:i]objectForKey:@"sendmoney_active"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"sendmoney_active"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"sendmoney_active"];
                    NSString *SentMoneyYN;
                    if([sendmoney_active isEqualToString:@"1"])
                    {
                        SentMoneyYN=@"Yes";
                        
                    }
                    else{
                        SentMoneyYN=@"No";
                    }
                    
                    
                    NSString *activeField = ([[[temp objectAtIndex:i]objectForKey:@"active"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"active"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"active"];
                    
                    
                    NSString *countryId = ([[[temp objectAtIndex:i]objectForKey:@"country"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"country"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"country"];
                    
                    NSString *address = ([[[temp objectAtIndex:i]objectForKey:@"address"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"address"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"address"];
                    
                    NSString *city = ([[[temp objectAtIndex:i]objectForKey:@"city"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"city"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"city"];
                    
                    NSString *zip = ([[[temp objectAtIndex:i]objectForKey:@"zip"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"zip"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"zip"];
                    
                    /*NSString *cCode = ([[[temp objectAtIndex:i]objectForKey:@"country"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"country"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"country"];*/
                    
                    NSString *employeeId = ([[[temp objectAtIndex:i]objectForKey:@"id"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"id"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"id"];
                    
                    NSMutableDictionary *Employee1 = [[NSMutableDictionary alloc]init];
                    [Employee1 setObject:[NSString stringWithFormat:@"%@ %@",fname,lastname] forKey:@"employeeName"];
                    //[Employee1 setObject:customerPhotos forKey:@"customerPhotos"];
                    [Employee1 setObject:fname forKey:@"fname"];
                    [Employee1 setObject:lastname forKey:@"lastname"];
                     [Employee1 setObject:created_at forKey:@"since"];
                     [Employee1 setObject:email forKey:@"email"];
                     [Employee1 setObject:plain_phone forKey:@"phNo"];
                     [Employee1 setObject:imtuYN forKey:@"imtu"];
                     [Employee1 setObject:pinlessYN forKey:@"pinless"];
                     [Employee1 setObject:SentMoneyYN forKey:@"sentMoney"];
                     [Employee1 setObject:activeField forKey:@"activeField"];
                      [Employee1 setObject:countryId forKey:@"countryId"];
                      [Employee1 setObject:address forKey:@"address"];
                      [Employee1 setObject:city forKey:@"city"];
                      [Employee1 setObject:zip forKey:@"zip"];
                      [Employee1 setObject:employeeId forKey:@"employeeId"];
                      //[Employee1 setObject:activeField forKey:@"activeField"];
                    [employeeListArray addObject:Employee1];
                }
            }
            
            tblEmplyList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
            [tblEmplyList setDataSource:self];
            [tblEmplyList setDelegate:self];
            [tblEmplyList reloadData];
            
            
            
          //  NSLog(@"mylistingArray======%@",employeeListArray);
            
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
    btnSearch.delegate = self;
    [btnSearch setShowsScopeBar:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numOfSections = 0;
    
    if (searchActive) {
        if(searchArrEmployee.count < 1)
        {
            UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tblEmplyList.bounds.size.width, tblEmplyList.bounds.size.height)];
            noDataLabel.text             = searchErrTxt;
            noDataLabel.textColor        = [UIColor blackColor];
            noDataLabel.textAlignment    = NSTextAlignmentCenter;
            tblEmplyList.backgroundView = noDataLabel;
            tblEmplyList.separatorStyle = UITableViewCellSeparatorStyleNone;
            numOfSections = 0;
        }
        else
        {
            numOfSections = 1;
            tblEmplyList.backgroundView = nil;
            tblEmplyList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
    }
    else
    {
        if(employeeListArray.count < 1)
        {
            UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tblEmplyList.bounds.size.width, tblEmplyList.bounds.size.height)];
            noDataLabel.text             = @"No data available";
            noDataLabel.textColor        = [UIColor blackColor];
            noDataLabel.textAlignment    = NSTextAlignmentCenter;
            tblEmplyList.backgroundView = noDataLabel;
            tblEmplyList.separatorStyle = UITableViewCellSeparatorStyleNone;
            numOfSections = 0;
        }
        else
        {
            numOfSections = 1;
            tblEmplyList.backgroundView = nil;
            tblEmplyList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        
    }
    
    return numOfSections;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (searchActive) {
        return searchArrEmployee.count;
    }
    else
    {
        if(employeeListArray.count > 0)
        {
            return employeeListArray.count;
        }
        else
            return 0;
    }
    return 0;
   
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"EmployeeListCell";
    EmployeeListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[EmployeeListCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    return cell.frame.size.height;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (searchActive) {
        dummyArr = searchArrEmployee;
    }
    else
    {
        dummyArr = employeeListArray;
    }
    
    static NSString *cellIdentifier = @"EmployeeListCell";
    EmployeeListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[EmployeeListCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
     NSString *name = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"employeeName"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"employeeName"];
    NSLog(@"employeeName%@",name);
    [cell.txtname setText:name];
    cell.txtname.layer.masksToBounds=YES;
    [cell.txtname setTextAlignment:NSTextAlignmentLeft];
    [ cell.txtname setTextColor:[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0]];
    // [cell.prflSubnamelbl setFrame:CGRectMake(0,10,100,30)];
    
    NSString *Since = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"since"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"since"];
    
    [cell.txtSince setText:Since];//[NSString stringWithFormat:@"Member Since : %@", Since]];
    cell.txtSince.layer.masksToBounds=YES;
    [cell.txtSince setTextAlignment:NSTextAlignmentLeft];
    [ cell.txtSince setTextColor:[UIColor grayColor]];
    // cell.cardNoLbl.textColor = [UIColor blackColor];
    //button.layer.cornerRadius = 0.5 * button.bounds.size.width;
    //////////////
    NSString *Email = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"email"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"email"];
    
    [cell.txtEmail setText:Email];
    cell.txtEmail.layer.masksToBounds=YES;
    [cell.txtEmail setTextAlignment:NSTextAlignmentLeft];
    [ cell.txtEmail setTextColor:[UIColor grayColor]];
    
    
    NSString *Phno = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"phNo"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"phNo"];
    
    [cell.txtPhno setText:Phno];
    cell.txtPhno.layer.masksToBounds=YES;
    [cell.txtPhno setTextAlignment:NSTextAlignmentLeft];
    [ cell.txtPhno setTextColor:[UIColor grayColor]];
    
    
    NSString *IMTU = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"imtu"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"imtu"];
    
    [cell.txtIMTU setText:IMTU];
    cell.txtIMTU.layer.masksToBounds=YES;
    [cell.txtIMTU setTextAlignment:NSTextAlignmentLeft];
    [ cell.txtIMTU setTextColor:[UIColor grayColor]];
   
    
    NSString *Pinless = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"pinless"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"pinless"];
    
    [cell.txtPinless setText:Pinless];
    cell.txtPinless.layer.masksToBounds=YES;
    [cell.txtPinless setTextAlignment:NSTextAlignmentLeft];
    [ cell.txtPinless setTextColor:[UIColor grayColor]];
    
    NSString *SentMoney = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"sentMoney"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"sentMoney"];
    
    [cell.txtSentMoney setText:SentMoney];
    cell.txtSentMoney.layer.masksToBounds=YES;
    [cell.txtSentMoney setTextAlignment:NSTextAlignmentLeft];
    [ cell.txtSentMoney setTextColor:[UIColor grayColor]];
    
    NSString *active_field = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"activeField"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"activeField"];
    
    if([active_field isEqualToString:@"1"]){
        cell.btnstatus.layer.cornerRadius = 5.0f;
        [cell.btnstatus setBackgroundColor:[UIColor greenColor]];
        [cell.btnstatus setTitle:@"ENABLE" forState:UIControlStateNormal];
         cell.btnstatus.layer.masksToBounds=YES;
        //[cell.btnstatus setTextAlignment:NSTextAlignmentLeft];
    
    }
    else{
        cell.btnstatus.layer.cornerRadius = 5.0f;
        [cell.btnstatus setBackgroundColor:[UIColor redColor]];
        [cell.btnstatus setTitle:@"DISABLE" forState:UIControlStateNormal];
        cell.btnstatus.layer.masksToBounds=YES;
        //[cell.btnstatus setTextAlignment:NSTextAlignmentLeft];
        
    }
    
    [cell.btnEdit addTarget:self action:@selector(editEmployee:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnEdit.accessibilityLabel = @"edit";
    cell.btnEdit.tag = indexPath.row;
      [cell.btnEdit setTintColor:[UIColor whiteColor]];
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
    
       return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    //[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addCustomerBtnTapped:(id)sender {
    NSLog(@"You currently have no active sales");
    
   /* NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    addEmployee * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"SBaddEmployee"];
    // [revealController setFrontViewPosition:vc1 animated:YES];
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
    [revealController pushFrontViewController:frontNavigationController animated:YES];*/
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    addEmployee *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"SBaddEmployee"];
    // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
    [[self navigationController] pushViewController:vc animated:YES];
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    btnSearch.showsCancelButton = YES;
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchDisplayControllerDidBeginSearch");
}
- (void)searchBar:(UISearchBar* )searchBar textDidChange:(NSString* )searchText
{
    NSLog(@"employeeListArray--%@",employeeListArray);
    [searchArrEmployee removeAllObjects];
    for (int incr=0; incr<[employeeListArray count]; incr++) {
        //NSRange fnameRange = [[[dealArray2 objectAtIndex:incr] valueForKey:@"fname"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
        NSRange customerName = [[[employeeListArray objectAtIndex:incr] valueForKey:@"employeeName"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
        NSRange customerEmail = [[[employeeListArray objectAtIndex:incr] valueForKey:@"email"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        if (customerName.length > 0 || customerEmail.length > 0) {
            [searchArrEmployee addObject:[employeeListArray objectAtIndex:incr]];
        }
        else
        {
            searchErrTxt = @"No search results found.";
        }
    }
    NSLog(@"RequestSearchArr===%@",searchArrEmployee);
    searchActive = YES;
    //NSLog(@"Search Data Count: %lu", (unsigned long)self->searchDataArr.count);
    [self.tblEmplyList reloadData];
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //[searchArrCustomer removeAllObjects];
    [btnSearch resignFirstResponder];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidEndEditing");
    searchActive = NO;
    [self.btnSearch resignFirstResponder];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarCancelButtonClicked");
    [self.btnSearch setShowsCancelButton:NO animated:YES];
    [self.btnSearch resignFirstResponder];
    searchActive = NO;
    [tblEmplyList reloadData];
    self.btnSearch.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)editEmployee:(UIButton *)sender
{
    //NSString *editSelect =
    int tag = (int)sender.tag;
    NSString *type  = sender.accessibilityLabel;
    NSLog(@"tag==%d----type=%@",tag,type);
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    addEmployee *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"SBaddEmployee"];
    vc.editEmployeeId = [NSString stringWithFormat:@"%d",tag];
    vc.type =type;
     vc.employeeDetailsArr = [employeeListArray objectAtIndex:tag];
    [[self navigationController] pushViewController:vc animated:YES];
    
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
