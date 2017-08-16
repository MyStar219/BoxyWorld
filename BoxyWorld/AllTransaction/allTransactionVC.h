//
//  allTransactionVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 23/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface allTransactionVC : UIViewController
{
     NSMutableArray *alltranListArray;
     IBOutlet UITextField *activeField;
}
@property (strong, nonatomic) IBOutlet UILabel *navBarTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtTo;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnReset;
@property (weak, nonatomic) IBOutlet UIButton *btnDnldCSV;
@property (weak, nonatomic) IBOutlet UITableView *tblallTrns;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadeMore;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePiker;

@property(strong,nonatomic)NSString *selfTitle;
//@property (weak, nonatomic) IBOutlet UIButton *btnRefund;

@end
