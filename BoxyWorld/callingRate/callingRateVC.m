//
//  callingRateVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 12/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "callingRateVC.h"
#import "callingRateCell.h"
#import "config.h"
#import "SWRevealViewController.h"
#import "addCustomerVC.h"
#import "AppDelegate.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
@interface callingRateVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    MBProgressHUD *hud;
    AppDelegate *appDel;
    NSString *userId ;
    NSString *athenticationKey ;
     NSString *country_Id ;
    NSMutableArray *countryArr,*countryCodeArr,*countryPrefix;
    NSMutableArray *dumyArr,*allcallRateArr;
    NSString *tag;
}

@end

@implementation callingRateVC
@synthesize txtRate,btnGetRate,tblratelist,viewCallRate;
@synthesize dropcountry;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadRate];
     appDel = [AppDelegate instance];
    self.title = @"Calling Rates By Country";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self barButtonFunction];
    
    countryArr = [[NSMutableArray alloc]init];
    countryCodeArr = [[NSMutableArray alloc]init];
    countryPrefix = [[NSMutableArray alloc]init];
    dumyArr = [[NSMutableArray alloc]init];
    allcallRateArr= [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    [tblratelist registerNib:[UINib nibWithNibName:@"callingRateCell" bundle:nil]forCellReuseIdentifier:@"callingRateCell"];
     tag =@"1";
    [self loadCountry];
   // [tblratelist reloadData];
    [tblratelist setDataSource:self];
    [tblratelist setDelegate:self];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return allcallRateArr.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"callingRateCell";
    callingRateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[callingRateCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    return cell.frame.size.height;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
       
    static NSString *cellIdentifier = @"callingRateCell";
    callingRateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[callingRateCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    NSMutableArray *cellData = [[NSMutableArray alloc]init];
    
    cellData = [allcallRateArr objectAtIndex:indexPath.row];
    NSLog(@"cellData ==%@",cellData);
    //for(int j=0;j<cellData.count;j++){
    NSString *title =cellData[0];
    NSString *phon =cellData[1];
    NSString *rates =cellData[2];
    NSString *mis =cellData[3];
    NSLog(@"%@---%@",title,cellData[0]);
    NSLog(@"%@---%@",phon,cellData[1]);
    NSLog(@"%@---%@",rates,cellData[2]);
    NSLog(@"%@---%@",mis,cellData[4]);
   // @synthesize txttitle,txtPhno,txtRates,txtmis;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[rates dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    cell.txtRates.attributedText = attrStr;
    
    [cell.txttitle setText:title];
    [cell.txtPhno setText:phon];
   // [cell.txtRates setText:rates];
    [cell.txtmis setText:mis];
    // }
    // [cell.prflSubnamelbl setFrame:CGRectMake(0,10,100,30)];
    [cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.contentView.layer setBorderWidth:0.5f];
    
    
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
//load country
-(void)loadCountry
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
        //NSLog(@"country Data===%@",json);
        NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
        NSMutableArray *allcountryArr = [[NSMutableArray alloc]init];
        allcountryArr = [[json objectForKey:@"data"]objectForKey:@"countries"];
        
        for (int i=0; i<[allcountryArr count]; i++) {
            [countryArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryname"]];
            //[countryCodeArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"id"]];
            //[countryPrefix addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryprefix"]];
        }
         //NSLog(@"countryArr Data===%@",countryArr);
        //for drop down
        CGFloat phoneX = self.txtRate.frame.origin.x;
        CGFloat phoneY = self.txtRate.frame.origin.y;
        CGFloat phoneWidth = self.txtRate.frame.size.width;
        CGFloat phoneHeight = self.txtRate.frame.size.height;
        
        dropcountry = [[KPDropMenu alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneWidth, phoneHeight)];
        dropcountry.delegate = self;
        dropcountry.items = countryArr;
        //dropcountry.title = @"Select Country";
        dropcountry.titleColor=[UIColor whiteColor];
        dropcountry.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropcountry.titleTextAlignment = NSTextAlignmentLeft;
        dropcountry.DirectionDown = YES;
        [self.viewCallRate insertSubview:dropcountry aboveSubview:self.txtRate];
            [tblratelist reloadData];
            [tblratelist setDataSource:self];
            [tblratelist setDelegate:self];
          [self loadRate];
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

//load Rate
-(void)loadRate
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    
    NSDictionary *parameters;
    NSString *URL;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                 
                  nil];
    if([tag isEqualToString:@"1"]){
        NSString *country=@"nigeria";
        URL = [NSString stringWithFormat:@"%@%@",URL_CALLINGRATES,country];
     }
    else{
        NSString *selectCountry=[NSString stringWithFormat:@"%@",txtRate.text];
        URL = [NSString stringWithFormat:@"%@%@",URL_CALLINGRATES,selectCountry];
    }
    //NSLog(@"URL=*****===%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // NSLog(@"URL==%@",URL);
   // NSLog(@"parameters=callingRate=%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        
         //NSLog(@"=callingRateData=%@",json);
        allcallRateArr = [[NSMutableArray alloc]init];
        allcallRateArr = [json objectForKey:@"aaData"];
        NSLog(@"=allcallRateArr=%@",allcallRateArr);
       // NSMutableArray *getData=[[NSMutableArray alloc]init];
        [tblratelist reloadData];
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



-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex{
    
    if(dropMenu == dropcountry){
        
        //preph.text=countryPrefix[atIntedex];
        txtRate.text=countryArr[atIntedex];
        //country_Id=countryCodeArr[atIntedex];
        tag = @"0";
        
        NSLog(@"country==%@",txtRate.text);
    }
        else{
            tag = @"1";
            txtRate.text=@"";
        // NSLog(@"%@", dropMenu.items[atIntedex]);
    }
}

-(void)didShow:(KPDropMenu *)dropMenu{
    NSLog(@"didShow");
}

-(void)didHide:(KPDropMenu *)dropMenu{
    NSLog(@"didHide");
}
//button action
- (IBAction)btnActionGetRate:(id)sender {
    [self loadRate];
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
    //[self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
