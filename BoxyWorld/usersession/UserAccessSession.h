//
//  UserAccessSession.h
//  Kavings Two
//
//  Created by Matainja Technologies on 31/08/15.
//  Copyright (c) 2015 Matainja Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserSession.h"

@interface UserAccessSession : NSObject

+(void)storeUserSession:(UserSession*)session;
+(UserSession*)getUserSession;

+(void) clearAllSession;
@end
