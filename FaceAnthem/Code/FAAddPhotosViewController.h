//
//  FAAddPhotosViewController.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/2/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/cap_ios.h>

@class FAAddPhotosViewController;

@protocol FAAddPhotosViewControllerDelegate <NSObject>

- (void)didDismissAddPhotosViewController:(FAAddPhotosViewController *)controller withPhotos:(NSArray *)photos;

@end

@interface FAAddPhotosViewController : UIViewController <CvVideoCameraDelegate>

@property (nonatomic, weak) id<FAAddPhotosViewControllerDelegate> delegate;

@end
