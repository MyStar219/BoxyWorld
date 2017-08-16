//
//  allTransactionVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 23/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "allTransactionVC.h"
#import "allTransactionCell.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "config.h"
#import "AFNetworking.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "UserAccessSession.h"
@interface allTransactionVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate>
{
    AppDelegate *appDel;
     MBProgressHUD *hud;
    NSString *athenticationKey,*userId;
    int start,end;
    UIDatePicker *picker1,*picker2;
    NSString *date,*type,*name,*phno,*card,*beforeBal,*after_bal,*total,*slectedTab;
    NSString *tabName,*cardNo,*cardtype,*addThrough,*amount,*status,*deductAmount,*earningAmount,*action,*country,*discount;
    NSMutableArray *ListDataArray;
     NSArray *arrayForAll,*arraForFund,*arrayForPinless,*arrayForIMTU;
    NSArray *dummyArray;
    UIButton *btnRefund;
    

}
@end

@implementation allTransactionVC
@synthesize selfTitle,navBarTitle;
-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:YES];
    
    //[self barButtonFunction];
    [alltranListArray removeAllObjects];
    
    [self allTransaction];
   
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"selfTitle==%@",selfTitle);
    start=0;
    end=3;
    ListDataArray =[[NSMutableArray alloc]init];
    UserSession *allTrans = [UserAccessSession getUserSession];
    userId =allTrans.reseller_id;
    athenticationKey =allTrans.res_user_login_key;
    slectedTab = selfTitle;//[[NSUserDefaults standardUserDefaults] objectForKey:@"tabSelected"];// allTrans.setectedTabHis;
    NSLog(@"tabSelectedSujit===%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"tabSelected2"]);
    //[UserAccessSession clearAllSession];
    // Do any additional setup after loading the view.
    appDel = [AppDelegate instance];
    [self makeArray];
   [self makeLayout];
    //Date,Type,Name,Phone,
    //data array
    alltranListArray = [[NSMutableArray alloc]init];
    
    [self.tblallTrns registerNib:[UINib nibWithNibName:@"allTransactionCell" bundle:nil]forCellReuseIdentifier:@"allTransactionCell"];
    if ([slectedTab isEqualToString:@"fund"])
    {
        navBarTitle.text =@"FUND-HISTORY";
    }
    else if ([slectedTab isEqualToString:@"pinless"])
    {
        navBarTitle.text =@"PINLESS-HISTORY";
    }
    else if ([slectedTab isEqualToString:@"imtu"])
    {
        navBarTitle.text =@"IMTU-HISTORY";
    }
    else{
        navBarTitle.text =@"ALL TRANSACTION-HISTORY";
    }
    
   
   
    
}



