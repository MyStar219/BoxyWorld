//
//  webViewVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 26/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewVC : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *fromPage;
@end
