//
//  CommonFunction.m
//  Mo9Client
//
//  Created by ChenJian on 15/6/3.
//  Copyright (c) 2015年 mo9. All rights reserved.
//

#import "CommonFunction.h"
#import "sys/utsname.h"
#include <mach/mach_host.h>
#include <sys/sysctl.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>

#import "Mo9Contants.h"

@implementation CommonFunction

#pragma mark ---- 圆圈角度相关 ----

+(CGPoint)CirclePoint:(CGFloat)radius withCenterCircle:(CGPoint)centerCircle withCurrentPoint:(CGPoint)currentPoint
{
    CGPoint cPoint;
    CGFloat x = currentPoint.x;
    CGFloat y = currentPoint.y;
    CGFloat cX ; //圆的X坐标轨迹
    CGFloat cY ; //圆的Y坐标轨迹
    CGFloat daX; // 圆心到转动按钮的距离的平方
    //CGFloat daY;
    CGFloat aX;  // 圆心到转动按钮的距离
    //CGFloat aY;
    CGFloat cosX;  // 圆心水平方向与转动按钮形成的夹角的cos值
    
    //圆心与触控点的距离的平方（勾股定理）
    daX =  (x - centerCircle.x)*(x - centerCircle.x) + (y - centerCircle.y)*(y - centerCircle.y);
    aX = sqrt(daX); //开根号  //圆心与触控点的距离
    cosX =  fabs(x - centerCircle.x)/aX;  //绝对值
    cX = cosX*radius ; //  x =R * cosX;  圆心到触控点在水平坐标的X的值
    cY = sqrt(radius*radius - cX*cX);
    
    if(x<centerCircle.x) //如果X所在的点小于圆心 在圆心的左边
    {
        cX = centerCircle.x - cX;
    }
    else
    {
        cX = centerCircle.x + cX;
    }
    
    if(y<centerCircle.y)
    {
        cY = centerCircle.y - cY;
    }
    else
    {
        cY = centerCircle.y + cY;
    }
    cPoint.x = cX;
    cPoint.y = cY;
    return cPoint;
}

+(CGPoint)CirclePoint:(CGFloat)radius withCenterCircle:(CGPoint)centerCircle withCircleAngle:(CGFloat)angle {
    CGFloat x;
    CGFloat y;
    
    x = centerCircle.x + (radius * cos((90+angle)*M_PI/180));
    y = centerCircle.y - (radius * sin((90+angle)*M_PI/180)) ;
    
    return CGPointMake(x, y);
}

#define degreesToRadian(x) (M_PI * x / 180.0)
#define radiansToDegrees(x) (180.0 * x / M_PI)
CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
};

+(CGFloat)angleBetweenPoints:(CGPoint)first :(CGPoint)second {
    CGFloat height = second.y - first.y;
    CGFloat width = first.x - second.x;
    CGFloat rads = atan(height/width);
    return radiansToDegrees(rads);
}

+(CGFloat)angleBetweenLines:(CGPoint)line1Start :(CGPoint)line1End :(CGPoint)line2Start :(CGPoint)line2End {
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    if (line2Start.x>=line1Start.x) {
        return 364 - radiansToDegrees(rads);
    }else {
        return radiansToDegrees(rads);
    }
}

#pragma mark ---- Json转换 ----

