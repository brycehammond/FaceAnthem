//
//  FAFaceRecognizer.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 2/1/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAFaceRecognizer.h"
#import <opencv2/highgui/cap_ios.h>


@interface FAFaceRecognizer ()
{
    cv::Ptr<cv::FaceRecognizer> _recognizerModel;
}

@end

@implementation FAFaceRecognizer

- (id)init
{
    self = [super init];
    if(self)
    {
        _recognizerModel = cv::createFisherFaceRecognizer();
    }
    return self;
    
}

- (void)trainFaceImage:(UIImage *)faceImage forPerson:(FAPerson *)person
{
    
}

- (void)trainModel
{
    
}

- (FAPerson *)recognizedPersonForImage:(UIImage *)faceImage
{
    return nil;
}

+ (cv::Mat)cvMatFromUIImage:(UIImage *)image
{
    return [[self class] cvMatFromUIImage:image usingColorSpace:CV_RGB2GRAY];
}

+ (cv::Mat)cvMatFromUIImage:(UIImage *)image usingColorSpace:(int)outputSpace
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4);
    
    CGContextRef contextRef = CGBitmapContextCreate(
                                                    cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast|kCGBitmapByteOrderDefault // Bitmap info flags
                                                    );
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    cv::Mat finalOutput;
    cvtColor(cvMat, finalOutput, outputSpace);
    
    return finalOutput;
}

@end
