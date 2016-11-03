//
//  SignUpViewController.h
//  MeetGeek
//
//  Created by Julianne on 10/15/16.
//  Copyright © 2016 Julianne Goyena. All rights reserved.
//

#import "ViewController.h"


@class Event;

@interface SignUpViewController : ViewController

@property (strong, nonatomic) Event *event;

- (instancetype)init;
- (IBAction)signUpButtonClicked:(id)sender;

@end
