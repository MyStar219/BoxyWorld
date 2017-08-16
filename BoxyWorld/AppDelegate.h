//
//  AppDelegate.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 10/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
/*{
UITabBarController *tabBarController;
}*/
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SWRevealViewController *viewController;
+(AppDelegate*) instance;
-(void)setBothMenus;
-(void)goToLoginPage;

@end

