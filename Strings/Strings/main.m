//
//  main.m
//  Strings
//
//  Created by Piyush Gupta on 10/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        
        NSMutableString* mutableStr = [@"This is some mutable string" mutableCopy];
        NSString* immutableStr = mutableStr;
        
        NSLog(@"%@ %p",mutableStr,mutableStr);
        NSLog(@"%@ %p",immutableStr,immutableStr);
        
        [mutableStr setString: @"Something else"];
        NSLog(@"---------------------------------------- After changing the string");
        
        NSLog(@"%@ %p",mutableStr,mutableStr);
        NSLog(@"%@ %p",immutableStr,immutableStr);
        
        
        
        NSLog(@"------------------------------------------ Numbers");
        NSNumber * numCreationFromInt = [NSNumber numberWithInt: 10];
        NSNumber * numCreationFromFloat = [NSNumber numberWithFloat: 10.0];
        NSNumber * numCreationFromChar  = [NSNumber numberWithChar: 'A'];
        
        // Another way of creation
        NSNumber * numInt = @10;
        NSNumber * numChar = @'B';
        NSNumber * numFloat = @10.5;
        
        NSLog(@"%ld",(long)[numInt integerValue]);
        NSLog(@"%c",[numChar charValue]);
        
        
        
        NSLog(@"------------------------------------------ NSArray Mutable");
        NSMutableArray* mutableArray = [@[@"abc", @"def"] mutableCopy];
        // if index > size then crash
        [mutableArray insertObject:@"piy" atIndex: 2];
        
        for(NSString* str in mutableArray){
            NSLog(@"%@", str);
        }
        
        // NSMutableArray* sorted = [mutableArray sortUsingSelector: @selector(compare:)];
        
        NSLog(@"------------------------------------------ NSArrayIterators");
        // Put the appropriate selector
        // [mutableArray makeObjectsPerformSelector: @selector(removeAllObjects:)];
        
        
        for(NSString* str in mutableArray){
            NSLog(@"%@", str);
        }
        
        [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([obj isEqualToString: @"abc"]){
                NSLog(@"abc found! Now stopping");
                *stop = true;
            }else{
                NSLog(@"%@",obj);
            }
        }];
        
        // Generics
        NSLog(@"------------------------------------------ Generics");
        NSArray* arr = @[@1, @2, @3, @"Piyush"];
        
        for(NSNumber* num in arr){
            NSLog(@"%@",num);
        }
        
        NSArray<NSNumber *> *genericArray = @[@1, @2, @3, @6, @"Array"];
        
        for(NSNumber* num in genericArray){
            NSLog(@"%@",num);
        }
        
        NSLog(@"------------------------------------------ Blocks");
        
        NSString * (^blockName) (NSString* , NSNumber*) = ^(NSString* str, NSNumber* num){
            NSString* strng = [NSString localizedStringWithFormat: @"Hey %@ %ld",str,[num integerValue]];
            return strng;
        };
        
        NSLog(@"%@",blockName(@"Piyush",@43));
    }
//
//- NSLessThanComparison compare:(NSString*)otherObj{
//    return []
//}
    return 0;
}
