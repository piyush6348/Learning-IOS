//
//  Person.h
//  ObjectiveC
//
//  Created by Piyush Gupta on 17/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

- (void)printGreeting;
- (void)printGreetingWithParams: (NSString*)personName;
- (void)printGreetingWithTwoParams: (NSString *)personName atTimeOfDay: (NSString*)time;
- (void)printGreetingWithTwoParamsWithoutExternalParam: (NSString *)personName :(NSString *)time;
+ (void)printGenericMeeting;
@end
