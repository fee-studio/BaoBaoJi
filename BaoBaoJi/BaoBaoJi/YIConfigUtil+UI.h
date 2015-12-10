//
//  YIConfigUtil+UI.h
//  Dobby
//
//  Created by efeng on 15/6/23.
//  Copyright (c) 2015年 weiboyi. All rights reserved.
//
//  整个应用界面上皮肤显示效果的常量定义

#import "YIConfigUtil.h"

// 1,应用中固定的名字


// 2,应用中的图片 前缀s (skin)


// 2,应用中UI的配色
#define kAppMainColor   ([UIColor  colorWithHexString:@"ff9900"])
#define kAppDeepColor   ([UIColor  colorWithHexString:@"5f6877"])
#define kAppLightColor   ([UIColor  colorWithHexString:@"999999"])
#define kAppGreyColor   ([UIColor  colorWithHexString:@"cccccc"])
#define kAppBlueColor   ([UIColor  colorWithHexString:@"4169E1"])
#define kAppGreenColor   ([UIColor  colorWithHexString:@"7dc308"])

#define kAppMainColorH  ([UIColor  colorWithHexString:@"ff9911"])
#define kAppBgColor     ([UIColor  colorWithHexString:@"e6e3e1"])
#define kAppLineColor   ([UIColor  colorWithHexString:@"b7b7b7"])
#define kListBlackColor ([UIColor  colorWithHexString:@"2e2e2e"])
#define kListBlackColorH ([UIColor colorWithHexString:@"262626"])
#define kAppWhiteColor  ([UIColor  whiteColor])
#define kTvBgColor      ([UIColor gr])

// 3,应用中常用的字体大小

#define kAppBigFont         ([UIFont systemFontOfSize:17])
#define kAppMidFont         ([UIFont systemFontOfSize:15])
#define kAppSmlFont         ([UIFont systemFontOfSize:13])
// 旧的
#define kAppBig2Font        ([UIFont systemFontOfSize:15])
#define kAppMid2Font        ([UIFont systemFontOfSize:13])
#define kAppSml2Font        ([UIFont systemFontOfSize:11])
#define kAppMacro2Font      ([UIFont systemFontOfSize:10])
#define kAppBoldMid2Font    ([UIFont boldSystemFontOfSize:13])
#define kAppBoldSml2Font    ([UIFont boldSystemFontOfSize:11])

// 4,应用中常用的坐标
#define kFreshOrderCellHeight 370.f
#define kAllOrderCellHeight 163.f

// 5,应用中的一些提示语
#define kMessageServerDown     @"服务器正在维护中！请稍候再试 ..."
#define kMessageServerOK       @"连接服务器成功~"
#define kMessageNetworkAnomaly @"请检查您的网络连接是否正常。"
#define kMessageNetworkOther   @"网络其他问题 ..."
//#define kMessageNoOrders       @"暂没有任务，请休息一会吧~"
#define kMessageNoCacheData    @"无缓存数据"

// 操作浮动栏坐标
#define kFloatViewHeight 55.f
#define kFvBtnHeight 40.f
#define kFvBtnWidth 130.f
#define kFvSmlBtnWidth 100.f
#define kFvBtnSpace 10.f
#define kFloatViewHeight4Manual 100.f


#define kAppPlaceHolderImage ([UIImage imageNamed:@"placeholder"])


@interface YIConfigUtil (UI)

+ (NSString *)priceStringWithSign:(NSString *)priceValue;

@end
