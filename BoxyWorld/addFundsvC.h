//
//  addFundsvC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 16/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addFundsvC : UIViewController
{
     NSMutableArray *addFundsListArray;
    IBOutlet UITextField *activeField; 
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollAddFunds;
@property (weak, nonatomic) IBOutlet UITableView *addFundsView;
@property (weak, nonatomic) IBOutlet UITextField *amountFld;

@property (weak, nonatomic) IBOutlet UIButton *progressPaymentBtn;

@property (weak, nonatomic) IBOutlet UILabel *totalDueLbl;
@property (weak, nonatomic) IBOutlet UIView *swtView;
@property (weak, nonatomic) IBOutlet UIButton *btnAddCard;
@property (weak, nonatomic) IBOutlet UIView *viewtotalDue;
@property (strong, nonatomic) IBOutlet UIButton *btnViewCardDetls;
@property (strong, nonatomic) IBOutlet UILabel *lblCardlist;

@end
