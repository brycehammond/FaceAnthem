//
//  FAAddPhotosViewController.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/2/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAAddPhotosViewController.h"

@interface FAAddPhotosViewController ()

@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UIImageView *lastImageView;

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, strong) NSArray *faces;
@property (nonatomic, strong) NSArray *faceRects;
@property (nonatomic, strong) UIImage *currentCaptureImage;
@property (nonatomic, strong) FAFaceFinder *faceFinder;

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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.faceFinder = [[FAFaceFinder alloc] initWithPreviewView:self.previewView];
    self.faceFinder.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.faceFinder.delegate = nil;
    self.faceFinder = nil; //stop the face finder if offscreen
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
    //get the face from the current capture image add add it to our list
    UIImage *faceImage = self.faces.firstObject;
    if(nil != faceImage)
    {
        self.lastImageView.image = faceImage;
        [self.photos addObject:faceImage];
    }
    
    
}

#pragma mark -
#pragma mark FAFaceFinderDelegate

- (void)faceFinder:(FAFaceFinder *)finder didFindFaceImages:(NSArray *)faces inRects:(NSArray *)rects forImage:(UIImage *)image
{
    self.faces = faces;
    self.faceRects = rects;
    self.currentCaptureImage = image;
    
}

@end
