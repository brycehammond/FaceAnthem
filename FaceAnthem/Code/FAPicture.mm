#import "FAPicture.h"
#import "FAOpenCVData.h"

@interface FAPicture ()

// Private interface goes here.

@end


@implementation FAPicture


- (void)setImage:(UIImage *)image
{
    self.imageData = UIImagePNGRepresentation(image);
}

- (UIImage *)image
{
    if(nil == self.imageData)
        return nil;

    return [UIImage imageWithData:self.imageData];
}

- (void)setStandardizedImage:(cv::Mat)standardizedImage
{
    self.standardizedImageData = [FAOpenCVData serializeCvMat:standardizedImage];
}

- (cv::Mat)standardizedImage
{
    
    return [FAOpenCVData dataToMat:self.standardizedImageData width:@100 height:@100];
}


@end
