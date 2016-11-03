//
//  FirebaseManager.m
//  MeetGeek
//
//  Created by Julianne on 11/2/16.
//  Copyright © 2016 Julianne Goyena. All rights reserved.
//

#import "FirebaseManager.h"
#import "Constants.h"
@import Firebase;

@interface FirebaseManager()

@property(strong, nonatomic) FIRDatabaseReference *ref;




@end

@implementation FirebaseManager

+ (id)sharedManager {
    static FirebaseManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        //automatically initialize if in firebase or database manager?
        
        self.ref = [[FIRDatabase database]reference];
        self.attendees = [NSMutableArray new];
        [self setupObservers]; //included because firebase self updating, so each time you're creating a new user you want to make a call to firebase for latest info.
    }
    return self;
}
//POST method in our manager to communicate with our database, so have to edit our manager and our signupVC



//posting an attendee to our firebase by creating a dictionary with all the attendee information and then need to send it to firebase...this function will be called in signUpVC
- (void)postAttendee:(Attendee*)attendee
{ //creating dictionary of attendee info
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithDictionary:@{kEventId: @(attendee.event.eventId),
                                                                                          kEventName: attendee.event.name,
                                                                                          kUserName: attendee.name,
                                                                                          kUserAge: attendee.age,
                                                                                          kUserSex: attendee.sex,
                                                                                          }];
    if (attendee.comment.length > 0)
    {
        [postDictionary setValue:attendee.comment forKey:kUserComment];
    }
    //sending to firebase
    
    FIRDatabaseReference *attendeeReference = [self.ref childByAutoId]; //childByAutoID (from Firebase), when posting to firebase, it has to be a dictionary. this function creates a unique ID for child. calling reference and setting value to be key of dictionary.
    [attendeeReference setValue:postDictionary];
    
    
}

//creating an attendee from firebase post /data addition
- (Attendee*)createAttendee:(NSDictionary*)dictionary
{
    Event *event = [[Event alloc] init];
    event.name = dictionary[kEventName];
    
    NSString *userName = dictionary[kUserName];
    NSString *userAge = dictionary[kUserAge];
    NSString *userSex = dictionary[kUserSex];
    NSString *userComment = dictionary[kUserComment];
    
    Attendee *attendee = [[Attendee alloc] initWithEvent:event name:userName age:userAge sex:userSex];
    attendee.comment = userComment;
    
    return attendee;
}



- (void)setupObservers
{// call reference since first point of contact with database
    
    [self.ref observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        //creating an attendee object from firebase data, snapshot of value
        Attendee *attendee = [self createAttendee:snapshot.value];
        
        [self.attendees addObject:attendee];
        
        //delegate , so it'll tell tableview to reload when there's new info
        if (self.delegate && [self.delegate respondsToSelector:@selector(reloadRequests)])
            
        {
            [self.delegate reloadRequests];
        }
   
}];

}


@end
