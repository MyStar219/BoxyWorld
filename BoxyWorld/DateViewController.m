//
//  DateViewController.m
//  KavingsCoupon
//
//  Created by Matainja Technologies on 21/09/15.
//  Copyright (c) 2015 Matainja Technologies. All rights reserved.
//

#import "DateViewController.h"
#import "Config.h"
#import "UIConfig.h"
#import "DealAccessSession.h"
#import "TribeRequestViewController.h"
#import "MGUtilities.h"
#import "DealViewController.h"
//#import "DealViewController.h"

@interface DateViewController (){
    DealSession *dealSession;
}

@end

@implementation DateViewController
@synthesize toggleValue;
@synthesize previousPage;
@synthesize  labelBuy;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIBarButtonItem* itemSearch = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:ICON_OK]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(didClickBarButtonSearchDate:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:itemSearch, nil];
    
    UIBarButtonItem *leftbarButton =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:BUTTON_WEB_BACK]
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(didPressBack:)];
    self.navigationItem.leftBarButtonItem =leftbarButton;
    self.navigationItem.title =LOCALIZED(@"Date");
    if([self.previousPage isEqualToString:@"MykavingsViewController"]){
        [self.labelBuy setText:@"I would like it by.."];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*-(void)didClickBarButtonSearchDate:(id)sender {

    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    
   [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [dateFormatter stringFromDate:self.dateSelect.date];
    
    NSLog(@"date =%@",stringFromDate);
            
    [self.navigationController popViewControllerAnimated:YES];
    
//    [MGUtilities showAlertTitle:nil message:@"Select Friends to share deal"];
//    
//        TribeRequestViewController *tvc =[self.storyboard instantiateViewControllerWithIdentifier:@"storyboardTribeRequest"];
//        tvc.StringDate=stringFromDate;
//        [self.navigationController pushViewController:tvc animated:YES];

}*/
-(void)didClickBarButtonSearchDate:(id)sender {
    
    // Notify the caller that a date was selected.
    [self.delegate dateWasSelected:self.dateSelect.date];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    NSString *stringFromDate = [dateFormatter stringFromDate:self.dateSelect.date];
    
    NSLog(@"date =%@",stringFromDate);
    
    
    
    // Pop the view controller.
    dealSession.dealBuyDate = stringFromDate;
    [DealAccessSession storeDealSession:dealSession];
   
    if ([toggleValue isEqualToString:@"0"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    

}

-(void)didPressBack:(id)sender{
    
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

@end