+ (id)jsonDicWithString:(NSString *)string {
    string = [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
}

+ (NSString *)jsonStringWithObject:(id)object {
    NSString *json = @"";
    if ([NSJSONSerialization isValidJSONObject:object]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
        json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        Log(@"parse error:%@",error);
    }
    return json;
}

+ (NSString *)jsonStringWithoutSpaceWithObject:(id)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    NSString *jsonString = @"";
    if (!jsonData) {
        Log(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
//    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
//    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return jsonString;
}


#pragma mark ---- 日期相关 ----

+ (NSString *)currentDateStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

+ (NSString *)currentDayStr {
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    // 设置日期格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

+ (NSString *)timeStamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

+ (NSString *)standardTimeStamp {
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]*1000];
    return timeSp;
}


+(NSDateComponents *)dateComponents {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    return comps;
}

+(NSDate *)dateFromString:(NSString *)dateStr {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate* inputDate = [inputFormatter dateFromString:dateStr];
    return inputDate;
}

+(NSString *)date {
    NSDate *date = [NSDate date];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    return [formater stringFromDate:date];
}

+(BOOL)sessionidInvalid:(NSString *)date {
    if (date.length == 0) {
        return YES;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *lastDate = [formatter dateFromString:date];
    NSDate *nowDate = [NSDate date];
    NSTimeInterval aTimer = [nowDate timeIntervalSinceDate:lastDate];
    int minute = (int) aTimer / 60;
    if (minute > 20) {
        return YES;
    }
    return NO;
}

#pragma mark ---- 设备信息 ----

+ (NSString *)deviceInfo {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceInfo = [NSString
                            stringWithCString:systemInfo.machine
                            encoding:NSUTF8StringEncoding];
    return deviceInfo;
}

+(NSString *)UID {
    //获取设备id号
    UIDevice *device = [UIDevice currentDevice];
    //创建设备对象
    NSString *deviceUID = [[NSString alloc] initWithString:[device identifierForVendor].UUIDString];
    Log(@"%@",deviceUID);
    
    return [deviceUID stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+(NSString *)CPUType {
    NSString *typeStr;
    host_basic_info_data_t hostInfo;
    mach_msg_type_number_t infoCount;
    
    infoCount = HOST_BASIC_INFO_COUNT;
    host_info(mach_host_self(),HOST_BASIC_INFO,(host_info_t)&hostInfo,&infoCount);
    switch (hostInfo.cpu_type) {
        case CPU_TYPE_ARM:
            typeStr =@"ARM";
            break;
        case CPU_TYPE_ARM64:
            typeStr = @"ARM64";
            break;
        case CPU_TYPE_X86:
            typeStr = @"X86";
            break;
        case CPU_TYPE_X86_64:
            typeStr = @"X86_64";
            break;
        default:
            typeStr = @"";
            break;
    }
    return typeStr;
}
+(NSString *)CUPNumber {
    unsigned int ncpu;
    size_t len = sizeof(ncpu);
    sysctlbyname("hw.ncpu", &ncpu, &len, NULL, 0);
    return [NSString stringWithFormat:@"%i", ncpu];
}
+(NSString *)diskSize {
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSString *diskTotalSize = [systemAttributes objectForKey:@"NSFileSystemSize"];
    return [NSString stringWithFormat:@"%.2f",[diskTotalSize floatValue]/1024/1024/1024];
}
+(NSString *)totalMemory {
    size_t size = sizeof(int);
    int results; 
    int mib[2] = {CTL_HW,HW_PHYSMEM};
    sysctl(mib, 2, &results, &size, NULL, 0);
    NSUInteger re = (NSUInteger)results/1024/1024;
    return [NSString stringWithFormat:@"%zd",re];
}
+(NSString *)carrierOperator {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    id type;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarServiceItemView")]) {
            type = [child valueForKeyPath:@"serviceString"];
            Log(@"carrier is %@", type);
            break;
        }
    }
    return [NSString stringWithFormat:@"%@",type?:@""];
}
+ (NSString *)carrierMobileCountryCode {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    NSString *mcc = [carrier mobileCountryCode];
    NSString *mnc = [carrier mobileNetworkCode];
    NSString *countryCode = [carrier isoCountryCode];
    NSString *imsi = [NSString stringWithFormat:@"%@,%@,%@", mcc?:@"", mnc?:@"",countryCode?:@""];
    
    return imsi;
}
+(NSString *)country {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *country = [locale localeIdentifier];
    return country?:@"";
}
+(NSString *)deviceType {
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *model = [currentDevice model];
    return model?:@"";
}
+(NSString *)deviceModel {
    return @"";
}
+(NSString *)osVersion {
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *systemVersion = [currentDevice systemVersion];
    return systemVersion?:@"";
}
+ (NSString*)preferredLanguage {
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    Log(@"Preferred Language:%@", preferredLang);
    return preferredLang?:@"";
//    NSArray *languageArray = [NSLocale preferredLanguages];
//    NSString *language = [languageArray objectAtIndex:0];
}
+(NSString *)timezone {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    return zone.name?:@"";
}
+(NSString *)ipAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address?:@"";
}

+(CGSize)screenScale {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize size = CGSizeMake(kWinSize.width*scale, kWinSize.height*scale);
    return size;
}

// wifi名称
+(NSString *)wifiName {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    Log(@"interfaces:%@",ifs);
    NSDictionary *info = nil;
    NSString *wifiName;
    for (NSString *ifname in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifname);
        wifiName = info[@"SSID"];
        Log(@"%@ => %@",ifname,info);
    }
    return wifiName?:@"null";
}
// wifi mac 地址
+(NSString *)wifiMacAddress {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    Log(@"interfaces:%@",ifs);
    NSDictionary *info = nil;
    NSString * wifiIpAddress;
    for (NSString *ifname in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifname);
        wifiIpAddress = info[@"BSSID"];
        Log(@"%@ => %@",ifname,info);
    }
    return wifiIpAddress?:@"null";
}
#pragma mark ---- 图片相关 ----

