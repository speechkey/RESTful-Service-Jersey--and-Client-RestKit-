//
//  User.m
//  RESTClient
//
//  Created by Speechkey on 21.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize uid;
@synthesize name;
@synthesize about;
@synthesize photo;

- (NSDictionary*)elementToPropertyMappings {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"id", @"uid",
            @"name", @"name",
            @"about", @"about",
            @"photo", @"photo", nil];
}

-(id)initUserWithId: (NSNumber *) new_uid
           withName: (NSString *) new_name
          withAbout: (NSString *) new_about
          withPhoto: (NSString *) new_photo{
    if(self = [super init]){
        uid = [new_uid retain];
        name = [new_name retain];
        about = [new_about retain];
        photo = [new_photo retain];
    }
    return self;
}
- (void)dealloc
{
    [uid release];
    [name release];
    [about release];
    [photo release];
    [super dealloc];
}
@end

