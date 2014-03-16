//
//  IMViewController.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 1/27/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FARootViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FARootViewController ()

@property (nonatomic, strong) NSArray *faces;
@property (nonatomic, strong) NSArray *faceRects;
@property (nonatomic, strong) FAFaceFinder *faceFinder;
@property (nonatomic, strong) UIImage *currentCaptureImage;

@end

@implementation FARootViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.faceFinder = [[FAFaceFinder alloc] initWithPreviewView:self.previewView];
    self.faceFinder.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.faceFinder.delegate = nil;
    self.faceFinder = nil; //stop the face finder if offscreen
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // We support only Portrait.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark FAFaceFinderDelegate

- (void)faceFinder:(FAFaceFinder *)finder didFindFaces:(NSArray *)faces inRects:(NSArray *)rects forImage:(UIImage *)image
{
    self.faces = faces;
    self.faceRects = rects;
    self.currentCaptureImage = image;
}

#pragma mark -
#pragma mark Tap Handling

- (UIImage *)faceAtIndex:(NSUInteger)index
{
    CGFloat scale = self.currentCaptureImage.scale;
    CGRect faceRect = CGRectOffset([self.faceRects[index] CGRectValue], 0, -self.faceFinder.previewRect.origin.y);
    faceRect = CGRectMake(faceRect.origin.x * scale, faceRect.origin.y * scale, faceRect.size.width * scale, faceRect.size.height * scale);
    
    //Flip the co-ordinates of the rect if we are mirrored
    if(self.currentCaptureImage.imageOrientation == UIImageOrientationUpMirrored)
    {
        faceRect = CGRectMake((self.currentCaptureImage.size.width * scale) - faceRect.origin.x - faceRect.size.width, faceRect.origin.y, faceRect.size.width, faceRect.size.height);
    }
    
	/// Create the cropped image
	CGImageRef croppedImageRef = CGImageCreateWithImageInRect(self.currentCaptureImage.CGImage, faceRect);
	UIImage* cropped = [UIImage imageWithCGImage:croppedImageRef scale:scale orientation:self.currentCaptureImage.imageOrientation ];
    
	/// Cleanup
	CGImageRelease(croppedImageRef);
    return cropped;
    
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

#pragma mark -
#pragma mark FAPeopleViewControllerDelegate

- (void)didDismissPeopleViewController:(FAPeopleViewController *)peopleController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
