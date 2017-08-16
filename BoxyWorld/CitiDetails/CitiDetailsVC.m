//
//  CitiDetailsVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 13/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "CitiDetailsVC.h"
#import "AccessNoCTDetailsCell.h"
#import "config.h"
#import "SWRevealViewController.h"
#import "addCustomerVC.h"
#import "AppDelegate.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
@interface CitiDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *appDel;
    MBProgressHUD *hud;
    NSString *userId ;
    NSString *athenticationKey;
    NSMutableArray *Cities,*data ;

}
@end

@implementation CitiDetailsVC
@synthesize lblTitle,tblCitiesList,CountryCode;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDel = [AppDelegate instance];
    Cities=[[NSMutableArray alloc]init];
    data=[[NSMutableArray alloc]init];
    self.title = @"Access Numbers";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self barButtonFunction];
    // Do any additional setup after loading the view.
    [tblCitiesList registerNib:[UINib nibWithNibName:@"AccessNoCTDetailsCell" bundle:nil]forCellReuseIdentifier:@"AccessNoCTDetailsCell"];
    NSString *uppercase = [CountryCode uppercaseString];
    CountryCode =  uppercase;
    lblTitle.text =[NSString stringWithFormat:@"%@ Cities",CountryCode];
    
    tblCitiesList.layer.borderWidth = 1.0f;
    tblCitiesList.layer.borderColor=[UIColor grayColor].CGColor;
    [self loadcitisByCountry];
    
    [tblCitiesList setDataSource:self];
    [tblCitiesList setDelegate:self];
    tblCitiesList.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return data.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125.0;
}
/*
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AccessNoCTDetailsCell";
    AccessNoCTDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[AccessNoCTDetailsCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    return cell.frame.size.height;
    
}
*/

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIdentifier = @"AccessNoCTDetailsCell";
    AccessNoCTDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[AccessNoCTDetailsCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
   
    //lblcountryName,lblState,lblcity,lblAccNo;
    NSLog(@"testdata==%@",data[0]);
    
    NSString *state = [data[indexPath.row]objectForKey:@"state"];
    NSString *city = [data[indexPath.row]objectForKey:@"city"];
     NSString *number = [data[indexPath.row]objectForKey:@"numbers"];
    
    [cell.lblcountryName setText:[NSString stringWithFormat:@"%@",[CountryCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]];
    
    [cell.lblState setText:[NSString stringWithFormat:@"%@",state]];
    [cell.lblcity setText:[NSString stringWithFormat:@"%@",city]];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[number dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    cell.lblAccNo.attributedText = attrStr;
    [cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.contentView.layer setBorderWidth:0.5f];
    cell.selectionStyle =  UITableViewCellSelectionStyleGray;
    NSString *uppercase = [cell.lblcountryName.text uppercaseString];
    cell.lblcountryName.text =  uppercase;
    
   // [cell.lblTitle setText:[NSString stringWithFormat:@"show all %@ cities ",code]];
    
    /* NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[rates dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
     cell.txtRates.attributedText = attrStr;
     
     [cell.txttitle setText:title];
     [cell.txtPhno setText:phon];
     // [cell.txtRates setText:rates];
     [cell.txtmis setText:mis];
     // }*/
   /* cell.btnSelect.layer.cornerRadius = cell.btnSelect.frame.size.width / 2;
    [cell.btnSelect.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.btnSelect.layer setBorderWidth:1.5f];
    [cell.prflSubnamelbl setFrame:CGRectMake(0,10,100,30)];
    [cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.contentView.layer setBorderWidth:0.5f];
    cell.selectionStyle =  UITableViewCellSelectionStyleGray;*/
    //cell.lblcountryName.textAlignment = NSTextAlignmentLeft;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *cellIdentifier = @"AccessNoCTDetailsCell";
    AccessNoCTDetailsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[AccessNoCTDetailsCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    */
   
    
    
    
}
//load all cities
-(void)loadcitisByCountry
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
                CountryCode,@"country",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_ACCESSNUMBERS];
    //NSLog(@"URL====%@",URL);
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
       // NSLog(@"city Details===%@",json);
        NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
           
            data=[[json objectForKey:@"data"]objectForKey:@"cities"];
            
            NSLog(@"data***%@",data);
            [tblCitiesList reloadData];
                    }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            
        }
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        //registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        //[[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}

//navigation bar
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
   // [appDel setBothMenus];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