/**
 *  剪切图片为正方形
 *
 *  @param image   原始图片比如size大小为(400x200)pixels
 *  @param newSize 正方形的size比如400pixels
 *
 *  @return 返回正方形图片(400x400)pixels
 */
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize {
    CGAffineTransform scaleTransform;
    CGPoint origin;
    
    if (image.size.width > image.size.height) {
        //image原始高度为200，缩放image的高度为400pixels，所以缩放比率为2
        CGFloat scaleRatio = newSize / image.size.height;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        //设置绘制原始图片的画笔坐标为CGPoint(-100, 0)pixels
        origin = CGPointMake(-(image.size.width - image.size.height) / 2.0f, 0);
    } else {
        CGFloat scaleRatio = newSize / image.size.width;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        
        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0f);
    }
    
    CGSize size = CGSizeMake(newSize, newSize);
    //创建画板为(400x400)pixels
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将image原始图片(400x200)pixels缩放为(800x400)pixels
    CGContextConcatCTM(context, scaleTransform);
    //origin也会从原始(-100, 0)缩放到(-200, 0)
    [image drawAtPoint:origin];
    
    //获取缩放后剪切的image图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


+ (CGFloat)imageScaleMetaDataString:(NSString *)metaDataString {
    CGFloat scale = 1;
    if (metaDataString.length > 0) {
        NSDictionary *dic = [self jsonDicWithString:metaDataString];
        if (dic) {
            NSNumber *height = dic[@"height"];
            NSNumber *width = dic[@"width"];
            if (height&&width) {
                 scale = [height floatValue]/[width floatValue];
            }
        }
    }
    return scale;
}

+ (NSString *)imageScaleStringSize:(CGSize)size{
    NSString *scaleString = @"";
    if (size.height>0&&size.width>0) {
        NSDictionary *dic = @{@"height":@(size.height),
                              @"width":@(size.width)};
        scaleString = [CommonFunction jsonStringWithObject:dic];
    }
    return scaleString;
}

#pragma mark ---- 时间转换相关 ----

+(NSString *)timeShowFromTimestamp:(NSNumber *)timestamp {
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate *date =[NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/1000];
    NSString *dateStr = [formatter stringFromDate:date];
    NSTimeInterval time2 =[date timeIntervalSinceNow];
    int min=((int)time2)/60 * -1;
    NSString *result = @"";
    if (min == 0 ) { // 小于一分钟
        return @"刚刚";
    } else if (min < 60) { // 小于60分钟
        result = [NSString stringWithFormat:@"%i分钟",min];
    } else if (min < 60 * 24) { // 小于24小时
        result = [NSString stringWithFormat:@"%i小时",min/60];
    } else if (min < 60 * 72) { // 小于72小时
        result = [NSString stringWithFormat:@"%i天",min/(60 * 24)];
    } else {
        NSMutableString *str = [NSMutableString stringWithString:dateStr];
        NSArray *arr = [str componentsSeparatedByString:@" "];
        NSString *year = [arr[0] componentsSeparatedByString:@"-"][0];
        
        NSString *nowTime = [formatter stringFromDate:[NSDate date]];
        NSArray *nowArr = [nowTime componentsSeparatedByString:@"-"];
        NSString *nowYear = nowArr[0];
        if ([year integerValue] == [nowYear integerValue]){ // 一年内
            result  = [arr[0] substringFromIndex:5];
        } else {
            result = arr[0];
        }
    }
  
    return result;
}

+(NSString *)timeStringFromTimeStamp:(NSNumber *)timestamp {
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *timeStr = [dateFormatter stringFromDate:time];
    return [timeStr substringToIndex:11]; // 具体时间不返回
}

