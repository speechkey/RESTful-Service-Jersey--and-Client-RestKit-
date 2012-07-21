//
//  AppDelegate.m
//  RESTClient
//
//  Created by Speechkey on 21.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <RestKit/RestKit.h>

#import "AppDelegate.h"
#import "User.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Create URL with
    RKURL* baseUrl = [self getServiceURL];
    
    RKObjectMapping *objectMapping = [RKObjectMapping 
                                      mappingForClass:[User class]];
    
    [objectMapping mapKeyPath:@"id" 
                  toAttribute:@"uid"];
    [objectMapping mapKeyPath:@"name" 
                  toAttribute:@"name"];
    [objectMapping mapKeyPath:@"about" 
                  toAttribute:@"about"];
    [objectMapping mapKeyPath:@"photo" 
                  toAttribute:@"photo"];
    
    RKObjectMapping *patientSerializationMapping = [RKObjectMapping 
                                                    mappingForClass:[User class]]; 
    [patientSerializationMapping mapKeyPath:@"uid" 
                                toAttribute:@"id"]; 
    [patientSerializationMapping mapKeyPath:@"name" 
                                toAttribute:@"name"]; 
    [patientSerializationMapping mapKeyPath:@"about" 
                                toAttribute:@"about"]; 
    [patientSerializationMapping mapKeyPath:@"photo" 
                                toAttribute:@"photo"];  
    
    RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL: baseUrl];
    objectManager.serializationMIMEType = RKMIMETypeJSON;
    [objectManager.mappingProvider setMapping:objectMapping forKeyPath:@"user"];
    //[objectManager.mappingProvider setMapping:objectMapping forKeyPath:@"user/:uid"];
    [objectManager.mappingProvider setSerializationMapping:patientSerializationMapping forClass:[User class]]; 
    
    RKObjectRouter *router = [RKObjectManager sharedManager].router;
    [router routeClass:[User class] toResourcePath:@"/user" forMethod:RKRequestMethodGET];
    [router routeClass:[User class] toResourcePath:@"/user" forMethod:RKRequestMethodPOST];
    [router routeClass:[User class] toResourcePath:@"/user/:uid" forMethod:RKRequestMethodPUT];
    [router routeClass:[User class] toResourcePath:@"/user/:uid" forMethod:RKRequestMethodDELETE];
    
    [RKObjectManager sharedManager].router = router;
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (RKURL *)getServiceURL{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"settings.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization 
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
    return [RKURL URLWithBaseURLString:[temp objectForKey:@"ServiceURI"]];
}
@end
