//
//  PhotoS3UploadDemoAppDelegate.h
//  PhotoS3UploadDemo
//
//  Created by Barry Ezell on 12/6/10.
//  Copyright 2010 Dockmarket LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface PhotoS3UploadDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

@end

