//
//  FARootViewController.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 1/27/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FARootViewController.h"
#import "FAFaceDetector.h"
#import "FAFaceRecognizer.h"
#import <QuartzCore/QuartzCore.h>

#define kCaptureFPS 30

@interface FARootViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) FAFaceDetector *faceDetector;
@property (nonatomic, strong) FAFaceRecognizer *faceRecognizer;
@property (nonatomic, strong) CvVideoCamera* videoCamera;
@property (nonatomic, strong) CALayer *featureLayer;

@end

@implementation FARootViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.faceDetector = [[FAFaceDetector alloc] init];
    self.faceRecognizer = [[FAFaceRecognizer alloc] initWithEigenFaceRecognizer];
    
    [self setupCamera];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setupCamera
{
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:self.imageView];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = kCaptureFPS;
    self.videoCamera.grayscaleMode = NO;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // We support only Portrait.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"People"])
    {
        UINavigationController *navController = segue.destinationViewController;
        FAPeopleViewController *peopleController = navController.viewControllers.firstObject;
        peopleController.delegate = self;
    }
}

- (void)highlightFace:(CGRect)faceRect withColor:(UIColor *)color
{
    if (self.featureLayer == nil) {
        self.featureLayer = [[CALayer alloc] init];
        self.featureLayer.borderWidth = 4.0;
    }
    
    [self.imageView.layer addSublayer:self.featureLayer];
    
    self.featureLayer.hidden = NO;
    self.featureLayer.borderColor = color.CGColor;
    self.featureLayer.frame = faceRect;
}

- (IBAction)switchCameraClicked:(id)sender {
    [self.videoCamera stop];
    
    if (self.videoCamera.defaultAVCaptureDevicePosition == AVCaptureDevicePositionFront) {
        self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    } else {
        self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    }
    
    [self.videoCamera start];
}

#pragma mark -
#pragma mark FAPeopleViewControllerDelegate

- (void)didDismissPeopleViewController:(FAPeopleViewController *)peopleController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
