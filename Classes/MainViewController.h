//
//  MainViewController.h
//  PhotoS3UploadDemo
//
//  Created by Barry Ezell on 12/6/10.
//  Copyright 2010 Dockmarket LLC. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, FlipsideViewControllerDelegate> {
}

@property (nonatomic, retain) UIImagePickerController *pickerController;
@property (nonatomic, retain) IBOutlet UIImageView *imgView;

- (IBAction)showInfo:(id)sender;
- (IBAction)choosePictureButtonWasPressed;
- (IBAction)uploadPictureButtonWasPressed;

@end
