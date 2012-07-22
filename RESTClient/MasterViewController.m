//
//  MasterViewController.m
//  RESTClient
//
//  Created by Speechkey on 21.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"

#import <RestKit/RestKit.h>
#import "User.h"
#import "DetailViewController.h"
#import "AddViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

@synthesize data;

- (void)sendRequest
{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/user" delegate:self];
}

-(void)deleteUser:(NSUInteger) index{
    User* user = [data objectAtIndex:index];
    NSLog(@"Index to delete: %@", user.name);
    [[RKObjectManager sharedManager] deleteObject:user delegate:self];
    [data removeObjectAtIndex:index];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Set title of a view
    self.title = @"Users";
    //Add edit button
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self sendRequest];
}

- (void)viewDidUnload
{
    //Unset edit button
    self.navigationItem.rightBarButtonItem = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //Send request
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//How much rows in a table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"There is %i rows in a table now.", data.count);
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get a reusable cell obj by type
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //Check if any spare cell exists, if not create one
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    }
    //Get loaded user obj at index
    User *user = [data objectAtIndex:indexPath.row];
    //Add users name
    cell.textLabel.text = [NSString stringWithFormat:@"%@", user.name];
    //Display placeholder image while image is downloading
    cell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
    dispatch_async(queue, ^{
        NSURL *imageURL = [NSURL URLWithString:[user photo]];
        NSData *image = [NSData dataWithContentsOfURL:imageURL];
        UIImage *img = [UIImage imageWithData:image]; 
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            cell.imageView.image = img;
            [cell setNeedsLayout];
        });
    });
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self deleteUser:indexPath.row];
        [tableView reloadData];
    }  
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Response code: %d", [response statusCode]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    if(objectLoader.response.statusCode != 204){
        data = [objects mutableCopy];
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    User *user = [data objectAtIndex:indexPath.row];
    
    DetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    [detail setDataDelegate:self];
    detail.index = indexPath.row;
    detail.uid = user.uid;
    detail.name = user.name;
    detail.about = user.about;
    detail.photo = user.photo;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    [super setEditing:editing animated:animate];
    
    if (editing)
    {
        UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)] autorelease];
        self.navigationItem.leftBarButtonItem = addButton;
    }
    else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)addItem:sender {
    NSLog(@"test add");
    AddViewController *addView = [self.storyboard instantiateViewControllerWithIdentifier:@"AddView"];
    //important to set the viewcontroller's delegate to be self
    [addView setDataDelegate:self];
    [self.navigationController pushViewController:addView animated:YES];
}

- (void)addToList:(AddViewController *)addView User:(User *)user
{
    [user retain];
    [data addObject:user];
    [self.tableView reloadData];
}
- (void)userChanged:(User *)user inView:(id)viewController atIndex:(NSInteger) index{
    [data replaceObjectAtIndex:index withObject:user];
    NSLog(@"Data:%@", data);
    [self.tableView reloadData];
}
- (void)dealloc
{
    [data release];
    [super dealloc];
}
@end