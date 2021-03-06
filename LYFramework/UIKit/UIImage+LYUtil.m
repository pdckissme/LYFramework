//
//  UIImage+LYUtil.m
//  LYFrameworkDemo
//
//  Created by 林伟池 on 16/7/12.
//  Copyright © 2016年 林伟池. All rights reserved.
//

#import "UIImage+LYUtil.h"

@implementation UIImage (LYUtil)

+ (UIImage *)lyImageWithCaptureView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)lyImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark -

- (UIImage *)lyChangeSizeWithMaxSize:(CGSize)maxSize {
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize targetSize = sourceImage.size;
    if (maxSize.height <= 0 || maxSize.width <= 0) {
        return nil;
    }
    while (targetSize.width > maxSize.width || targetSize.height > maxSize.width) {
        targetSize.width = targetSize.width / 1.1;
        targetSize.height = targetSize.height / 1.1;
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    [sourceImage drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) {
        newImage = sourceImage;
        NSLog(@"LY could not scale image. Check size");
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIImage *)lyImageRotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)lyHorizontalFlip {
    UIGraphicsBeginImageContext(self.size);
    CGContextRef current_context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(current_context, self.size.width, 0);
    CGContextScaleCTM(current_context, -1.0, 1.0);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *flipped_img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return flipped_img;
}

- (UIImage *)lyVerticalFlip {
    UIGraphicsBeginImageContext(self.size);
    CGContextRef current_context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(current_context, 0, self.size.height);
    CGContextScaleCTM(current_context, 1.0, -1.0);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *flipped_img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return flipped_img;
}


@end