-(void)makeLayout{
    
    //self.title = @"All Transaction";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.txtFrom.layer.borderWidth = 1.3;
    self.txtFrom.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtFrom.layer.cornerRadius = 5.0f;
    self.txtFrom.delegate =self;
    self.txtFrom.text =@"2017-01-01";
    //self.txtFrom.inputView=self.datePiker;
    
    
    NSLog(@"dsgsgds==%f",_tblallTrns.frame.origin.y);
    picker1   = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, _tblallTrns.frame.origin.y+60, [UIScreen mainScreen].bounds.size.width, 216)];
    [picker1 setDatePickerMode:UIDatePickerModeDate];
    picker1.backgroundColor = [UIColor whiteColor];
    [picker1 addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
  // self.txtFrom.rightViewMode =
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Done" forState:UIControlStateNormal];
    //button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    [button addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    self.txtFrom.rightView = button;
    self.txtFrom.rightViewMode = UITextFieldViewModeAlways;

    
   // self.txtFrom.inputView=self.datePiker;
    
   // UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    //[self.txtFrom setLeftViewMode:UITextFieldViewModeAlways];
    //[self.txtFrom setLeftView:spacerView];

    
    self.txtTo.layer.borderWidth = 1.3;
    self.txtTo.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtTo.layer.cornerRadius = 5.0f;
    self.txtTo.delegate =self;
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:today];
    self.txtTo.text =dateString;
    picker2   = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, _tblallTrns.frame.origin.y+60, [UIScreen mainScreen].bounds.size.width, 216)];
    [picker2 setDatePickerMode:UIDatePickerModeDate];
    picker2.backgroundColor = [UIColor whiteColor];
    [picker2 addTarget:self action:@selector(onDatePickerValueChangedto:) forControlEvents:UIControlEventValueChanged];
    
    /*
    UIDatePicker *
     */
    //self.txtTo.inputView=self.datePiker;
   /* UIDatePicker *picker2   = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 210, 320, 216)];
    [picker2 setDatePickerMode:UIDatePickerModeDate];
    picker2.backgroundColor = [UIColor whiteColor];
    [picker2 addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];*/
    //[self.txtTo setLeftViewMode:UITextFieldViewModeAlways];
   // [self.txtTo setLeftView:spacerView];
    
    
        
    self.btnSearch.layer.borderWidth = 1.0;
    self.btnSearch.layer.borderColor = [UIColor greenColor].CGColor;
    self.btnSearch.layer.cornerRadius = 6.0f;
    
    self.btnReset.layer.borderWidth = 1.0;
    self.btnReset.layer.borderColor = [UIColor redColor].CGColor;
    self.btnReset.layer.cornerRadius = 6.0f;
    
    self.btnDnldCSV.layer.borderWidth = 1.0;
    self.btnDnldCSV.layer.borderColor = [UIColor blueColor].CGColor;
    self.btnDnldCSV.layer.cornerRadius = 6.0f;
    
    
    self.btnLoadeMore.layer.borderWidth = 1.0;
    self.btnLoadeMore.layer.borderColor = [UIColor redColor].CGColor;
    self.btnLoadeMore.layer.cornerRadius = 6.0f;
    [self.datePiker setHidden:YES];
    //[self  textFieldWillBeginEditing];
    
    
    
    }
- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //dateFormatter.locale = [NSLocale currentLocale];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [dateFormatter stringFromDate:datePicker.date];
    
    NSLog(@"date =%@",stringFromDate);
    self.txtFrom.text = stringFromDate;
}
- (void)onDatePickerValueChangedto:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //dateFormatter.locale = [NSLocale currentLocale];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [dateFormatter stringFromDate:datePicker.date];
    
    NSLog(@"date =%@",stringFromDate);
    self.txtTo.text = stringFromDate;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return alltranListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"allTransactionCell";
    allTransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[allTransactionCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    return cell.frame.size.height;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return dummyArray.count; //8;//alltranListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"allTransactionCell";
    allTransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[allTransactionCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    for(int i=0;i<dummyArray.count;i++){
        [cell.lblKey setText:[dummyArray objectAtIndex:i]];
        
    }
    if ([slectedTab isEqualToString:@"fund"])
    {
        //@"Date",@"Card",@"Card Type",@"Added Through",@"Amount",@"Before Balance",@"After Balance",@"status"
        if(indexPath.row ==0){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Date"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Date"];
            [cell.lblKey setText:@"Date"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 1){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Card"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Card"];
            [cell.lblKey setText:@"Card"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 2){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Type"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Type"];
            [cell.lblKey setText:@"Card Type"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 3){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Added Through"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Added Through"];
            [cell.lblKey setText:@"Added Through"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 4){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Amount"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Amount"];
            [cell.lblKey setText:@"Amount"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
        else if(indexPath.row == 5){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Before Balance"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Before Balance"];
            [cell.lblKey setText:@"Before Balance"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
        else if(indexPath.row == 6){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"After Balance"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"After Balance"];
            [cell.lblKey setText:@"After Balance"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
        else if(indexPath.row == 7){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Status"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"status"];
            [cell.lblKey setText:@"status"];
            [cell.lblVal setText:value];
        }
        else{
            NSLog(@"hello");
        }

       
    }
    else if ([slectedTab isEqualToString:@"pinless"])
    {
        //@"Date",@"Name",@"Phone",@"Rechearge Amount",@"Deduct Amount",@"Earning Amount",@"Before Balance",@"After Balance",@"Action"
        
        btnRefund = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnRefund.frame = CGRectMake(30.0f, 10.0f, 100.0f, 20);
        btnRefund.layer.borderWidth=1.0f;
        btnRefund.layer.cornerRadius=5.0f;
        btnRefund.layer.borderColor=[UIColor greenColor].CGColor;

        
        if(indexPath.row ==0){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Date"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Date"];
            [cell.lblKey setText:@"Date"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 1){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Name"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Name"];
            [cell.lblKey setText:@"Name"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 2){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Phone"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Phone"];
            [cell.lblKey setText:@"Phone"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 3){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Recharge Amount"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Recharge Amount"];
            [cell.lblKey setText:@"Rechearge Amount"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
        else if(indexPath.row == 4){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Deduct Amount"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Deduct Amount"];
            [cell.lblKey setText:@"Deduct Amount"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 5){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Earning Amount"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Earning Amount"];
            [cell.lblKey setText:@"Earning Amount"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }

        
        else if(indexPath.row == 6){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Before Balance"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Before Balance"];
            [cell.lblKey setText:@"Before Balance"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
        else if(indexPath.row == 7){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"After Balance"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"After Balance"];
            [cell.lblKey setText:@"After Balance"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
        else if(indexPath.row == 8){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Action"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Action"];
            [cell.lblKey setText:@"Action"];
            //[cell.lblVal setText:value];
            
            
           /*
            UIButton *btnRefunded = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btnRefunded.frame = CGRectMake(30.0f, 10.0f, 100.0f, 20);
            btnRefunded.layer.borderWidth=1.0f;
            btnRefunded.layer.cornerRadius=5.0f;
            btnRefunded.layer.borderColor=[UIColor blueColor].CGColor;
            //scanQRCodeButton.backgroundColor = [UIColor Color];
            [btnRefunded setTitle:@"REFUNDED" forState:UIControlStateNormal];
            */
            if([value isEqualToString:@"1"]){
                [btnRefund setTitle:@"Refund" forState:UIControlStateNormal];
                 [cell.lblVal addSubview:btnRefund];
               // btnRefunded.hidden=YES;
            
            }
            else{
                [btnRefund setTitle:@"Refunded" forState:UIControlStateNormal];
                [cell.lblVal addSubview:btnRefund];
                btnRefund.hidden = YES;
            }
            
        }
        else{
            NSLog(@"hello");
        }

        
    }
    else if ([slectedTab isEqualToString:@"imtu"])
    {//@"Date",@"Phone",@"Country",@"Rechearge Amount",@"Deduct Amount",@"Earning Amount",@"Discount",@"Before Balance",@"After Balance"
        //for imtu
        if(indexPath.row ==0){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Date"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Date"];
            [cell.lblKey setText:@"Date"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 1){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Phone"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Phone"];
            [cell.lblKey setText:@"Phone"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 2){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Country"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Country"];
            [cell.lblKey setText:@"Country"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 3){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Recharge Amount"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Recharge Amount"];
            [cell.lblKey setText:@"Rechearge Amount"];
            NSLog(@"Rechearge Amount*****%@",value);
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
        else if(indexPath.row == 4){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Deduct Amount"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Deduct Amount"];
            [cell.lblKey setText:@"Deduct Amount"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
        else if(indexPath.row == 5){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Earning Amount"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Earning Amount"];
            [cell.lblKey setText:@"Earning Amount"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
        
        else if(indexPath.row == 6){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Discount"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Discount"];
            [cell.lblKey setText:@"Discount"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }

        
        else if(indexPath.row == 7){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Before Balance"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Before Balance"];
            [cell.lblKey setText:@"Before Balance"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
        else if(indexPath.row == 8){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"After Balance"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"After Balance"];
            [cell.lblKey setText:@"After Balance"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
      
        else{
            NSLog(@"hello");
        }

        
    }
    else{
        //for all
        //@"Date",@"Type",@"Name",@"Phone",@"Card",@"Before Balance",@"After Balance",@"Total",
        
        if(indexPath.row ==0){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Date"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Date"];
            [cell.lblKey setText:@"Date"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 1){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Type"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Type"];
            [cell.lblKey setText:@"Type"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 2){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Name"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Name"];
            [cell.lblKey setText:@"Name"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 3){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Phone"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Phone"];
            [cell.lblKey setText:@"Phone"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 4){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Card"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Card"];
            [cell.lblKey setText:@"Card"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 5){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Before Balance"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Before Balance"];
            [cell.lblKey setText:@"Before Balance"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
        else if(indexPath.row == 6){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"After Balance"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"After Balance"];
            [cell.lblKey setText:@"After Balance"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
        else if(indexPath.row == 7){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Total"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Total"];
            [cell.lblKey setText:@"Total"];
            [cell.lblVal setText:[NSString stringWithFormat:@"$%@",value]];
        }
        else{
            NSLog(@"hello");
        }

        
    }

   /* NSString *key = [[[alltranListArray objectAtIndex:(indexPath.row)]objectForKey:@"key"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.row)]objectForKey:@"key"];*/
    
    

   
    [ cell.lblVal setTextColor:[UIColor grayColor]];
    
    return cell;
}

 -(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3.0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 3.0;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero] ;
}

-(void)allTransaction
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    
    NSLog(@"slectedTab=%@",slectedTab);
    NSLog(@"athenticationKey=%@",athenticationKey);
     NSLog(@"start=%d",start);
    NSLog(@"end=%d",end);
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                [NSString stringWithFormat:@"%d",start],@"page",
                 [NSString stringWithFormat:@"%d",end],@"record_per_page",
                   @"type",@"search_column",
                 slectedTab,@"search_text",
                  self.txtFrom.text,@"from_date",
                   self.txtTo.text,@"to_date",
                   @"",@"sort_by",
                   @"",@"sort_order",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_ALLTRANSACTIONHISTORY];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==%@",URL);
     NSLog(@"parametersAll Trans==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"jsonALL TRANS==%@",json);
        
        NSString *status =[NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            
        NSMutableArray *allDataArr = [[NSMutableArray alloc]init];
        allDataArr = [[json objectForKey:@"data"]objectForKey:@"records"];
        NSLog(@"allDataArr==%@",allDataArr);
        
        
        if ([slectedTab isEqualToString:@"fund"])
        {
            
           
            for (int i=0; i<[allDataArr count]; i++) {
                NSMutableDictionary *data1 = [[NSMutableDictionary alloc]init];
                
                date=[[allDataArr objectAtIndex:i]objectForKey:@"date"];
                cardNo = [[allDataArr objectAtIndex:i]objectForKey:@"cc_number"];
                cardtype = [[allDataArr objectAtIndex:i]objectForKey:@"cc_type"];
                addThrough = [[allDataArr objectAtIndex:i]objectForKey:@"fullname"];
                amount = [[allDataArr objectAtIndex:i]objectForKey:@"amount"];
                beforeBal = [[allDataArr objectAtIndex:i]objectForKey:@"res_before_balance"];
                after_bal = [[allDataArr objectAtIndex:i]objectForKey:@"res_after_balance"];
                status = [[allDataArr objectAtIndex:i]objectForKey:@"api_status"];
                
                [data1 setObject:date forKey:@"Date"];
                [data1 setObject:cardNo forKey:@"Card"];
                [data1 setObject:cardtype forKey:@"Type"];
                [data1 setObject:addThrough forKey:@"Added Through"];
                [data1 setObject:amount forKey:@"Amount"];
                [data1 setObject:beforeBal forKey:@"Before Balance"];
                [data1 setObject:after_bal forKey:@"After Balance"];
                [data1 setObject:status forKey:@"status"];
                
                //NSLog(@"data1===%@",data1);
                
                [alltranListArray addObject:data1];
            }

        }
        else if ([slectedTab isEqualToString:@"pinless"])
        {
            for (int i=0; i<[allDataArr count]; i++) {
                NSMutableDictionary *data1 = [[NSMutableDictionary alloc]init];
                
                date=[[allDataArr objectAtIndex:i]objectForKey:@"date"];
                name = [[allDataArr objectAtIndex:i]objectForKey:@"fullname"];
                phno = [[allDataArr objectAtIndex:i]objectForKey:@"phone"];
                amount = [[allDataArr objectAtIndex:i]objectForKey:@"amount"];
                deductAmount = [[allDataArr objectAtIndex:i]objectForKey:@"deduct_amount"];
                earningAmount = [[allDataArr objectAtIndex:i]objectForKey:@"earning_amount"];
                
                beforeBal = [[allDataArr objectAtIndex:i]objectForKey:@"res_before_balance"];
                after_bal = [[allDataArr objectAtIndex:i]objectForKey:@"res_after_balance"];
                total = [[allDataArr objectAtIndex:i]objectForKey:@"is_refund"];
                [data1 setObject:date forKey:@"Date"];
                [data1 setObject:name forKey:@"Name"];
                [data1 setObject:phno forKey:@"Phone"];
                [data1 setObject:amount forKey:@"Recharge Amount"];
                [data1 setObject:deductAmount forKey:@"Deduct Amount"];
                [data1 setObject:earningAmount forKey:@"Earning Amount"];
                [data1 setObject:beforeBal forKey:@"Before Balance"];
                [data1 setObject:after_bal forKey:@"After Balance"];
                [data1 setObject:total forKey:@"Action"];
                
                //NSLog(@"data1===%@",data1);
                
                [alltranListArray addObject:data1];
            }

        }
        else if ([slectedTab isEqualToString:@"imtu"])
        {
            amount=@"";
            for (int i=0; i<[allDataArr count]; i++) {
                NSMutableDictionary *data1 = [[NSMutableDictionary alloc]init];
                
                date=[[allDataArr objectAtIndex:i]objectForKey:@"date"];
                phno = [[allDataArr objectAtIndex:i]objectForKey:@"phone"];
                country = [[allDataArr objectAtIndex:i]objectForKey:@"fund_bank"];
                amount = [[allDataArr objectAtIndex:i]objectForKey:@"amount"];
                
                deductAmount = [[allDataArr objectAtIndex:i]objectForKey:@"deduct_amount"];
                earningAmount = [[allDataArr objectAtIndex:i]objectForKey:@"earning_amount"];
                discount = [[allDataArr objectAtIndex:i]objectForKey:@"discount"];
                beforeBal = [[allDataArr objectAtIndex:i]objectForKey:@"res_before_balance"];
                after_bal = [[allDataArr objectAtIndex:i]objectForKey:@"res_after_balance"];
               
                [data1 setObject:date forKey:@"Date"];
                [data1 setObject:phno forKey:@"Phone"];
                [data1 setObject:country forKey:@"Country"];
                [data1 setObject:amount forKey:@"Recharge Amount"];
                [data1 setObject:deductAmount forKey:@"Deduct Amount"];
                [data1 setObject:earningAmount forKey:@"Earning Amount"];
                 [data1 setObject:discount forKey:@"Discount"];
                [data1 setObject:beforeBal forKey:@"Before Balance"];
                [data1 setObject:after_bal forKey:@"After Balance"];
                
                
                //NSLog(@"data1===%@",data1);
                
                [alltranListArray addObject:data1];
            }

        }
        else{
            for (int i=0; i<[allDataArr count]; i++) {
                NSMutableDictionary *data1 = [[NSMutableDictionary alloc]init];
                
                date=[[allDataArr objectAtIndex:i]objectForKey:@"date"];
                type = [[allDataArr objectAtIndex:i]objectForKey:@"tbl_type"];
                name = [[allDataArr objectAtIndex:i]objectForKey:@"fullname"];
                phno = [[allDataArr objectAtIndex:i]objectForKey:@"phone"];
                card = [[allDataArr objectAtIndex:i]objectForKey:@"fund_bank"];
                beforeBal = [[allDataArr objectAtIndex:i]objectForKey:@"res_before_balance"];
                after_bal = [[allDataArr objectAtIndex:i]objectForKey:@"res_after_balance"];
                total = [[allDataArr objectAtIndex:i]objectForKey:@"amount"];
                [data1 setObject:date forKey:@"Date"];
                [data1 setObject:type forKey:@"Type"];
                [data1 setObject:name forKey:@"Name"];
                [data1 setObject:phno forKey:@"Phone"];
                [data1 setObject:card forKey:@"Card"];
                [data1 setObject:beforeBal forKey:@"Before Balance"];
                [data1 setObject:after_bal forKey:@"After Balance"];
                [data1 setObject:total forKey:@"Total"];
                
                //NSLog(@"data1===%@",data1);
                
                [alltranListArray addObject:data1];
            }

        }

        
        
        [self.tblallTrns setDataSource:self];
        [self.tblallTrns setDelegate:self];
        [self.tblallTrns reloadData];
        NSLog(@"alltranListArray==%@",alltranListArray);
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
        }
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}
//make array
-(void)makeArray{
   // NSMutableArray *arrayForAll,*arraForFund,*arrayForPinless,*arrayForIMTU;
    arrayForAll =[[NSArray alloc]init];
    arraForFund =[[NSArray alloc]init];
    arrayForPinless =[[NSArray alloc]init];
    arrayForIMTU =[[NSArray alloc]init];

    
    
    arrayForAll = [NSArray arrayWithObjects:@"Date",@"Type",@"Name",@"Phone",@"Card",@"Before Balance",@"After Balance",@"Total",
     nil];
    
    arraForFund =[NSArray arrayWithObjects:@"Date",@"Card",@"Card Type",@"Added Through",@"Amount",@"Before Balance",@"After Balance",@"status",nil];
    
     arrayForPinless =[NSArray arrayWithObjects:@"Date",@"Name",@"Phone",@"Rechearge Amount",@"Deduct Amount",@"Earning Amount",@"Before Balance",@"After Balance",@"Action",nil];
    
    arrayForIMTU =[NSArray arrayWithObjects:@"Date",@"Phone",@"Country",@"Rechearge Amount",@"Deduct Amount",@"Earning Amount",@"Discount",@"Before Balance",@"After Balance",nil];
    
    if ([slectedTab isEqualToString:@"fund"])
    {
        dummyArray = arraForFund;
    }
    else if ([slectedTab isEqualToString:@"pinless"])
    {
        dummyArray = arrayForPinless;
    }
    else if ([slectedTab isEqualToString:@"imtu"])
    {
        dummyArray = arrayForIMTU;
    }
    else{
        dummyArray = arrayForAll;
    }

}
//*************************
//for navigation bar
-(void) barButtonFunction
{
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"]
                                                                         style:UIBarButtonItemStylePlain target:self action:@selector(popView:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    //UILabel *lblHead =[UILabel alloc];
    //lblHead.text =@"All Transaction";
   /* UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon"]
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
    self.navigationController.navigationItem.titleView = logoView;
    
    UIImage* logoImage = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
    */
    //self.navigationController.navigationItem.titleView = lblHead;
    [self.navigationController.navigationBar setBarTintColor:navigationBarColor];
    
}

//*************************
// for nevigation bar
/*-(void) barButtonFunction
{
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"]
                                                                         style:UIBarButtonItemStylePlain target:self action:@selector(popView:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    [self.navigationController.navigationBar setBarTintColor:navigationBarColor];
    
}
 */
-(void)popView:(UIBarButtonItem *)sender
{
   // [appDel setBothMenus];
     [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldShouldBeginEditing");
    if(textField == self.txtFrom)
    {
        [picker2 removeFromSuperview];
        [self.txtFrom resignFirstResponder];
        [self.view addSubview:picker1];
    }
    
    if(textField == self.txtTo)
    {
      [picker1 removeFromSuperview];
      [self.txtTo resignFirstResponder];
      [self.view addSubview:picker2];
    }
    return false;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn");
    if (textField == self.txtFrom)
    {
       
        //[self.txtFrom resignFirstResponder];
        [self.txtTo becomeFirstResponder];
        [picker1 removeFromSuperview];
    }
    else if (textField == self.txtTo){
        
//[self.txtTo resignFirstResponder];
        [picker2 removeFromSuperview];
    }
    
    [textField resignFirstResponder];
    
    
    return YES;
}
- (IBAction)btnActionLoadMore:(id)sender {
    
    start =start+1;
    [self allTransaction];
}
- (IBAction)searchButtonTapped:(id)sender {
    [picker1 removeFromSuperview];
    [picker2 removeFromSuperview];
    [alltranListArray removeAllObjects];
    start =1;
    [self allTransaction];

}
- (IBAction)resetButtonTapped:(id)sender {
    self.txtFrom.text = @"";
      self.txtTo.text = @"";
    
}
- (IBAction)downloadCVbuttonTapped:(id)sender {
    if ([slectedTab isEqualToString:@"fund"])
    {
        hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text =@"Please Wait";
        
        [self.view addSubview:hud];
        [self.view setUserInteractionEnabled:NO];
        
        
        NSLog(@"slectedTab=%@",slectedTab);
        NSLog(@"athenticationKey=%@",athenticationKey);
        NSLog(@"start=%d",start);
        NSLog(@"end=%d",end);
        NSDictionary *parameters;
        __block NSDictionary* json;
        parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                      userId,@"user_id",
                      athenticationKey,@"authentication_key",
                      @"1",@"page",
                      @"999999",@"record_per_page",
                      @"type",@"search_column",
                      @"fund",@"search_text",
                      self.txtFrom.text,@"from_date",
                      self.txtTo.text,@"to_date",
                      @"",@"sort_by",
                      @"",@"sort_order",
                      nil];
        NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETTRANSACTIONCSV];
        NSLog(@"URL====%@",URL);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
        [request setHTTPMethod:@"POST"];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSLog(@"URL==%@",URL);
        NSLog(@"parametersAll Trans==%@",parameters);
        
        [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
            
            [hud removeFromSuperview];
            [self.view setUserInteractionEnabled:YES];
            
            NSError *err;
            json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                   options:kNilOptions
                                                     error:&err];
            NSString *Status=[json objectForKey:@"status"];
            if([[NSString stringWithFormat:@"%@",Status] isEqualToString:@"1"]){
                NSString *data =[json objectForKey:@"data"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data]];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                [alert show];
            }
            
        }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            NSLog(@"error:%@",error.description);
            //return error;
            json = nil;
            
        }];
            
        }
         else if ([slectedTab isEqualToString:@"pinless"])
         {
             hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
             hud.mode = MBProgressHUDModeIndeterminate;
             hud.label.text =@"Please Wait";
             
             [self.view addSubview:hud];
             [self.view setUserInteractionEnabled:NO];
             
             
             NSLog(@"slectedTab=%@",slectedTab);
             NSLog(@"athenticationKey=%@",athenticationKey);
             NSLog(@"start=%d",start);
             NSLog(@"end=%d",end);
             NSDictionary *parameters;
             __block NSDictionary* json;
             parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                           userId,@"user_id",
                           athenticationKey,@"authentication_key",
                           @"1",@"page",
                           @"999999",@"record_per_page",
                           @"type",@"search_column",
                           @"pinless",@"search_text",
                           self.txtFrom.text,@"from_date",
                           self.txtTo.text,@"to_date",
                           @"",@"sort_by",
                           @"",@"sort_order",
                           nil];
             NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETTRANSACTIONCSV];
             NSLog(@"URL====%@",URL);
             NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
             [request setHTTPMethod:@"POST"];
             AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
             manager.responseSerializer = [AFHTTPResponseSerializer serializer];
             NSLog(@"URL==%@",URL);
             NSLog(@"parametersAll Trans==%@",parameters);
             
             [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
                 
                 [hud removeFromSuperview];
                 [self.view setUserInteractionEnabled:YES];
                 
                 NSError *err;
                 json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                        options:kNilOptions
                                                          error:&err];
                 NSString *Status=[json objectForKey:@"status"];
                 if([[NSString stringWithFormat:@"%@",Status] isEqualToString:@"1"]){
                     NSString *data =[json objectForKey:@"data"];
                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data]];
                 }
                 else{
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                     [alert show];
                 }

             }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                 [alert show];
                 NSLog(@"error:%@",error.description);
                 //return error;
                 json = nil;
                 
             }];
                 
             }
              else if ([slectedTab isEqualToString:@"imtu"])
              {
                  hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                  hud.mode = MBProgressHUDModeIndeterminate;
                  hud.label.text =@"Please Wait";
                  
                  [self.view addSubview:hud];
                  [self.view setUserInteractionEnabled:NO];
                  
                  
                  NSLog(@"slectedTab=%@",slectedTab);
                  NSLog(@"athenticationKey=%@",athenticationKey);
                  NSLog(@"start=%d",start);
                  NSLog(@"end=%d",end);
                  NSDictionary *parameters;
                  __block NSDictionary* json;
                  parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                userId,@"user_id",
                                athenticationKey,@"authentication_key",
                                @"1",@"page",
                                @"999999",@"record_per_page",
                                @"type",@"search_column",
                                @"imtu",@"search_text",
                                self.txtFrom.text,@"from_date",
                                self.txtTo.text,@"to_date",
                                @"",@"sort_by",
                                @"",@"sort_order",
                                nil];
                  NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETTRANSACTIONCSV];
                  NSLog(@"URL====%@",URL);
                  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
                  [request setHTTPMethod:@"POST"];
                  AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
                  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                  NSLog(@"URL==%@",URL);
                  NSLog(@"parametersAll Trans==%@",parameters);
                  
                  [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
                      
                      [hud removeFromSuperview];
                      [self.view setUserInteractionEnabled:YES];
                      
                      NSError *err;
                      json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&err];
                      NSString *Status=[json objectForKey:@"status"];
                      if([[NSString stringWithFormat:@"%@",Status] isEqualToString:@"1"]){
                          NSString *data =[json objectForKey:@"data"];
                          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data]];
                      }
                      else{
                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                          [alert show];
                      }

                      
                  }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                      [alert show];
                      NSLog(@"error:%@",error.description);
                      //return error;
                      json = nil;
                      
                  }];
                      
                  }
                   else{
                       
                       hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                       hud.mode = MBProgressHUDModeIndeterminate;
                       hud.label.text =@"Please Wait";
                       
                       [self.view addSubview:hud];
                       [self.view setUserInteractionEnabled:NO];
                       
                       
                       NSLog(@"slectedTab=%@",slectedTab);
                       NSLog(@"athenticationKey=%@",athenticationKey);
                       NSLog(@"start=%d",start);
                       NSLog(@"end=%d",end);
                       NSDictionary *parameters;
                       __block NSDictionary* json;
                       parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                     userId,@"user_id",
                                     athenticationKey,@"authentication_key",
                                     @"1",@"page",
                                     @"999999",@"record_per_page",
                                     @"type",@"search_column",
                                     @"all",@"search_text",
                                     self.txtFrom.text,@"from_date",
                                     self.txtTo.text,@"to_date",
                                     @"",@"sort_by",
                                     @"",@"sort_order",
                                     nil];
                       NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETTRANSACTIONCSV];
                       NSLog(@"URL====%@",URL);
                       NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
                       [request setHTTPMethod:@"POST"];
                       AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
                       manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                       NSLog(@"URL==%@",URL);
                       NSLog(@"parametersAll Trans==%@",parameters);
                       
                       [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
                           
                           [hud removeFromSuperview];
                           [self.view setUserInteractionEnabled:YES];
                           
                           NSError *err;
                           json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                  options:kNilOptions
                                                                    error:&err];
                           NSLog(@"jsonALL TRANS==%@",json);
                           NSString *Status=[json objectForKey:@"status"];
                           if([[NSString stringWithFormat:@"%@",Status] isEqualToString:@"1"]){
                               NSString *data =[json objectForKey:@"data"];
                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data]];
                           }
                           else{
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                               [alert show];
                           }
                       }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                           [alert show];
                           NSLog(@"error:%@",error.description);
                           //return error;
                           json = nil;
                           
                       }];
                    }
                        
}
- (IBAction)popViews:(id)sender {
    [appDel setBothMenus];
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
