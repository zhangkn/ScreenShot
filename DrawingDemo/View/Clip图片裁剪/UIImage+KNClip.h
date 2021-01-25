//
//  UIImage+KNClip.h
//  DrawingDemo
//
//  Created by mac on 2021/1/25.
//  Copyright © 2021 https://kunnan.blog.csdn.net  . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KNClip)
/**
 裁剪
 imgw： 图片宽， 此方法会根据imgw安装图片的原来宽高比进行缩放，计算对应的高

 */
+ (UIImage *)imageWithName:(NSString *)name border:(CGFloat)border borderColor:(UIColor *)borderColor imgw:(CGFloat)imgw;


/**
 
 获取带有水印的图片
 imgName: 图片名称
 watermark： 水印内容
 
 watermarkColor： 水印颜色
 
 imgw： 图片宽， 此方法会根据imgw安装图片的原来宽高比进行缩放，计算对应的高
 
 */

+ (UIImage*)getWatermarkImaheWithImgaeName:(NSString*)imgName withWatermark:(NSString*)watermark watermarkColor:(UIColor*)watermarkColor imgw:(CGFloat)imgw;
@end


NS_ASSUME_NONNULL_END
