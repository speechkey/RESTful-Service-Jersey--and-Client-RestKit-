//
//  MasterViewController.h
//  RESTClient
//
//  Created by Speechkey on 21.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

#import "DetailViewController.h"
#import "AddViewController.h"

@interface MasterViewController : UITableViewController <RKObjectLoaderDelegate, DetailViewControllerDelegate, AddViewControllerDelegate>

@property (retain, nonatomic) NSMutableArray *data;

@end
