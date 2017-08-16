//
//  answerVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 11/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface answerVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblfaqQstn;
@property (weak, nonatomic) IBOutlet UITextView *faqAnsPara;
@property (strong, nonatomic) IBOutlet NSString *qstnId;
@property (strong, nonatomic) IBOutlet NSString *Question;
@end
