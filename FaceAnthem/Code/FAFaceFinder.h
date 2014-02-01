//
//  FAFaceFinder.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 1/27/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class FAFaceFinder;

@protocol FAFaceFinderDelegate <NSObject>

- (void)faceFinder:(FAFaceFinder *)finder didFindFaces:(NSArray *)faces inRects:(NSArray *)rects;

@end

@interface FAFaceFinder : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>

- (id)initWithPreviewView:(UIView *)previewView;

- (void)captureImageWithCompletion:(void (^)(UIImage *))completion;

@property (nonatomic, weak) id<FAFaceFinderDelegate> delegate;
@property (nonatomic, readonly) CGRect previewRect;

@end
