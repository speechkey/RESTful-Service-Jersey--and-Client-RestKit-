//
//  AddViewController.m
//  RESTClient
//
//  Created by Speechkey on 21.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <RestKit/RestKit.h>
#import "AddViewController.h"
#import "User.h"

@interface AddViewController ()

@end

@implementation AddViewController
@synthesize labelName, labelImage,
            labelAbout,
            dataDelegate, user,
theScrollView, activeTextField;

-(void)add:(id)sender{
    user = [[[User alloc ] initUserWithId:0 withName:labelName.text withAbout:labelAbout.text withPhoto:labelImage.text] autorelease];
    [[RKObjectManager sharedManager] postObject:user delegate:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    // Release any retained subviews of the main view.
    //remove observers
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    user = [objects objectAtIndex:0];
    if([dataDelegate respondsToSelector:@selector(userChanged:inView:atIndex:)]){
        [dataDelegate addToList:self User:user];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                      message:[NSString stringWithFormat: @"Error: %@ ", error]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
    [message release];
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
- (void)dealloc
{
    [labelName release];
    [labelImage release];
    [labelAbout release];
    [user release];
    [theScrollView release];
    [activeTextField release];
    [super dealloc];
}

@end
