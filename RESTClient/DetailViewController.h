//
//  DetailViewController.h
//  RESTClient
//
//  Created by Speechkey on 21.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "User.h"

@protocol DetailViewControllerDelegate <NSObject>

-(void)userChanged:(User *)user inView:(id) viewController atIndex:(NSInteger) index; 

@end

@interface DetailViewController : UIViewController <RKObjectLoaderDelegate>{
    id<DetailViewControllerDelegate> dataDelegate;
}
@property (nonatomic, retain) NSNumber *uid;
@property (nonatomic) NSInteger index;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *photo;
@property (nonatomic, retain) NSString *about;
@property (nonatomic, retain) IBOutlet UITextField *labelName;
@property (nonatomic, retain) IBOutlet UITextField *labelAbout;
@property (nonatomic, retain) IBOutlet UIImageView *labelImage;
@property (nonatomic, retain) IBOutlet UIScrollView *theScrollView;
@property (nonatomic, retain) UITextField *activeTextField;

@property (nonatomic, assign) id<DetailViewControllerDelegate> dataDelegate;

-(IBAction)sendNewData:(id)sender;

@end
