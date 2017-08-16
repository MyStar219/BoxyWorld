//
//  faqQstnVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 11/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "faqQstnVC.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "qstnCell.h"
#import "answerVC.h"
@interface faqQstnVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableArray *allFaqqstnArr;
    AppDelegate *appDel;
    MBProgressHUD *hud;
    NSString *userId ;
    NSString *athenticationKey;
    NSString *faqQstnId;
    NSString *Qstn;
    NSString *searchErrTxt;
    BOOL searchActive;
    NSMutableArray *searchArrFaQ,*dummyArr;
}

@end

@implementation faqQstnVC
@synthesize faq_cat_Id,faqtblview,btnSearch;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //faqCatagoryIcon = [[NSMutableArray alloc]init];
    self.title = @"FAQ";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self barButtonFunction];
    // [self buttonShowHide];
    // [self makeLayout];
    appDel = [AppDelegate instance];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //allFaqqstnArr = [[NSMutableArray alloc]init];
   allFaqqstnArr = [[NSMutableArray alloc]init];
     searchArrFaQ = [[NSMutableArray alloc]init];
    dummyArr = [[NSMutableArray alloc]init];
      [btnSearch setDelegate:self];
    [faqtblview registerNib:[UINib nibWithNibName:@"qstnCell" bundle:nil]forCellReuseIdentifier:@"qstnCell"];
    
    //[faqtblview setDataSource:self];
    //[faqtblview setDelegate:self];
    [self loadFAQ_Questions];
    
}
-(void)searchBarLayout{
    btnSearch.delegate = self;
    [btnSearch setShowsScopeBar:YES];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numOfSections = 0;
    
    if (searchActive) {
        if(searchArrFaQ.count < 1)
        {
            UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, btnSearch.bounds.size.width, btnSearch.bounds.size.height)];
            noDataLabel.text             = searchErrTxt;
            noDataLabel.textColor        = [UIColor blackColor];
            noDataLabel.textAlignment    = NSTextAlignmentCenter;
            faqtblview.backgroundView = noDataLabel;
            faqtblview.separatorStyle = UITableViewCellSeparatorStyleNone;
            numOfSections = 0;
        }
        else
        {
            numOfSections = 1;
            faqtblview.backgroundView = nil;
            faqtblview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
    }
    else
    {
        if(allFaqqstnArr.count < 1)
        {
            UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, btnSearch.bounds.size.width, btnSearch.bounds.size.height)];
            noDataLabel.text             = @"No data available";
            noDataLabel.textColor        = [UIColor blackColor];
            noDataLabel.textAlignment    = NSTextAlignmentCenter;
            faqtblview.backgroundView = noDataLabel;
            faqtblview.separatorStyle = UITableViewCellSeparatorStyleNone;
            numOfSections = 0;
        }
        else
        {
            numOfSections = 1;
            faqtblview.backgroundView = nil;
            faqtblview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        
    }
    
    return numOfSections;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (searchActive) {
        return searchArrFaQ.count;
    }
    else
    {
        if(allFaqqstnArr.count > 0)
        {
            return allFaqqstnArr.count;
        }
        else
            return 0;
    }
    return 0;

   // return allFaqqstnArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"qstnCell";
    qstnCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[qstnCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    return cell.frame.size.height;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (searchActive) {
        dummyArr = searchArrFaQ;
    }
    else
    {
        dummyArr = allFaqqstnArr;
    }
    

    
    NSLog(@"allFaqqstnArr/////%@",dummyArr);
    static NSString *cellIdentifier = @"qstnCell";
    qstnCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[qstnCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    
    NSString *qstn = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"question_text"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"question_text"];
    
    [cell.lblqstn setText:qstn];
    cell.lblqstn.layer.masksToBounds=YES;
    [cell.lblqstn setTextAlignment:NSTextAlignmentLeft];
    [ cell.lblqstn setTextColor:[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0]];
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    faqQstnId = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"id"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"id"];
    Qstn = [[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"question_text"] isKindOfClass:[NSNull class]]?@"":[[dummyArr objectAtIndex:(indexPath.row)]objectForKey:@"question_text"];
    //NSLog(@"allFaqCatagoryArr%@",allFaqCatagoryArr);
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    answerVC * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"faqAnswer"];
    vc2.qstnId=faqQstnId;
    vc2.Question = Qstn;
    [self.navigationController pushViewController:vc2 animated:YES];
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadFAQ_Questions
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
                  faq_cat_Id,@"category_id",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETFAQCATEGORYQUESTION];
    //NSLog(@"URL====FAQ%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // NSLog(@"URL==FaQ%@",URL);
   // NSLog(@"parameters==catagory%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [[NSDictionary alloc]init];
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
       // NSLog(@"FAQ=catagory==%@",json);
        
        NSString *status =[NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            
           
            allFaqqstnArr = [json objectForKey:@"data"];
            [faqtblview setDataSource:self];
            [faqtblview setDelegate:self];
            [faqtblview reloadData];
        }
        else{
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
//Back Button Action
- (IBAction)btnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:NO completion:nil];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//search button function

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
    // NSLog(@"textchange--%@",dealArray4);
    [searchArrFaQ removeAllObjects];
    for (int incr=0; incr<[allFaqqstnArr count]; incr++) {
        //NSRange fnameRange = [[[dealArray2 objectAtIndex:incr] valueForKey:@"fname"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
        NSRange qstn = [[[allFaqqstnArr objectAtIndex:incr] valueForKey:@"question_text"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        if (qstn.length > 0) {//fnameRange.length > 0 ||
            [searchArrFaQ addObject:[allFaqqstnArr objectAtIndex:incr]];
        }
        else
        {
            searchErrTxt = @"No search results found.";
        }
    }
    NSLog(@"RequestSearchArr===%@",searchArrFaQ);
    searchActive = YES;
    //NSLog(@"Search Data Count: %lu", (unsigned long)self->searchDataArr.count);
    [self.faqtblview reloadData];
    
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
    [faqtblview reloadData];
    self.btnSearch.text = @"";
}


@end
