//
//  UIViewController+YingYingImagePickerController.h
//  Yingying
//
//  Created by 林伟池 on 16/1/3.
//  Copyright © 2016年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYRACDefine.h"


#define NOTIFY_UI_IMAGE_PICKER_DONE     @"NOTIFY_UI_IMAGE_PICKER_DONE"


/**
 *  选择照片，选择后马上回调。注意此时原viewController还没显示。
 *  同时为了兼容老的版本，使用ActionSheet，同时实现了代理，会和原controller冲突。
 */
@interface UIViewController (YingYingImagePickerController) <UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate>
//@property (nonatomic , strong) UIImage* myPickImage;

- (void)lyModalChoosePicker;

@end
