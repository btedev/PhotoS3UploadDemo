//
//  MainViewController.m
//  PhotoS3UploadDemo
//
//  Created by Barry Ezell on 12/6/10.
//  Copyright 2010 Dockmarket LLC. All rights reserved.
//

#import "MainViewController.h"
#import "ASIS3Bucket.h"
#import "ASIS3Request.h"
#import "ASIS3ObjectRequest.h"

#define SECRET_KEY  @"Your Secret Key"
#define ACCESS_KEY  @"Your Access Key"
#define BUCKET @"btetampa"  //must not contain underscores

@implementation MainViewController

@synthesize imgView, pickerController;

- (void)dealloc {
	[imgView release];
	[pickerController release];
    [super dealloc];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIImagePickerController *pc = [[UIImagePickerController alloc] init];
	self.pickerController = pc;
	self.pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
	self.pickerController.allowsEditing = YES;
	self.pickerController.delegate = self;
	[pc release];
}


#pragma mark -
#pragma mark IBAction methods
- (IBAction)choosePictureButtonWasPressed {
	[self presentModalViewController:self.pickerController animated:YES];
}

- (IBAction)uploadPictureButtonWasPressed {
	//in production, should do this asynchronously and notify user of progress...
	[ASIS3Request setSharedSecretAccessKey:SECRET_KEY];
	[ASIS3Request setSharedAccessKey:ACCESS_KEY];
	
	//create a key of this object from the current time just for demonstration
	NSString *objKey = [NSString stringWithFormat:@"%@.png",[NSDate date]];
	
	//Upload using NSData instead of a file for demo.  In production, may write to disk before upload so would
	//use PUTRequestForFile:::
	NSData *imgData = UIImagePNGRepresentation(self.imgView.image);
	ASIS3ObjectRequest *request = [ASIS3ObjectRequest PUTRequestForData:imgData 
							   withBucket:BUCKET 
									  key:objKey];
	
	[request startSynchronous];
	if ([request error]) {
		NSLog(@"%@",[[request error] localizedDescription]);
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Amazon S3" 
													message:@"Upload successful!" 
												   delegate:nil 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[self.pickerController dismissModalViewControllerAnimated:YES];
	self.imgView.image = [info objectForKey:UIImagePickerControllerEditedImage];	
}

#pragma mark -
#pragma mark FlipsideViewController methods
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {    
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo:(id)sender {    	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


@end
