//
//  FARootViewController.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 1/27/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAPeopleViewController.h"
#import <opencv2/highgui/cap_ios.h>

@interface FARootViewController : UIViewController
    <
    UIGestureRecognizerDelegate,
    FAPeopleViewControllerDelegate,
    CvVideoCameraDelegate
    >


@end
