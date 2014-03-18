//
//  FAFaceRecognizer.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 2/1/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <opencv2/highgui/cap_ios.h>

@class FAPerson;

@interface FAFaceRecognizer : NSObject

@property (nonatomic, assign) BOOL trained;

+ (FAFaceRecognizer *)sharedRecognizer;

- (id)initWithEigenFaceRecognizer;
- (id)initWithFisherFaceRecognizer;
- (id)initWithLBPHFaceRecognizer;
- (void)trainModel;
- (void)trainFace:(cv::Rect)face forPerson:(FAPerson *)person fromImage:(cv::Mat&)image;
- (FAPerson *)recognizedFace:(cv::Rect)face inImage:(cv::Mat&)image;


@end
