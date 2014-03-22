//
//  FAAddPhotosViewController.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/2/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAAddPhotosViewController.h"
#import "FAOpenCVData.h"
#import "FAFaceDetector.h"
#import "FAFaceRecognizer.h"

@interface FAAddPhotosViewController ()
{
    cv::Mat _currentImage;
    cv::Rect _currentFace;
}

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIButton *cameraButton;
@property (strong, nonatomic) IBOutlet UIButton *switchCameraButton;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property (nonatomic, strong) FAFaceDetector *faceDetector;
@property (nonatomic, strong) CvVideoCamera* videoCamera;
@property (nonatomic, strong) CALayer *featureLayer;
@property (nonatomic, assign) BOOL hasFaces;

@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation FAAddPhotosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupController];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupController];
}

- (void)setupController
{
    self.photos = [[NSMutableArray alloc] init];
    self.hasFaces = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.faceDetector = [[FAFaceDetector alloc] init];
    
    [self setupCamera];
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
    {
        self.hasFaces = NO;
        return;
    }
    else
    {
        self.hasFaces = YES;
    }
        ;
    
    // We only care about the first face
    cv::Rect face = faces[0];
    _currentFace = face;
    _currentImage = image;
    
    // By default highlight the face in red
    UIColor *highlightColor = [UIColor redColor];
    
    // All changes to the UI have to happen on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        [self highlightFace:[FAOpenCVData faceToCGRect:face] withColor:highlightColor];
    });
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender
{
    [self.delegate didDismissAddPhotosViewController:self withPhotos:self.photos];
}

- (IBAction)takePicture:(id)sender
{
    if(self.hasFaces)
    {
        CGRect faceRect = [FAOpenCVData faceToCGRect:_currentFace];
        UIImage *fullImage = [FAOpenCVData UIImageFromMat:_currentImage];
        
        //get the subimage
        CGImageRef imageRef = CGImageCreateWithImageInRect([fullImage CGImage], faceRect);
        UIImage *faceImage = [UIImage imageWithCGImage:imageRef];
        [self.photos addObject:faceImage];
        CGImageRelease(imageRef);
        
        self.previewImageView.image = faceImage;
        
    }
}

@end
