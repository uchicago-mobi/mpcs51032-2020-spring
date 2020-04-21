//
//  SwitchViewController.m
//  2020-SwitchToObjectiveC
//
//  Created by T. Andrew Binkowski on 4/3/20.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

#import "SwitchViewController.h"

@interface SwitchViewController ()

@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
    NSLog(@"The view did load");
  
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

//  // @"kSwitchPreference"
//  if ([defaults ¬getBoolForKey:@"kSwitchPreference"]) == TRUE {
//    self.switch.isEnabled = TRUE
//  }
  
}


// Toggle the values of the switch and store its values in `NSUserDefaults`.
// Dump the user defaults to the console for debugging
- (IBAction)tapSwitch:(UISwitch *)sender {
  
  NSLog(@"Switch Value:%d", sender.isOn);
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  //NSLog(@"Defaults: %@",defaults.dictionaryRepresentation);
  
  [defaults setBool:sender.isOn forKey:@"kSwitchPreference"];
  //NSLog(@"Defalts: %@", defaults.dictionaryRepresentation);
}

@end




