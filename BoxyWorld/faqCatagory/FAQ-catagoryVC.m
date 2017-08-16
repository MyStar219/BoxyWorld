//
//  FAQ-catagoryVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 10/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//
#import "faq-catagoryCellCollectionViewCell.h"
#import "FAQ-catagoryVC.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "faqQstnVC.h"
@interface FAQ_catagoryVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
      AppDelegate *appDel;
    MBProgressHUD *hud;
    NSString *userId ;
    NSString *athenticationKey;
    NSMutableArray *faqCatagoryName,*faqCatagoryIcon;
    NSString *faqName,*FaqImg;
    NSMutableArray *allFaqCatagoryArr;
    NSString *faq_CatID;
    
}

@end
static NSString *identifier = @"faq-catagoryCellCollectionViewCell";
@implementation FAQ_catagoryVC
@synthesize faqCollectionView;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    allFaqCatagoryArr = [[NSMutableArray alloc]init];
    faqCatagoryName = [[NSMutableArray alloc]init];
    faqCatagoryIcon = [[NSMutableArray alloc]init];
    self.title = @"FAQ";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self barButtonFunction];
   // [self buttonShowHide];
   // [self makeLayout];
    appDel = [AppDelegate instance];
    [self loadFAQCatagory];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
    [faqCollectionView registerNib:[UINib nibWithNibName:@"faq-catagoryCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"faq-catagoryCellCollectionViewCell"];
    
    
    //[self loadingIndicator];
    //[self performSelectorOnMainThread:@selector(startLoadig) withObject:nil waitUntilDone:YES];
    //[self performSelectorOnMainThread:@selector(loadingUserAddedData) withObject:nil waitUntilDone:YES];
    
   // [self barButtonFunction];
   // [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"faqCatagoryName.count== %d",faqCatagoryName.count);
    return faqCatagoryName.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"identifier--%@",identifier);
    faq_catagoryCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    //Title
    faqName = [[faqCatagoryName objectAtIndex:indexPath.row]isKindOfClass:[NSNull class]]? @" " : [faqCatagoryName objectAtIndex:indexPath.row];
    //faqName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    cell.faqTitle.text=faqName;
    faqName = @"";
    
    //image
    NSString *imageName = [[faqCatagoryIcon objectAtIndex:indexPath.row] isKindOfClass:[NSNull class]]?@"":[faqCatagoryIcon objectAtIndex:indexPath.row];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageName]];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   UIImage  *image = [[UIImage alloc] initWithData:data];
                                   
                                   [cell.faqIcon setImage:image];
                                  // cell.faqIcon.layer.cornerRadius = cell.faqIcon.frame.size.width / 2;
                                   cell.faqIcon.clipsToBounds = YES;
                               }
                               else{
                                  // cell.faqIcon.layer.cornerRadius = cell.faqIcon.frame.size.width / 2;
                                   cell.faqIcon.clipsToBounds = YES;
                                   [cell.faqIcon setImage:[UIImage imageNamed:@"userIcon"]];
                               }
                               
                           }];
    

    /*NSString *imageName = [[faqCatagoryIcon objectAtIndex:indexPath.row] isKindOfClass:[NSNull class]]?@"":[faqCatagoryIcon objectAtIndex:indexPath.row];
   // NSLog(@"imageName%lu---%@",indexPath.row,imageName);
    if(![imageName isEqualToString:@""]){
        [faqIcon setImage:[UIImage imageNamed:imageName]];
    }
    else
    {
        [faqIcon setImage:[UIImage imageNamed:@"01_logo_screen-1.png"]];
    }*/

     return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SWRevealViewController *revealController = self.revealViewController;
    if(indexPath.item == 0){
      //  NSLog(@"allFaqCatagoryArr%@",allFaqCatagoryArr);
    faq_CatID = [[allFaqCatagoryArr objectAtIndex:indexPath.item]objectForKey:@"id"];
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        faqQstnVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"faqQstn"];
        vc1.faq_cat_Id=faq_CatID;
        // [revealController setFrontViewPosition:vc1 animated:YES];
        [self.navigationController pushViewController:vc1 animated:YES];
        /*UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
        [revealController pushFrontViewController:frontNavigationController animated:YES];
        */
       }
    }
// load FAQ Catagory
-(void)loadFAQCatagory
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
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETFAQQUESTIONS];
   // NSLog(@"URL====FAQ%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // NSLog(@"URL==FaQ%@",URL);
    //NSLog(@"parameters==FaQ%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
      // NSLog(@"FAQ===%@",json);
    NSString *status =[NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            
       
        allFaqCatagoryArr = [json objectForKey:@"data"];
        for (int i=0; i<[allFaqCatagoryArr count]; i++) {
            [faqCatagoryName addObject:[[allFaqCatagoryArr objectAtIndex:i]objectForKey:@"category_name"]];
            [faqCatagoryIcon addObject:[[allFaqCatagoryArr objectAtIndex:i]objectForKey:@"category_icon"]];
        }
            NSLog(@"faqCatagoryName== %@",faqCatagoryName);
            [faqCollectionView setDelegate:self];
            [faqCollectionView setDataSource:self];
            [faqCollectionView reloadData];
        }
        else{
       // NSLog(@"faqCatagoryName==%@",faqCatagoryName);
       // NSLog(@"faqCatagoryIcon==%@",faqCatagoryIcon);
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
    [appDel setBothMenus];
   // [self.navigationController popViewControllerAnimated:YES];
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
