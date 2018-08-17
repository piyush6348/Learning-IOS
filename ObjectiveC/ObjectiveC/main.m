//
//  main.m
//  ObjectiveC
//
//  Created by Piyush Gupta on 09/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "PersonWithDM.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        int i = 200;
        const j = 20;
        NSString * str = @"Piyush Gupta";
        NSArray * arr = @[@"Piyush" , @"Gupta"];
        
        // NSLog(i);
        NSLog(str);
        // NSLog(arr);
        
        
        switch (i) {
            case 10:
                NSLog(@"It's 10");
                break;
                
            case 20:
                NSLog(@"It's 20");
                
            case 30:
                NSLog(@"It's 30");
                break;
                
            case 40 ...100:
                NSLog(@"It's between 40 and 100");
                
            default:
                NSLog(@"default");
            case 110:
                NSLog(@"It's 50");
                break;
        }
        NSLog(@"--------------------------------------------- Arrays");
        for(NSString* name in arr)
            NSLog(@"%@", name);
        
        for(int i= 1 ; i<=5; i++)
            NSLog(@"%d * %d = %d",i,i,i*i);
        
        for(NSString* elem in arr){
            NSLog(@"Hello %@",elem);
        }
        
        NSLog(@"--------------------------------------------- NSInteger");
        NSInteger num = 10;
        NSLog(@"%ld", (long)num);
        
        NSLog(@"--------------------------------------------- Person Class");
        Person* person = [Person new];
        [person printGreeting];
        [person printGreetingWithParams: @"Nimit"];
        [person printGreetingWithTwoParams: @"Piyush" atTimeOfDay:@"morning"];
        [Person printGenericMeeting];
        
        // If 10 params then use withObject 10 times?
        // No
        // In that case use dictionary
        [person performSelector:@selector(printGreeting)];
        [person performSelector:@selector(printGreetingWithParams:) withObject:@"Nimit"];
        [person performSelector:@selector(printGreetingWithTwoParams:atTimeOfDay:) withObject:@"Piyush" withObject:@"morning"];
        
        NSLog(@"--------------------------------------------- PersonWithDM Class");
        PersonWithDM * personWithDM = [PersonWithDM new];
        [personWithDM printGreeting];
        personWithDM->firstName = @"Piyush";
        [personWithDM printGreeting];
        // This is a property
        // when writing like this
        // internally it gets replaced by its setter call
        // when retrieving a value it gets replaced by it's getter call
        personWithDM.lastName = @"Gupta";
    }
    return 0;
}
