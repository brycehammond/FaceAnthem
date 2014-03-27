//
//  FAAddPhotosViewController.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/2/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FABaseCameraViewController.h"

@class FAAddPhotosViewController;

@protocol FAAddPhotosViewControllerDelegate <NSObject>

- (void)didDismissAddPhotosViewController:(FAAddPhotosViewController *)controller withPhotos:(NSArray *)photos;

@end

@interface FAAddPhotosViewController : FABaseCameraViewController

@property (nonatomic, weak) id<FAAddPhotosViewControllerDelegate> delegate;

@end
