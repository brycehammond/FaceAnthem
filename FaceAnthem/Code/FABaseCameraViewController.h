//
//  FABaseCameraViewController.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/26/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/cap_ios.h>

@class FAFaceDetector;

@interface FABaseCameraViewController : UIViewController
<
CvVideoCameraDelegate
>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) FAFaceDetector *faceDetector;
@property (nonatomic, strong) CvVideoCamera* videoCamera;
@property (nonatomic, strong) CALayer *featureLayer;

- (void)highlightFace:(CGRect)faceRect withColor:(UIColor *)color andPersonObjectId:(NSManagedObjectID *)personId withConfidence:(CGFloat)confidence;

@end
