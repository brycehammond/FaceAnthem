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

@property (nonatomic, strong) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
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
        [self highlightFace:[FAOpenCVData faceToCGRect:face] withColor:highlightColor andPersonObjectId:nil withConfidence:0];
    });
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
    if(self.hasFaces && _currentImage.data != NULL)
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
