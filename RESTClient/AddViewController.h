//
//  AddViewController.h
//  RESTClient
//
//  Created by Speechkey on 21.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "User.h"

@protocol AddViewControllerDelegate <NSObject>

-(void)addToList:(id)subController User:(User *) user;

@end

@interface AddViewController : UIViewController <RKObjectLoaderDelegate>{
    __weak id<AddViewControllerDelegate> dataDelegate;
}
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) IBOutlet UITextField *labelName;
@property (nonatomic, strong) IBOutlet UITextField *labelAbout;
@property (nonatomic, strong) IBOutlet UITextField *labelImage;
@property (nonatomic, strong) IBOutlet UIScrollView *theScrollView;
@property (nonatomic, strong) UITextField *activeTextField;

@property (nonatomic, weak) id<AddViewControllerDelegate> dataDelegate;    

-(IBAction)add:(id)sender;

@end
