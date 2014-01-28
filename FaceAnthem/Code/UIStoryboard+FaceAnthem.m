//
//  UIStoryboard+FaceAnthem.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 1/27/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "UIStoryboard+FaceAnthem.h"

@implementation UIStoryboard (FaceAnthem)

+ (UIStoryboard *)mainStoryboard
{
    NSString *type = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? @"iPhone" : @"iPad";
    return [UIStoryboard storyboardWithName:[NSString stringWithFormat:@"Main_%@",type] bundle:nil];
}

@end
