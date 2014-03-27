//
//  FAPersonBaseViewController.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/15/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAPersonBaseViewController.h"
#import "FAPicture.h"
#import "FAOpenCVData.h"
#import "FAImageCollectionViewCell.h"

@interface FAPersonBaseViewController ()

@end

@implementation FAPersonBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
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
    //turn the photos into FAPictures
    for(UIImage *photo in photos)
    {
        FAPicture *picture = [FAPicture MR_createEntity];
        picture.image = photo;
        
        cv::Mat faceImage = [FAOpenCVData cvMatFromUIImage:photo];
        
        // Standardize the face to 100x100 pixels
        cv::resize(faceImage, faceImage, cv::Size(100, 100), 0, 0);
        
        picture.standardizedImage = faceImage;
        [self.personPictures addObject:picture];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.picturesCollectionView reloadData];
}

#pragma mark -
#pragma mark UICollectionViewDelegate/Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.personPictures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FAImageCollectionViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    photoCell.delegate = self;
    
    [photoCell setImage:[self.personPictures[indexPath.row] image]];
    
    
    return photoCell;
}


#pragma mark -
#pragma mark FAImageCollectionViewCellDelegate

- (void)didPressDeleteOnImageCollectionViewCell:(FAImageCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.picturesCollectionView indexPathForCell:cell];
    FAPicture *pictureToDelete = self.personPictures[indexPath.row];
    [pictureToDelete MR_deleteEntity];
    [self.personPictures removeObjectAtIndex:indexPath.row];
    [self.picturesCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
}


@end
