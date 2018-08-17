//
//  PersonWithDM.m
//  ObjectiveC
//
//  Created by Piyush Gupta on 17/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

#import "PersonWithDM.h"

@implementation PersonWithDM

- (void)printGreeting{
    // self is used for getting a property
    NSLog(@"Hey %@ %@",firstName,self.lastName);
    
    // calling getter on lastName property
    NSLog(@"Hey %@ %@",firstName,[self lastName]);
    
    // _lastName is internally generated iVar for lastName property
    // This is fastest but actually we are never sure of name of this iVar as it is created internally by OS
    // So in that case we can fix the iVar name of a property
    NSLog(@"Hey %@ %@",firstName, _lastName);
}
@end
