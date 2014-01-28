//
//  FAFaceAssignmentViewController.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 1/27/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAFaceAssignmentViewController.h"

@interface FAFaceAssignmentViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

@end

@implementation FAFaceAssignmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.previewImageView.frameSize = self.previewImage.size;
    [self.previewImageView centerHorizontallyInSuperviewWithYOrigin:self.previewImageView.frameYOrigin];
	self.previewImageView.image = self.previewImage;
}

- (IBAction)donePressed:(id)sender
{
    [self.delegate didDismissFaceAssignmentController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