+(NSString *)timeStampWithShortStr:(NSString *)shortTime {
    if (shortTime.length < 20) {
      shortTime = [shortTime stringByAppendingString:@" 00:00:00"];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:shortTime];
    return [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970] * 1000];
}

+(NSString *)caculateHoroscopeMonth:(NSString *)m day:(NSString *)d {
    NSInteger month = [m integerValue];
    NSInteger day = [d integerValue];
    if (month < 1 || month > 12 || day > 31) {
        return @"";
    }
    if(month==2 && day>29)
    {
        return @"错误日期格式!!";
    }
    if(month==4 || month==6 || month==9 || month==11) {
        if (day>30) {
            return @"错误日期格式!!!";
        }
    }
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    return [NSString stringWithFormat:@"%@座",result];
}

#pragma mark ---- 类型转换 ---
+(NSString *)convertStringWithDic:(NSDictionary *)dic {
    NSArray* sortedKeyArray = [[dic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }]; 
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (NSString* key in sortedKeyArray) {
        
        NSString* orderItem = [NSString stringWithFormat:@"%@=%@",key,[dic objectForKey:key]?:@""];
        [tmpArray addObject:orderItem];
    }
    return [tmpArray componentsJoinedByString:@"&"];
}

#pragma mark ---- 金额相关 ----
+ (NSDate*)numberToDate:(NSNumber *)number {
    long long value = [number longLongValue]/1000;//number是NSNumber型
    NSNumber *time = [NSNumber numberWithLongLong:value];
    //转换成NSTimeInterval
    NSTimeInterval nsTimeInterval = [time longValue];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:nsTimeInterval];
    return date;
}

+ (NSString*)formatMoney:(NSNumber*)money {
    if(money == nil)
        return nil;
    NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
    f.minimumIntegerDigits = 1;
    f.maximumFractionDigits = f.minimumFractionDigits = 2;
    
    return [f stringFromNumber:money];
}

+ (NSNumberFormatter*)moneyFormat:(NSNumber*)money withSign:(BOOL)sign {
    if(money == nil)
        return nil;
    NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
    f.minimumIntegerDigits = 1;
    f.maximumFractionDigits = f.minimumFractionDigits = 2;
    
    if(sign)
        f.negativePrefix = @"-";
    else
        f.negativePrefix = @"";
    return f;
}

+ (NSString*)formatMoneyStr:(NSNumber*)money withSign:(BOOL)sign {
    NSNumberFormatter* f = [CommonFunction moneyFormat:money withSign:sign];
    return [f stringFromNumber:money];
}

+ (NSNumber*)formatMoneyNumber:(NSNumber *)money {
    NSString* s = [CommonFunction formatMoneyStr:money withSign:YES];
    
    NSNumberFormatter* f = [CommonFunction moneyFormat:money withSign:YES];
    
    return [f numberFromString:s];
}

+ (NSString*)formatMobiToRmbStr:(NSNumber *)mobi{
    return [CommonFunction formatMoneyStr:@([mobi doubleValue] / MobiExchangeRate) withSign:NO];
}

+ (NSNumber*)formatMobiToRmb:(NSNumber *)mobi{
    NSString* s = [CommonFunction formatMobiToRmbStr:mobi];
    
    NSNumberFormatter* f = [CommonFunction moneyFormat:mobi withSign:YES];
    
    return [f numberFromString:s];
}

+ (NSNumber*)formatMoneyStr:(NSString *)money {
    if([money length] == 0)
        return @0.0;
    NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
    f.minimumIntegerDigits = 1;
    f.maximumFractionDigits = f.minimumFractionDigits = 2;
    
    return [f numberFromString:money];
}

+(UIResponder *)getSupperVCWithCurrentView:(UIView*)view vcName:(NSString *)vcName {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:NSClassFromString(vcName)]) {
            return nextResponder;
        }
    }
    return nil;
}

+ (Class)classWithName:(NSString *)name {
    Class class = NSClassFromString(name);
    if (class == nil) { //swift class
        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
        NSString *classStringName = [NSString stringWithFormat:@"_TtC%zd%@%zd%@", appName.length, appName, name.length, name];
        class = NSClassFromString(classStringName);
    }
    return class;
}

@end
