//
//  SwitchViewController.h
//  2020-SwitchToObjectiveC
//
//  Created by T. Andrew Binkowski on 4/3/20.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *switch;

- (IBAction)tapSwitch:(UISwitch *)sender;

@end
