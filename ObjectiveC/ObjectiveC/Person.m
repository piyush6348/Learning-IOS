//
//  Person.m
//  ObjectiveC
//
//  Created by Piyush Gupta on 17/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)printGreeting{
    NSLog(@"Hey this is Piyush");
}

- (void)printGreetingWithParams: (NSString*) personName{
    NSLog(@"Hey greetings to %@",personName);
}

- (void)printGreetingWithTwoParams:(NSString *)personName atTimeOfDay:(NSString *)time{
    if([time isEqualToString: @"morning"]){
        NSLog(@"Good Morning %@",personName);
    }else{
        NSLog(@"Good Evening %@",personName);
    }
}

+ (void)printGenericMeeting{
    NSLog(@"Hello to all");
}
@end
