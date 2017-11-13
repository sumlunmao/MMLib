//
//  CommonFunction.h
//  Mo9Client
//
//  Created by ChenJian on 15/6/3.
//  Copyright (c) 2015年 mo9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonFunction : NSObject

#pragma mark ---- 圆圈角度相关 ----

/**
 *  根据圆心的坐标点、半径、当前手势所在的坐标点，计算出圆的运动轨迹坐标
 *  @param radius 圆心半径
 *  @param centerCircle 圆心的坐标点
 *  @param currentPoint 当前的手势所在的坐标点
 *  @return CGPoint 返回圆的坐标
 */
+(CGPoint)CirclePoint:(CGFloat)radius withCenterCircle:(CGPoint)centerCircle withCurrentPoint:(CGPoint)currentPoint;

/**
 *  根据圆心的坐标点、半径、角度，计算出圆的运动轨迹坐标
 *  @param radius 圆心半径
 *  @param centerCircle 圆心的坐标点
 *  @param angle 当前角度
 *  @return CGPoint 返回圆的坐标
 */
+(CGPoint)CirclePoint:(CGFloat)radius withCenterCircle:(CGPoint)centerCircle withCircleAngle:(CGFloat)angle;

+(CGFloat)angleBetweenPoints:(CGPoint)first :(CGPoint)second;

+(CGFloat)angleBetweenLines:(CGPoint)line1Start :(CGPoint)line1End :(CGPoint)line2Start :(CGPoint)line2End;

#pragma mark ---- Json转换 ----
+ (id)jsonDicWithString:(NSString *)string;

+ (NSString *)jsonStringWithObject:(id)object;

+ (NSString *)jsonStringWithoutSpaceWithObject:(id)dict;


#pragma mark ---- 日期相关 ----

+(NSString *)currentDateStr;

+(NSString *)currentDayStr;

+(NSString *)timeStamp;

+(NSString *)standardTimeStamp;

+(NSDateComponents *)dateComponents;

+(NSDate *)dateFromString:(NSString *)dateStr;

+(NSString *)date;

// 计算时间差
+(BOOL)sessionidInvalid:(NSString *)date;

#pragma mark ---- 设备信息 ----
+(NSString *)deviceInfo;

+(NSString *)UID;
// cpu类型
+(NSString *)CPUType;
// CPU核数
+(NSString *)CUPNumber;
// 磁盘总量
+(NSString *)diskSize;
// 总内存
+(NSString *)totalMemory;
// 运营商名称
+(NSString *)carrierOperator;
// 运营商国家码
+(NSString *)carrierMobileCountryCode;
// 系统语言
+(NSString*)preferredLanguage;
//  设备类型
+(NSString *)deviceType;
// 设备型号
+(NSString *)deviceModel;
// 国家
+(NSString *)country;
// 系统版本
+(NSString *)osVersion;
// 系统时区
+(NSString *)timezone;
// ip地址
+(NSString *)ipAddress;
// 分辨率
+(CGSize)screenScale;
// wifi名称
+(NSString *)wifiName;
// wifi MAc地址
+(NSString *)wifiMacAddress;
#pragma mark ---- 图片相关 ----
+(UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;
//根据图片高宽算出高宽比
+(CGFloat)imageScaleMetaDataString:(NSString *)metaDataString;
//根据宽高转换成jsonstring;
+(NSString *)imageScaleStringSize:(CGSize)size;

#pragma mark ---- 时间转换相关 ----
// 根据时间戳显示时间
+(NSString *)timeShowFromTimestamp:(NSNumber *)timestamp;
// 根据时间戳转换成时间
+(NSString *)timeStringFromTimeStamp:(NSNumber *)timestamp;
// 根据时间转换成时间戳
+(NSString *)timeStampWithShortStr:(NSString *)shortTime;
// 根据时间转换星座
+(NSString *)caculateHoroscopeMonth:(NSString *)m day:(NSString *)d;


#pragma mark ---- 类型转换 ---
+(NSString *)convertStringWithDic:(NSDictionary *)dic;

#pragma mark ---- 金额相关 ----
+ (NSString*)formatMoneyStr:(NSNumber*)money withSign:(BOOL)sign;

+ (NSNumber*)formatMoneyNumber:(NSNumber*)money;

+ (NSString*)formatMobiToRmbStr:(NSNumber*)mobi;

+ (NSNumber*)formatMobiToRmb:(NSNumber*)mobi;

+ (NSDate*)numberToDate:(NSNumber*)number;

+ (NSNumber*)formatMoneyStr:(NSString*)money;

+ (UIResponder *)getSupperVCWithCurrentView:(UIView*)view vcName:(NSString *)vcName;


#pragma mark ----
+ (Class)classWithName:(NSString *)name; //兼容获取 oc class 和 swift class
@end
