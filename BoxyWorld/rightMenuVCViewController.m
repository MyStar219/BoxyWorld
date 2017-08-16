//
//  rightMenuVCViewController.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 15/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "rightMenuVCViewController.h"
#import "config.h"
#import "SWRevealViewController.h"
#import "UserAccessSession.h"
#import "changePwdVC.h"
#import "SWRevealViewController.h"
#import "editProfileVC.h"
@interface rightMenuVCViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation rightMenuVCViewController
@synthesize RightMenuView;
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    
    RightMenuView.editing = NO;
    
    self.revealViewController.rightViewRevealOverdraw = 0.0f;
    //menu item
    rightMenuListArray =[[NSMutableArray alloc]init];
    UserSession *rCellData = [UserAccessSession getUserSession];
    NSString *email = rCellData.reseller_email;
    NSMutableDictionary *menu0 = [[NSMutableDictionary alloc]init];
    [menu0 setObject:@"Verify Your Account" forKey:@"name"];
    [menu0 setObject:@"" forKey:@"photos"];
    [menu0 setObject:@"" forKey:@"subtitle"];
    
    NSMutableDictionary *menu1 = [[NSMutableDictionary alloc]init];
    [menu1 setObject:@"Business Name" forKey:@"name"];
    [menu1 setObject:@"business_name" forKey:@"photos"];
    [menu1 setObject:@"Web Devloper" forKey:@"subtitle"];
    
    NSMutableDictionary *menu2 = [[NSMutableDictionary alloc]init];
    [menu2 setObject:@"Phone" forKey:@"name"];
    [menu2 setObject:@"phone" forKey:@"photos"];
    [menu2 setObject:@"+15532158765" forKey:@"subtitle"];
    
    NSMutableDictionary *menu3 = [[NSMutableDictionary alloc]init];
    [menu3 setObject:@"Email" forKey:@"name"];
    [menu3 setObject:@"email" forKey:@"photos"];
    [menu3 setObject:[NSString stringWithFormat:@"%@",email] forKey:@"subtitle"];
    
    NSMutableDictionary *menu4 = [[NSMutableDictionary alloc]init];
    [menu4 setObject:@"Address" forKey:@"name"];
    [menu4 setObject:@"address" forKey:@"photos"];
    [menu4 setObject:@"Northstar Global comm,GA 30339" forKey:@"subtitle"];
    
    NSMutableDictionary *menu5 = [[NSMutableDictionary alloc]init];
    [menu5 setObject:@"Password" forKey:@"name"];
    [menu5 setObject:@"password" forKey:@"photos"];
    [menu5 setObject:@"**********" forKey:@"subtitle"];
    
    NSMutableDictionary *menu6 = [[NSMutableDictionary alloc]init];
    [menu6 setObject:@"Passcode" forKey:@"name"];
    [menu6 setObject:@"passcode" forKey:@"photos"];
    [menu6 setObject:@"123456" forKey:@"subtitle"];
    
    NSMutableDictionary *menu7 = [[NSMutableDictionary alloc]init];
    [menu7 setObject:@"Document" forKey:@"name"];
    [menu7 setObject:@"document" forKey:@"photos"];
    [menu7 setObject:@"Licence.jpg" forKey:@"subtitle"];
    NSMutableDictionary *menu8 = [[NSMutableDictionary alloc]init];
    [menu8 setObject:@"Demo" forKey:@"name"];
    [menu8 setObject:@"demo" forKey:@"photos"];
    [menu8 setObject:@"demo" forKey:@"subtitle"];
    
    [rightMenuListArray addObject:menu0];
    [rightMenuListArray addObject:menu1];
    [rightMenuListArray addObject:menu2];
    [rightMenuListArray addObject:menu3];
    [rightMenuListArray addObject:menu4];
    [rightMenuListArray addObject:menu5];
    [rightMenuListArray addObject:menu6];
    [rightMenuListArray addObject:menu7];
    
    [RightMenuView registerNib:[UINib nibWithNibName:@"rightMenuHeader" bundle:nil]forCellReuseIdentifier:@"rightMenuHeader"];
    [RightMenuView registerNib:[UINib nibWithNibName:@"rightMenuCellVerify" bundle:nil]forCellReuseIdentifier:@"rightMenuCellVerify"];
    [RightMenuView registerNib:[UINib nibWithNibName:@"rightMenuCell" bundle:nil]forCellReuseIdentifier:@"rightMenuCell"];
    [RightMenuView registerNib:[UINib nibWithNibName:@"rightmenuFooter" bundle:nil]forCellReuseIdentifier:@"rightmenuFooter"];
    RightMenuView.backgroundColor =  navigationBarColor;
    RightMenuView.opaque = NO;
    RightMenuView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trans_bg"]];
    // RightMenuView.backgroundView = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trans_bg"]]
    //RightMenuView = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trans_bg"]];
    RightMenuView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    [RightMenuView setDataSource:self];
    [RightMenuView setDelegate:self];
    [RightMenuView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    // Do any additional setup after loading the view from its nib.
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
    
    
    // Create the gradient
    /*CAGradientLayer *theViewGradient = [CAGradientLayer layer];
    theViewGradient.colors = [NSArray arrayWithObjects: (id)leftColor.CGColor, (id)middleColor.CGColor,(id)rightColor.CGColor, nil];
    theViewGradient.frame = self.view.bounds;*/
    
    if(indexPath.row == 0)
    {
        static NSString *cellIdentifier = @"rightMenuHeader";
        rightMenuHeader *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[rightMenuHeader alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
        }
        

        return cell.frame.size.height;
    }
   /*else if(indexPath.row == ((rightMenuListArray.count)+1)){
        static NSString *cellIdentifier = @"rightmenuFooter";
        
        rightmenuFooter *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[rightmenuFooter alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:cellIdentifier] ;
        }
        //cell.prflName.text = @"Chig'z Rathod";
        
        cell.backgroundColor = navigationBarColor;
        //return cell.frame.size.height;
       return cell.frame.size.height+10;
        
    }
*/
    
    else
    {
        if(indexPath.row == 1)
        {
            static NSString *cellIdentifier = @"rightMenuCellVerify";
            rightMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil)
            {
                cell = [[rightMenuCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
            }
            return cell.frame.size.height;
        }
        else
        {
            static NSString *cellIdentifier = @"rightMenuCell";
            rightMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil)
            {
                cell = [[rightMenuCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
            }
            return cell.frame.size.height;
        }
    }
   
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return rightMenuListArray.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"rightMenuListArray==%@",rightMenuListArray);
     NSLog(@"rightMenuListArray==%lu",(unsigned long)rightMenuListArray.count);
    if(indexPath.row == 0){
        
        static NSString *cellIdentifier = @"rightMenuHeader";
        
        rightMenuHeader *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[rightMenuHeader alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                      reuseIdentifier:cellIdentifier] ;
        }
        
        [cell.btnEditPrfl addTarget:self action:@selector(btnEditTap) forControlEvents:UIControlEventTouchUpInside];
        
        UserSession *rHeader = [UserAccessSession getUserSession];
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@",rHeader.profile_pic]];;
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse * response,
                                                   NSData * data,
                                                   NSError * error) {
                                   if (!error){
                                       UIImage  *image = [[UIImage alloc] initWithData:data];
                                       [cell.prflImge setImage:image];
                                       cell.prflImge.layer.cornerRadius = cell.prflImge.frame.size.width / 2;
                                       cell.prflImge.clipsToBounds = YES;
                                       
                                   }
                                   else{
                                       [cell.prflImge setImage:[UIImage imageNamed:@"userIcon"]];
                                       cell.prflImge.layer.cornerRadius = cell.prflImge.frame.size.width / 2;
                                       cell.prflImge.clipsToBounds = YES;

                                   }
                                   
                               }];
        
        cell.prflImge.layer.cornerRadius=cell.prflImge.frame.size.width/2;
        NSString *rHeader_res_Fname =rHeader.reseller_firstname;
        NSString *rHeader_res_Lname =rHeader.reseller_lastname;
        
        if(![rHeader_res_Fname isEqualToString:@""] ||![rHeader_res_Lname isEqualToString:@""]){
            [cell.prflName setText:[NSString stringWithFormat:@"%@ %@",rHeader_res_Fname,rHeader_res_Lname]];
        }
        else{
            [cell.prflName setText:@""];
        }

        //cell.prflName.text = @"Chig'z Rathod";
       [cell.prflName setFrame:CGRectMake(0,10,100,30)];
        cell.backgroundColor = [UIColor clearColor];
        
       
        //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trans_bg"]];
        return cell;
    }
   /*else if(indexPath.row == ((rightMenuListArray.count)+1)){
        static NSString *cellIdentifier = @"rightmenuFooter";
        
        rightmenuFooter *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[rightmenuFooter alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:cellIdentifier] ;
        }
       
    
        //cell.prflName.text = @"Chig'z Rathod";
       // sell.savePrflBtn
       //[cell.savePrflBtn setFrame:CGRectMake(0,0,70,150)];
       [cell.savePrflBtn addTarget:self action:@selector(saveProfile:) forControlEvents:UIControlEventTouchUpInside];
       [cell.savePrflBtn setTag:(int)indexPath.row];
        cell.savePrflBtn.layer.borderWidth = 0.6;
        cell.savePrflBtn.layer.borderColor =[UIColor whiteColor].CGColor;
       //cell.savePrflBtn.layer.backgroundColor =[UIColor whiteColor].CGColor;
       cell.savePrflBtn.backgroundColor = [UIColor clearColor];
       [cell.savePrflBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      cell.savePrflBtn.layer.cornerRadius = 3.0f;
       // cell.backgroundColor = navigationBarColor;
       //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trans_bg"]];
      cell.backgroundColor = [UIColor clearColor];
       cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth(tableView.bounds));
        return cell;
        
    }
*/
     else
    {
        
        
        
        
        
        
       // NSLog(@"myMenuListArray=%@",myMenuListArray);
        rightMenuCell *cell;
        // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addFundsId"];
        if(indexPath.row == 1)
        {
            static NSString *cellIdentifier = @"rightMenuCellVerify";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil)
            {
                cell = [[rightMenuCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                            reuseIdentifier:cellIdentifier] ;
            }
        }
        else
        {
            static NSString *cellIdentifier = @"rightMenuCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil)
            {
                cell = [[rightMenuCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellIdentifier] ;
            }
        }
       
        NSString *rMenuTital = [[[rightMenuListArray objectAtIndex:(indexPath.row)-1]objectForKey:@"name"] isKindOfClass:[NSNull class]]?@"":[[rightMenuListArray objectAtIndex:(indexPath.row)-1]objectForKey:@"name"];
        NSLog(@"name==%@",rMenuTital);
        
       
        if(indexPath.row == 1)
        {
            [cell.prflNamelbl setFont:[UIFont fontWithName:@"Helvetica" size:22.0]];
            
        }
        
         [cell.prflNamelbl setText:rMenuTital];
        cell.prflNamelbl.layer.masksToBounds=YES;
        [cell.prflNamelbl setTextAlignment:NSTextAlignmentLeft];
         cell.prflNamelbl.textColor = [UIColor whiteColor];
        //[cell.prflNamelbl setFrame:CGRectMake(0,0,300,30)];
        
        NSString *rMenusubTital = [[[rightMenuListArray objectAtIndex:(indexPath.row)-1]objectForKey:@"subtitle"] isKindOfClass:[NSNull class]]?@"":[[rightMenuListArray objectAtIndex:(indexPath.row)-1]objectForKey:@"subtitle"];
         NSLog(@"subtitle==%@",rMenusubTital);
         [cell.prflSubnamelbl setText:rMenusubTital];
         cell.prflSubnamelbl.layer.masksToBounds=YES;
         [cell.prflSubnamelbl setTextAlignment:NSTextAlignmentLeft];
         cell.prflSubnamelbl.textColor = [UIColor whiteColor];
       // [cell.prflSubnamelbl setFrame:CGRectMake(0,10,100,30)];
        
        
        NSString *menuIcon = [[[rightMenuListArray objectAtIndex:(indexPath.row)-1]objectForKey:@"photos"] isKindOfClass:[NSNull class]]?@"":[[rightMenuListArray objectAtIndex:(indexPath.row)-1]objectForKey:@"photos"];
        //NSLog(@"imageName%d---%@",indexrow+1,imageName2);
        if(![menuIcon isEqualToString:@""]){
            NSLog(@"menuIcon==%@",menuIcon);
            [cell.profileIconImg setImage:[UIImage imageNamed:menuIcon]];
        }
        else
        {
            NSLog(@"menuIcon==01_logo_screen-1");
            [cell.profileIconImg setImage:[UIImage imageNamed:@"01_logo_screen-1.png"]];
        }
        
        
        /*NSString *editIcon = [[[rightMenuListArray objectAtIndex:(indexPath.row)-1]objectForKey:@"photos"] isKindOfClass:[NSNull class]]?@"":[[rightMenuListArray objectAtIndex:(indexPath.row)-1]objectForKey:@"photos"];
        //NSLog(@"imageName%d---%@",indexrow+1,imageName2);
        if(![editIcon isEqualToString:@""]){
            
            [cell.editIconImg setImage:[UIImage imageNamed:editIcon]];
        }
        else
        {
            
            [cell.editIconImg setImage:[UIImage imageNamed:@"edit"]];
        }*/

       // cell.contentView.userInteractionEnabled = NO;
       // [cell.editIconImg setHidden:NO];
        //[cell.editIconImg setImage:[UIImage imageNamed:@"edit"]];
        cell.prflNamelbl.textColor = [UIColor whiteColor];
        cell.prflSubnamelbl.textColor = [UIColor whiteColor];
        //cell.backgroundColor = navigationBarColor;
        //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trans_bg"]];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectedBackgroundView.backgroundColor=[UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }
    
    
    return nil;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"row selected");
    if(indexPath.row == 6)
    {
        
          SWRevealViewController *revealController = self.revealViewController;
        /* NSLog(@"BoxyWorld change password");
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        changePwdVC * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"SBchangepwd"];
        //vc2.fromPage = @"sendMoney";
        [self.navigationController pushViewController:vc2 animated:YES];*/
        
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        changePwdVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"SBchangepwd"];
        // [revealController setFrontViewPosition:vc1 animated:YES];
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
        [revealController pushFrontViewController:frontNavigationController animated:YES];
        

    }
}
-(void)saveProfile:(UIButton *)sender{
    NSLog(@"saveProfile");
}
-(void)btnEditTap{
    NSLog(@"btnEditTap");
    /*NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    editProfileVC * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"SBeditProfile"];
    //vc2.fromPage = @"sendMoney";
    [self.navigationController pushViewController:vc2 animated:YES];
    */
    
    SWRevealViewController *revealController = self.revealViewController;
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    editProfileVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"SBeditProfile"];
    // [revealController setFrontViewPosition:vc1 animated:YES];
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
    [revealController pushFrontViewController:frontNavigationController animated:YES];
    
    
   /* NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    editProfileVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"SBeditProfile"];
     //[revealController setFrontViewPosition:vc1 animated:YES];
    
   UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
    [revealController pushFrontViewController:frontNavigationController animated:YES];
    */
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
