//
//  FAFaceRecognizer.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 2/1/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAFaceRecognizer.h"
#import "FAPicture.h"
#import "FAPerson.h"
#import "FAOpenCVData.h"

@interface FAFaceRecognizer ()
{
    cv::Ptr<cv::FaceRecognizer> _recognizerModel;
}

@end

@implementation FAFaceRecognizer

static FAFaceRecognizer *singleton;

+ (FAFaceRecognizer *)sharedRecognizer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[FAFaceRecognizer alloc] initWithEigenFaceRecognizer];
    });
    
    return singleton;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.trained = NO;
    }
    
    return self;
}

- (id)initWithEigenFaceRecognizer
{
    self = [self init];
    _recognizerModel = cv::createEigenFaceRecognizer();
    
    return self;
}

- (id)initWithFisherFaceRecognizer
{
    self = [self init];
    _recognizerModel = cv::createFisherFaceRecognizer();
    
    return self;
}

- (id)initWithLBPHFaceRecognizer
{
    self = [self init];
    _recognizerModel = cv::createLBPHFaceRecognizer();
    
    return self;
}

- (cv::Mat)pullStandardizedFace:(cv::Rect)face fromImage:(cv::Mat&)image
{
    // Pull the grayscale face ROI out of the captured image
    cv::Mat onlyTheFace;
    cv::cvtColor(image(face), onlyTheFace, CV_RGB2GRAY);
    
    // Standardize the face to 100x100 pixels
    cv::resize(onlyTheFace, onlyTheFace, cv::Size(100, 100), 0, 0);
    
    return onlyTheFace;
}

- (void)trainFace:(cv::Rect)face forPerson:(FAPerson *)person fromImage:(cv::Mat&)image;
{
    cv::Mat faceData = [self pullStandardizedFace:face fromImage:image];
    NSData *serialized = [FAOpenCVData serializeCvMat:faceData];
    
    FAPicture *pic = [FAPicture MR_createEntity];
    //pic.imageData = UIImagePNGRepresentation(faceImage);
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
        cv::Mat faceData = [FAOpenCVData dataToMat:picture.standardizedImageData
                                           width:@100
                                          height:@100];
        
        images.push_back(faceData);
        labels.push_back(picture.person.recognitionIdentifierValue);
    }

    if (images.size() > 0 && labels.size() > 0)
    {
        _recognizerModel->train(images, labels);
        self.trained = YES;
    }
    else
    {
        self.trained = NO;
    }
}

- (FAPerson *)recognizedFace:(cv::Rect)face inImage:(cv::Mat&)image
{
    if(NO == self.trained)
        return nil;
    
    int predictedLabel = -1;
    double confidence = 0.0;
    _recognizerModel->predict([self pullStandardizedFace:face fromImage:image], predictedLabel, confidence);
    
    if(-1 != predictedLabel)
    {
        FAPerson *recognizedPerson = [FAPerson MR_findFirstByAttribute:@"recognitionIdentifier" withValue:@(predictedLabel)];
        recognizedPerson.recognitionConfidence = confidence;
        return recognizedPerson;
    }
    else
    {
        return nil;
    }
}

@end
