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
@property (nonatomic, assign) NSUInteger tappedFaceIndex;

@end

@implementation FARootViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    self.faceFinder = [[FAFaceFinder alloc] initWithPreviewView:self.previewView];
    self.faceFinder.delegate = self;
    [self.previewView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewTapped:)]];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tappedFaceIndex = NSNotFound;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // We support only Portrait.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark FAFaceFinderDelegate

- (void)faceFinder:(FAFaceFinder *)finder didFindFaces:(NSArray *)faces inRects:(NSArray *)rects
{
    self.faces = faces;
    self.faceRects = rects;
}

#pragma mark -
#pragma mark FAFaceAssignmentViewControllerDelegate

- (void)didDismissFaceAssignmentController:(FAFaceAssignmentViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Tap Handling
- (void)previewTapped:(UITapGestureRecognizer *)gesture
{
    CGPoint tapPoint = [gesture locationInView:self.previewView];
    //see if the tapPoint was on a face
    self.tappedFaceIndex = NSNotFound;
    for(NSUInteger faceIndex = 0; faceIndex < self.faceRects.count; ++faceIndex)
    {
        if(CGRectContainsPoint([self.faceRects[faceIndex] CGRectValue], tapPoint))
        {
            //face rect contains tap point
            self.tappedFaceIndex = faceIndex;
            break;
        }
    }
    
    if(NSNotFound != self.tappedFaceIndex)
    {
        [self presentFaceAssignment];
    }
}

- (void)presentFaceAssignment
{
    
    [self.faceFinder captureImageWithCompletion:^(UIImage *image) {
        FAFaceAssignmentViewController *assignmentController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"FaceAssignment"];
        assignmentController.delegate = self;
        assignmentController.previewImage = image;
        [self presentViewController:assignmentController animated:YES completion:nil];
    }];
    
    
}

- (UIImage *)currentSelectedFace
{
    if(NSNotFound == self.tappedFaceIndex)
        return nil;
    
    return [self imageForFaceAtIndex:self.tappedFaceIndex];
}

- (UIImage *)imageForFaceAtIndex:(NSUInteger)faceIndex
{
    CGRect faceRect = [self.faceRects[faceIndex] CGRectValue];
    
    
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
