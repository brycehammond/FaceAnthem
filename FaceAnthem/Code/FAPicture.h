#import "_FAPicture.h"

@interface FAPicture : _FAPicture {}

@property (nonatomic, assign) UIImage *image;
@property (nonatomic, assign) cv::Mat standardizedImage;

@end
