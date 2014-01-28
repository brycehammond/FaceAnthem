//
//  IMViewController.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 1/27/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAFaceFinder.h"
#import "FAFaceAssignmentViewController.h"

@interface FARootViewController : UIViewController <UIGestureRecognizerDelegate, FAFaceFinderDelegate, FAFaceAssignmentViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIView *previewView;

@end
