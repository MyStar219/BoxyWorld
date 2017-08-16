//
//  historyPageVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 28/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "historyPageVC.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"


@interface historyPageVC ()<UITextFieldDelegate>
{
    MBProgressHUD *hud;
    NSString *userId,*athenticationKey;
}
@end

@implementation historyPageVC
@synthesize scrVwHistory,searchBar,table1st,table2nd,table3rd,searchText;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeLayout];
    // Do any additional setup after loading the view.
}
-(void)makeLayout{
    
    //self.title = @"History";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    table1st.layer.borderWidth = 2.0;
    table1st.layer.borderColor = [[UIColor grayColor]CGColor];
    
    table2nd.layer.borderWidth = 2.0;
    table2nd.layer.borderColor = [[UIColor grayColor]CGColor];
    
    table3rd.layer.borderWidth = 2.0;
    table3rd.layer.borderColor = [[UIColor grayColor]CGColor];
    
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
