//
//  FAPersonBaseViewController.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/15/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAPersonBaseViewController.h"

@interface FAPersonBaseViewController ()

@end

@implementation FAPersonBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupController
{
    self.personPictures = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[FAAddPhotosViewController class]])
    {
        [(FAAddPhotosViewController *)segue.destinationViewController setDelegate:self];
    }
}


#pragma mark -
#pragma mark FAAddPhotosViewControllerDelegate

- (void)didDismissAddPhotosViewController:(FAAddPhotosViewController *)controller withPhotos:(NSArray *)photos
{
    [self.personPictures addObjectsFromArray:photos];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
