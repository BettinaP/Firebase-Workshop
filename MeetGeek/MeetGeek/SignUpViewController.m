//
//  SignUpViewController.m
//  MeetGeek
//
//  Created by Julianne on 10/15/16.
//  Copyright © 2016 Julianne Goyena. All rights reserved.
//

#import "SignUpViewController.h"
#import "Event.h"
#import "Attendee.h"
#import "FirebaseManager.h"

@interface SignUpViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UITextField *commentTextField;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;

// Text Fields for Attendee info
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *ageTextField;
@property (strong, nonatomic) IBOutlet UITextField *sexTextField;
@end



@implementation SignUpViewController

- (instancetype)init {
    self = [super init];
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    Event *event = self.event;
    self.image.image = event.image;
    self.name.text = event.name;
    self.time.text = event.time;
}
- (IBAction)signUpButtonClicked:(id)sender {
    
    Attendee *attendee = [[Attendee alloc] initWithEvent:self.event name:self.nameTextField.text age:self.ageTextField.text sex:self.sexTextField.text];
    
    if (self.commentTextField.text.length > 0)
    {
        attendee.comment = self.commentTextField.text;
    }
    
    [[FirebaseManager sharedManager] postAttendee:attendee];
}


@end
