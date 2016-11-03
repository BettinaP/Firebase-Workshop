//
//  FirebaseManager.h
//  MeetGeek
//
//  Created by Julianne on 11/2/16.
//  Copyright © 2016 Julianne Goyena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attendee.h"

@protocol FirebaseManagerDelegate <NSObject>

//nonatomic is not threadsafe, atomic is thread safe. Default to nonatomic so they're easeir to access and are faster
//create delegate so tableview automatically updates
@end


@interface FirebaseManager : NSObject

@property (nonatomic, weak)id delegate;
@property (nonatomic, strong) NSMutableArray <Attendee*> *attendees;



+ (id)sharedManager;
- (void)postAttendee:(Attendee*)attendee;
-(void)reloadRequests;
@end
