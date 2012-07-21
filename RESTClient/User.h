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

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) NSString *photo;

-(id)initUserWithId: (NSNumber *) uid
           withName: (NSString *) name
          withAbout: (NSString *) about
          withPhoto: (NSString *) photo;

@end