//
//  Dog.h
//  2018-SwitchToObjectiveC
//
//  Created by T. Andrew Binkowski on 4/9/18.
//  Copyright © 2018 The University of Chicago, Department of Computer Science. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dog : NSObject
@property (strong, nonatomic) NSString *message;

- (int)numberOfDogs:(int)number;

@end
