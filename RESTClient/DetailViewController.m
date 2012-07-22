//
//  DetailViewController.m
//  RESTClient
//
//  Created by Speechkey on 21.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "User.h"
#import <RestKit/RestKit.h>


@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize uid, index, photo, name, about,
            labelName, labelAbout,
            labelImage, activeTextField,
            dataDelegate, theScrollView;
            

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)sendNewData:(id)sender{
    User *user = [[[User alloc] initUserWithId:uid withName:labelName.text withAbout:labelAbout.text withPhoto:photo] autorelease];
    // POST to /contacts  
    [[RKObjectManager sharedManager] putObject:user delegate:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    labelName.text = name;
    labelAbout.text = about;
    labelImage.image = [UIImage imageWithData:
                        [NSData dataWithContentsOfURL:
                         [NSURL URLWithString:photo]]];;
    //Add observer for keyboard   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
  }

- (void)viewDidUnload
{
    [super viewDidUnload];
    //remove observers
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Release any retained subviews of the main view.
}

- (void)keyboardWasShown:(NSNotification *)notification 
{
    
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    theScrollView.contentInset = contentInsets;
    theScrollView.scrollIndicatorInsets = contentInsets;
    
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, activeTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeTextField.frame.origin.y - (keyboardSize.height-15));
        [theScrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    theScrollView.contentInset = contentInsets;
    theScrollView.scrollIndicatorInsets = contentInsets;
} 

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField; 
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeTextField = nil;
}

- (IBAction)dismissKeyboard:(id)sender
{
    [activeTextField resignFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
    return YES;
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    User *user = [objects objectAtIndex:0];
    if ([dataDelegate respondsToSelector:@selector(userChanged:inView:atIndex:)]) {
        [dataDelegate userChanged:user inView:self atIndex:index];
    }
    NSLog(@"Loaded User ID #%@ -> Name: %@", user.uid, user.name);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                      message:[NSString stringWithFormat: @"Error: %@ ", error]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    [message release];
    NSLog(@"Error in DetailVeiwController: %@", error);
}

- (void)dealloc
{
    [labelName release];
    [labelAbout release];
    [labelImage release];
    [activeTextField release];
    [theScrollView release];
    [name release];
    [about release];
    [photo release];
    [uid release];
    [super dealloc];
}
@end
