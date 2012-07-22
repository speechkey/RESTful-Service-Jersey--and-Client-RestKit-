//
//  User.h
//  RESTClient
//
//  Created by Speechkey on 21.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    NSNumber *uid;
    NSString *name;
    NSString *about;
    NSString *photo;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *uid;
@property (nonatomic, retain) NSString *about;
@property (nonatomic, retain) NSString *photo;

-(id)initUserWithId: (NSNumber *) uid
           withName: (NSString *) name
          withAbout: (NSString *) about
          withPhoto: (NSString *) photo;

@end