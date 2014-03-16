//
//  FAFaceRecognizer.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 2/1/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FAPerson;

@interface FAFaceRecognizer : NSObject

- (void)trainFaceImage:(UIImage *)faceImage forPerson:(FAPerson *)person;
- (FAPerson *)recognizedPersonForImage:(UIImage *)faceImage;
- (void)retrainModel;
+ (cv::Mat)cvMatFromUIImage:(UIImage *)image;
+ (cv::Mat)cvMatFromUIImage:(UIImage *)image usingColorSpace:(int)outputSpace;

@end
