//
//  subAgentVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 23/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "subAgentVC.h"
#import "config.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "subAgentCell.h"
#import "addSubAgentVC.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "ViewController.h"
@interface subAgentVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    AppDelegate *appDel;
    MBProgressHUD *hud;
    NSString *userId ;
    NSString *athenticationKey ;
    NSMutableArray *searchArrSubAgent,*dummyArr,*subAgentArr;
    NSMutableArray *temp;
    NSString *searchErrTxt;
    BOOL searchActive;
}
@end

@implementation subAgentVC
@synthesize btnMoneyTransferToAgent,btnTransferHistory,agentSearchBar,tblviewAgent,btnSubAgent;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDel = [AppDelegate instance];
    [self searchBarLayout];
    [self barButtonFunction];
    self.title = @"Sub Agent";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    btnSubAgent.layer.cornerRadius = 6.0f;
    [btnSubAgent setTitle:@"  Add New Sub Agent" forState:UIControlStateNormal];
    
    btnMoneyTransferToAgent.layer.cornerRadius = 6.0f;
    [btnMoneyTransferToAgent setTitle:@"  Transfer Money to Agent" forState:UIControlStateNormal];
    
    btnTransferHistory.layer.cornerRadius = 6.0f;
    [btnTransferHistory setTitle:@"  Transfer History" forState:UIControlStateNormal];
    
    searchArrSubAgent = [[NSMutableArray alloc]init];
    dummyArr = [[NSMutableArray alloc]init];
    [self searchBarLayout];
    [self barButtonFunction];
    self.title = @"Sub Agent";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
   
    subAgentArr = [[NSMutableArray alloc]init];
    [agentSearchBar setDelegate:self];
    
    [tblviewAgent registerNib:[UINib nibWithNibName:@"subAgentCell" bundle:nil]forCellReuseIdentifier:@"subAgentCell"];
    
    [self getDashBoardData];
    [tblviewAgent setDataSource:self];
    [tblviewAgent setDelegate:self];
    
    // Do any additional setup after loading the view.
    agentListArray = [[NSMutableArray alloc]init];
    
    
   
    
   
    
    
    

    
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
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETSubAgent];
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
        //NSLog(@"json-----%@",json);
        NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]) {
            temp = [[NSMutableArray alloc]init];
            temp = [json objectForKey:@"data"];
            if([temp count] > 0)
            {
                for(int i=0;i<[temp count];i++)
                {
                    NSString *fname = ([[[temp objectAtIndex:i]objectForKey:@"firstname"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"firstname"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"firstname"];
                    
                    NSString *lastname = ([[[temp objectAtIndex:i]objectForKey:@"lastname"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"lastname"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"lastname"];
                    
                    NSString *date_created = ([[[temp objectAtIndex:i]objectForKey:@"create_date"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"create_date"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"create_date"];
                    
                    NSString *plain_phone = ([[[temp objectAtIndex:i]objectForKey:@"plain_phone"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"plain_phone"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"plain_phone"];
                    
                    NSString *address = ([[[temp objectAtIndex:i]objectForKey:@"address"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"address"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"address"];
                    
                    NSString *customerPhotos = ([[[temp objectAtIndex:i]objectForKey:@"customerPhotos"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"customerPhotos"] == nil)?@"userIcon":[[temp objectAtIndex:i]objectForKey:@"customerPhotos"];
                    
                    NSString *email = ([[[temp objectAtIndex:i]objectForKey:@"email"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"email"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"email"];
                    NSString *state = ([[[temp objectAtIndex:i]objectForKey:@"state"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"state"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"state"];
                    NSString *zip = ([[[temp objectAtIndex:i]objectForKey:@"zip"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"zip"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"zip"];
                    NSString *country = ([[[temp objectAtIndex:i]objectForKey:@"country"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"country"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"country"];
                    NSString *city = ([[[temp objectAtIndex:i]objectForKey:@"city"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"city"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"city"];
                     NSString *cash = ([[[temp objectAtIndex:i]objectForKey:@"cash"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"cash"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"cash"];
                    NSString *commission = ([[[temp objectAtIndex:i]objectForKey:@"commission"]isKindOfClass:[NSNull class]] || [[temp objectAtIndex:i]objectForKey:@"commission"] == nil)?@"":[[temp objectAtIndex:i]objectForKey:@"commission"];
                    
                    NSMutableDictionary *agent1 = [[NSMutableDictionary alloc]init];
                    [agent1 setObject:[NSString stringWithFormat:@"%@ %@",fname,lastname] forKey:@"agentName"];
                    [agent1 setObject:email forKey:@"email"];
                    [agent1 setObject:date_created forKey:@"since"];
                    [agent1 setObject:plain_phone forKey:@"phNo"];
                    [agent1 setObject:cash forKey:@"cash"];
                    [agent1 setObject:commission forKey:@"commision"];
                    
                    
                    [subAgentArr addObject:agent1];
                }
            }
            
            tblviewAgent.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
            [tblviewAgent setDataSource:self];
            [tblviewAgent setDelegate:self];
            [tblviewAgent reloadData];
            
            
            
            NSLog(@"subAgentArr======%@",subAgentArr);
            
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
    agentSearchBar.delegate = self;
    [agentSearchBar setShowsScopeBar:YES];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numOfSections = 0;
    
    if (searchActive) {
        if(searchArrSubAgent.count < 1)
        {
            UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tblviewAgent.bounds.size.width, tblviewAgent.bounds.size.height)];
            noDataLabel.text             = searchErrTxt;
            noDataLabel.textColor        = [UIColor blackColor];
            noDataLabel.textAlignment    = NSTextAlignmentCenter;
            tblviewAgent.backgroundView = noDataLabel;
            tblviewAgent.separatorStyle = UITableViewCellSeparatorStyleNone;
            numOfSections = 0;
        }
        else
        {
            numOfSections = 1;
            tblviewAgent.backgroundView = nil;
            tblviewAgent.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
    }
    else
    {
        if(subAgentArr.count < 1)
        {
            UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tblviewAgent.bounds.size.width, tblviewAgent.bounds.size.height)];
            noDataLabel.text             = @"No data available";
            noDataLabel.textColor        = [UIColor blackColor];
            noDataLabel.textAlignment    = NSTextAlignmentCenter;
            tblviewAgent.backgroundView = noDataLabel;
            tblviewAgent.separatorStyle = UITableViewCellSeparatorStyleNone;
            numOfSections = 0;
        }
        else
        {
            numOfSections = 1;
            tblviewAgent.backgroundView = nil;
            tblviewAgent.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        
    }
    
    return numOfSections;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (searchActive) {
        return searchArrSubAgent.count;
    }
    else
    {
        if(subAgentArr.count > 0)
        {
            return subAgentArr.count;
        }
        else
            return 0;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"subAgentCell";
    subAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[subAgentCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    return cell.frame.size.height;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (searchActive) {
        dummyArr = searchArrSubAgent;
    }
    else
    {
        dummyArr = subAgentArr;
    }
    
    static NSString *cellIdentifier = @"subAgentCell";
   subAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[subAgentCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    
    
    NSString *agentName = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"agentName"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"agentName"];
    
    [cell.lblAgentName setText:agentName];
    cell.lblAgentName.layer.masksToBounds=YES;
    [cell.lblAgentName setTextAlignment:NSTextAlignmentLeft];
    [ cell.lblAgentName setTextColor:[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0]];
    // [cell.prflSubnamelbl setFrame:CGRectMake(0,10,100,30)];
    
    NSString *agentSince = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"since"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"since"];
    
    //[cell.lblSince setText:[NSString stringWithFormat:@"Member Since : %@", memberSince]];
    [cell.lblSince setText:agentSince];
    cell.lblSince.layer.masksToBounds=YES;
    [cell.lblSince setTextAlignment:NSTextAlignmentLeft];
    [ cell.lblSince setTextColor:[UIColor grayColor]];
    // cell.cardNoLbl.textColor = [UIColor blackColor];
    //button.layer.cornerRadius = 0.5 * button.bounds.size.width;
    //////////////
    NSString *agentPhNo = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"phNo"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"phNo"];
    
    [cell.lblPhno setText:agentPhNo];
    cell.lblPhno.layer.masksToBounds=YES;
    [cell.lblPhno setTextAlignment:NSTextAlignmentLeft];
    [ cell.lblPhno setTextColor:[UIColor grayColor]];
    
    
    NSString *agentEmail = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"email"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"email"];
    
    [cell.lblEmail setText:agentEmail];
    cell.lblEmail.layer.masksToBounds=YES;
    [cell.lblEmail setTextAlignment:NSTextAlignmentLeft];
    [ cell.lblEmail setTextColor:[UIColor grayColor]];
    
    /////////////////
    NSString *cash = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"cash"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"cash"];
    
    [cell.lblCash setText:[NSString stringWithFormat:@"$ %@",cash]];
    cell.lblCash.layer.masksToBounds=YES;
    [cell.lblCash setTextAlignment:NSTextAlignmentLeft];
    [ cell.lblCash setTextColor:[UIColor grayColor]];
    
    NSString *commision = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"commision"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"commision"];
    NSString *p=@"%";
    [cell.lblCommision setText:[NSString stringWithFormat:@"%@%@",commision,p]];
    cell.lblCommision.layer.masksToBounds=YES;
    [cell.lblCommision setTextAlignment:NSTextAlignmentLeft];
    [ cell.lblCommision setTextColor:[UIColor grayColor]];

    /*
     [cell.btnEdit addTarget:self action:@selector(editSubAgent:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnEdit.accessibilityLabel = @"edit";
    cell.btnEdit.tag = indexPath.row;
    */
        [cell.btnEdit setBackgroundImage:[UIImage imageNamed:@"edit"] forState:normal];
        [cell.imgdelete setHidden:YES];
    
        [cell.btnEdit setTintColor:[UIColor whiteColor]];
    
    
     [cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
     [cell.contentView.layer setBorderWidth:1.0f];
    
    
    
       return cell;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    agentSearchBar.showsCancelButton = YES;
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchDisplayControllerDidBeginSearch");
}
- (void)searchBar:(UISearchBar* )searchBar textDidChange:(NSString* )searchText
{
    // NSLog(@"textchange--%@",dealArray4);
    [searchArrSubAgent removeAllObjects];
    for (int incr=0; incr<[subAgentArr count]; incr++) {
        //NSRange fnameRange = [[[dealArray2 objectAtIndex:incr] valueForKey:@"fname"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
        NSRange agentName = [[[subAgentArr objectAtIndex:incr] valueForKey:@"agentName"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        if (agentName.length > 0) {//fnameRange.length > 0 ||
            [searchArrSubAgent addObject:[subAgentArr objectAtIndex:incr]];
        }
        else
        {
            searchErrTxt = @"No search results found.";
        }
    }
    // NSLog(@"RequestSearchArr===%@",searchArrCustomer);
    searchActive = YES;
    //NSLog(@"Search Data Count: %lu", (unsigned long)self->searchDataArr.count);
    [self.tblviewAgent reloadData];
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //[searchArrCustomer removeAllObjects];
    [agentSearchBar resignFirstResponder];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidEndEditing");
    searchActive = NO;
    [self.agentSearchBar resignFirstResponder];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarCancelButtonClicked");
    [self.agentSearchBar setShowsCancelButton:NO animated:YES];
    [self.agentSearchBar resignFirstResponder];
    searchActive = NO;
    [tblviewAgent reloadData];
    self.agentSearchBar.text = @"";
}

- (IBAction)tapAddSubAgentBtn:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    addSubAgentVC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"SBaddSubAgent"];
    // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
    [[self navigationController] pushViewController:vc animated:YES];
}
- (IBAction)tapTransferMoneyAgent:(id)sender {
}
- (IBAction)btnTransferHistory:(id)sender {
}


/*
-(void)editCustomer:(UIButton *)sender
{
    //NSString *editSelect =
    int tag = (int)sender.tag;
    NSString *type  = sender.accessibilityLabel;
    NSLog(@"tag==%d----type=%@",tag,type);
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    addCustomerVC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"SBaddCustomer"];
    vc.editCustomerId = [NSString stringWithFormat:@"%d",tag];
    vc.type =type;
    vc.customerDetailsArr = [customerListArray objectAtIndex:tag];
    [[self navigationController] pushViewController:vc animated:YES];
    
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
