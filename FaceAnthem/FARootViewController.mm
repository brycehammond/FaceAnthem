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
#import "FAOpenCVData.h"
#import "FAPerson.h"
#import <QuartzCore/QuartzCore.h>

@interface FARootViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) FAFaceDetector *faceDetector;
@property (nonatomic, strong) FAFaceRecognizer *faceRecognizer;
@property (nonatomic, strong) CvVideoCamera* videoCamera;
@property (nonatomic, strong) CALayer *featureLayer;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *confidenceLabel;

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.faceRecognizer trainModel];
    [self.videoCamera start];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.videoCamera stop];
}

- (void)processImage:(cv::Mat&)image
{
    [self parseFaces:[self.faceDetector facesFromImage:image] forImage:image];
}

- (void)parseFaces:(const std::vector<cv::Rect> &)faces forImage:(cv::Mat&)image
{
    if(faces.size() <= 0)
        return;
    
    // We only care about the first face
    cv::Rect face = faces[0];
    
    // By default highlight the face in red, no match found
    UIColor *highlightColor = [UIColor redColor];
    NSManagedObjectID *matchId = nil;
    CGFloat confidence = 0.0f;
    
    FAPerson *match = [self.faceRecognizer recognizedFace:face inImage:image];
    if(nil != match)
    {
        // Match found
        highlightColor = [UIColor greenColor];
        matchId = match.objectID; //pass the object id across the threads as NSManagedObjects aren't threadsafe
        confidence = match.recognitionConfidence;
    }
    
    // All changes to the UI have to happen on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        [self highlightFace:[FAOpenCVData faceToCGRect:face] withColor:highlightColor andPersonObjectId:matchId withConfidence:confidence];
    });
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

- (void)highlightFace:(CGRect)faceRect withColor:(UIColor *)color andPersonObjectId:matchId withConfidence:(CGFloat)confidence
{
    if (self.featureLayer == nil) {
        self.featureLayer = [[CALayer alloc] init];
        self.featureLayer.borderWidth = 4.0;
    }
    
    [self.imageView.layer addSublayer:self.featureLayer];
    
    self.featureLayer.hidden = NO;
    self.featureLayer.borderColor = color.CGColor;
    self.featureLayer.frame = faceRect;
    
    if(matchId)
    {
        FAPerson *person = (FAPerson *)[[NSManagedObjectContext MR_contextForCurrentThread] objectWithID:matchId];
        self.nameLabel.text = person.name;
        self.confidenceLabel.text = [NSString stringWithFormat:@"%0.6f",confidence];
    }
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
