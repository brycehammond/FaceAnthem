//
//  FAFaceDetector.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/16/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <opencv2/highgui/cap_ios.h>

@interface FAFaceDetector : NSObject

- (std::vector<cv::Rect>)facesFromImage:(cv::Mat&)image;

@end
