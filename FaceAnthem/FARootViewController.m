//
//  IMViewController.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 1/27/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FARootViewController.h"


@interface FARootViewController ()

@property (nonatomic, strong) NSArray *faces;
@property (nonatomic, strong) NSArray *faceRects;
@property (nonatomic, strong) FAFaceFinder *faceFinder;

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
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // We support only Portrait.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)faceFinder:(FAFaceFinder *)finder didFindFaces:(NSArray *)faces inRects:(NSArray *)rects
{
    self.faces = faces;
    self.faceRects = rects;
}


@end
