//
//  accessNumbersVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 13/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "accessNumbersVC.h"
#import "accessNoCell.h"
#import "config.h"
#import "SWRevealViewController.h"
#import "addCustomerVC.h"
#import "AppDelegate.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "CitiDetailsVC.h"

@interface accessNumbersVC ()<UITableViewDelegate,UITableViewDataSource>
{
     AppDelegate *appDel;
    MBProgressHUD *hud;
    NSString *userId ;
    NSString *athenticationKey;
    NSMutableArray  *allcountryCode,*countryFlags,*allcountryArr;
    
}
@end

@implementation accessNumbersVC
@synthesize tblAllCitis;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    allcountryCode = [[NSMutableArray alloc]init];
    countryFlags = [[NSMutableArray alloc]init];
    allcountryArr= [[NSMutableArray alloc]init];
    appDel = [AppDelegate instance];
    self.title = @"Access Numbers";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self barButtonFunction];
    // Do any additional setup after loading the view.
    [tblAllCitis registerNib:[UINib nibWithNibName:@"accessNoCell" bundle:nil]forCellReuseIdentifier:@"accessNoCell"];
    [self loadAllcities];
    [tblAllCitis setDataSource:self];
    [tblAllCitis setDelegate:self];
    tblAllCitis.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return allcountryCode.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"accessNoCell";
    accessNoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[accessNoCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    return cell.frame.size.height;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIdentifier = @"accessNoCell";
    accessNoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[accessNoCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    //@synthesize imgFlag,lblTitle,fldSelect;
   /* NSString *image =[countryFlags objectAtIndex:indexPath.row];
    NSLog(@"image---%@",image);
    NSString *url =[NSString stringWithFormat:@"%@",image];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   UIImage  *image = [[UIImage alloc] initWithData:data];
                                   
                                   [cell.imgFlag setImage:image];
                                  // cell.imgFlag.layer.cornerRadius = cell.profileImage.frame.size.width / 2;
                                   //cell.imgFlag.clipsToBounds = YES;
                               }
                               else{
                                   //cell.imgFlag.layer.cornerRadius = cell.profileImage.frame.size.width / 2;
                                  // cell.imgFlag.clipsToBounds = YES;
                                   [cell.imgFlag setImage:[UIImage imageNamed:@"userIcon"]];
                               }
                               
                           }];*/
    
    
    //image
    NSString *imageName = [[countryFlags objectAtIndex:indexPath.row] isKindOfClass:[NSNull class]]?@"":[countryFlags objectAtIndex:indexPath.row];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageName]];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   UIImage  *image = [[UIImage alloc] initWithData:data];
                                   
                                   [cell.imgFlag setImage:image];
                                   // cell.faqIcon.layer.cornerRadius = cell.faqIcon.frame.size.width / 2;
                                   cell.imgFlag.clipsToBounds = YES;
                               }
                               else{
                                   // cell.faqIcon.layer.cornerRadius = cell.faqIcon.frame.size.width / 2;
                                   cell.imgFlag.clipsToBounds = YES;
                                   [cell.imgFlag setImage:[UIImage imageNamed:@"userIcon"]];
                               }
                               
                           }];
    
    NSString *code = [allcountryCode objectAtIndex:indexPath.row];
    NSString *uppercase = [code uppercaseString];
    code =  uppercase;
     [cell.lblTitle setText:[NSString stringWithFormat:@"show all %@ cities ",code]];
      [cell.lblTitle setTextColor:[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0]];
    
   /* NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[rates dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    cell.txtRates.attributedText = attrStr;
    
    [cell.txttitle setText:title];
    [cell.txtPhno setText:phon];
    // [cell.txtRates setText:rates];
    [cell.txtmis setText:mis];
    // }*/
    cell.btnSelect.layer.cornerRadius = cell.btnSelect.frame.size.width / 2;
    [cell.btnSelect.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.btnSelect.layer setBorderWidth:1.5f];
    cell.btnSelect.tag=(int)indexPath.row;
     [cell.btnSelect addTarget:self action:@selector(didClickSelect:) forControlEvents:UIControlEventTouchUpInside];
    //[cell.prflSubnamelbl setFrame:CGRectMake(0,10,100,30)];
    [cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.contentView.layer setBorderWidth:0.5f];
    cell.selectionStyle =  UITableViewCellSelectionStyleGray;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"accessNoCell";
    accessNoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil)
     {
     cell = [[accessNoCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
     }
    
    [cell.btnSelect setBackgroundColor:[UIColor redColor]];
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    CitiDetailsVC * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"citiDetails"];
    vc2.CountryCode=[allcountryCode objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:vc2 animated:YES];
    
    
    
}
//load all cities
-(void)loadAllcities
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
        //NSLog(@"all cities===%@",json);
       NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
          NSMutableArray *data = [[NSMutableArray alloc]init];
            data=[json objectForKey:@"data"];
            for (int i=0; i<data.count; i++) {
                allcountryArr[i] = [data objectAtIndex:i];
            }
            for(int j=0;j<allcountryArr.count;j++){
             //NSLog(@"allcountryArr==%@",allcountryArr);
            allcountryCode = [allcountryArr valueForKey:@"code"];
            countryFlags = [allcountryArr valueForKey:@"flag"];
           
            }
           // NSLog(@"allcountryCode===%@",allcountryCode);
            // NSLog(@"countryFlags===%@",countryFlags);
            [tblAllCitis reloadData];
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
    [appDel setBothMenus];
    //[self.navigationController popViewControllerAnimated:YES];
}
-(void)didClickSelect:(UIButton *)sender{
    int tag= (int)sender.tag;
    [tblAllCitis reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tag inSection:0];
    [self tableView:tblAllCitis didSelectRowAtIndexPath:indexPath];
    
   /*
   // [self.btnSelect.BackgroundColor:[UIColor redColor]];
   //[btnSelect setBackgroundColor:[UIColor blueColor]];
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    CitiDetailsVC * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"citiDetails"];
    vc2.CountryCode=[allcountryCode objectAtIndex:tag];
    
    [self.navigationController pushViewController:vc2 animated:YES];
    */

   
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
