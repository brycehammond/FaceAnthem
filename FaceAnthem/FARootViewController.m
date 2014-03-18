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

#pragma mark -
#pragma mark FAPeopleViewControllerDelegate

- (void)didDismissPeopleViewController:(FAPeopleViewController *)peopleController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
