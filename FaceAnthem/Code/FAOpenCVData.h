//
//  FAOpenCVData.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/17/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <opencv2/highgui/cap_ios.h>

@interface FAOpenCVData : NSObject

+ (NSData *)serializeCvMat:(cv::Mat&)cvMat;
+ (cv::Mat)dataToMat:(NSData *)data width:(NSNumber *)width height:(NSNumber *)height;
+ (CGRect)faceToCGRect:(cv::Rect)face;
+ (UIImage *)UIImageFromMat:(cv::Mat)image;
+ (cv::Mat)cvMatFromUIImage:(UIImage *)image;
+ (cv::Mat)cvMatFromUIImage:(UIImage *)image usingColorSpace:(int)outputSpace;

@end
