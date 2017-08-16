//
//  DateViewController.h
//  KavingsCoupon
//
//  Created by Matainja Technologies on 21/09/15.
//  Copyright (c) 2015 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewControllerDelegate

-(void)dateWasSelected:(NSDate *)selectedDate;
@end

@interface DateViewController : UIViewController

@property (nonatomic, strong) id<DatePickerViewControllerDelegate> delegate;


@property (strong, nonatomic) IBOutlet UILabel *labelBuy;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateSelect;
@property (strong,nonatomic) NSString *toggleValue;
@property (strong,nonatomic) NSString *previousPage;


@end
