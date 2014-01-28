//
//  FAFaceAssignmentViewController.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 1/27/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FAFaceAssignmentViewController;

@protocol FAFaceAssignmentViewControllerDelegate <NSObject>

- (void)didDismissFaceAssignmentController:(FAFaceAssignmentViewController *)controller;

@end

@interface FAFaceAssignmentViewController : UIViewController

@property (nonatomic, strong) UIImage *previewImage;
@property (nonatomic, weak) id<FAFaceAssignmentViewControllerDelegate> delegate;

@end
