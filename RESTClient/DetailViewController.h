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
    __weak id<DetailViewControllerDelegate> dataDelegate;
}
@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic) NSInteger index;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) IBOutlet UITextField *labelName;
@property (nonatomic, strong) IBOutlet UITextField *labelAbout;
@property (nonatomic, strong) IBOutlet UIImageView *labelImage;
@property (nonatomic, strong) IBOutlet UIScrollView *theScrollView;
@property (nonatomic, strong) UITextField *activeTextField;

@property (nonatomic, weak) id<DetailViewControllerDelegate> dataDelegate;

-(IBAction)sendNewData:(id)sender;

@end
