//
//  FAFaceRecognizer.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 2/1/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAFaceRecognizer.h"
#import <opencv2/highgui/cap_ios.h>
#import "FAPicture.h"
#import "FAPerson.h"


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
    cv::Mat faceData = [[self class] cvMatFromUIImage:faceImage];
    
    // Pull the grayscale face ROI out of the captured image
    cv::Mat deColored;
    cv::cvtColor(faceData, deColored, CV_RGB2GRAY);
    
    // Standardize the face to 100x100 pixels
    cv::resize(deColored, deColored, cv::Size(100, 100), 0, 0);
    
    NSData *serialized = [[self class] serializeCvMat:deColored];
    
    FAPicture *pic = [FAPicture MR_createEntity];
    pic.imageData = UIImagePNGRepresentation(faceImage);
    pic.standardizedImageData = serialized;
    [person addPicturesObject:pic];
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
    [self trainModel];
}

- (void)trainModel
{
    std::vector<cv::Mat> images;
    std::vector<int> labels;
    
    NSArray *pictures = [FAPicture MR_findAll];
    
    for(FAPicture *picture in pictures)
    {
        cv::Mat faceData = [[self class] dataToMat:picture.standardizedImageData
                                           width:[NSNumber numberWithInt:100]
                                          height:[NSNumber numberWithInt:100]];
        
        images.push_back(faceData);
        labels.push_back(picture.person.recognitionIdentifierValue);
    }

    if (images.size() > 0 && labels.size() > 0) {
        _recognizerModel->train(images, labels);
    }
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

+ (NSData *)serializeCvMat:(cv::Mat&)cvMat
{
    return [[NSData alloc] initWithBytes:cvMat.data length:cvMat.elemSize() * cvMat.total()];
}

+ (cv::Mat)dataToMat:(NSData *)data width:(NSNumber *)width height:(NSNumber *)height
{
    cv::Mat output = cv::Mat([width integerValue], [height integerValue], CV_8UC1);
    output.data = (unsigned char*)data.bytes;
    
    return output;
}

@end
