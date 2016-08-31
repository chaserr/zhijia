//
//  QBAlbumsViewController.h
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/03.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBViewController.h"

@class QBImagePickerController;
@interface QBAlbumsViewController : GBViewController

@property (nonatomic, weak) QBImagePickerController *imagePickerController;

@end
