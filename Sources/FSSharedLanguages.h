//
//  SharedLanguages.h
//  FlyShow
//
//  Created by gaochao on 15/2/3.
//  Copyright (c) 2015年 高超. All rights reserved.
//

#import <Foundation/Foundation.h>
//      创建的语言表的名称
#define keyLanguageTable @"Ready_Lanaguge"

@interface FSSharedLanguages : NSObject
/***
 * default Ready_Lanaguge set once only
 */
@property(nonatomic,strong)NSString *tableName;
// 语言
@property(nonatomic,strong)NSString *language;
// 跟随系统
@property(nonatomic,assign)BOOL followSystem;
+(instancetype)SharedLanguage;
// 获得换回的字符串
+ (NSString *)CustomLocalizedStringWithKey:(NSString *)key;

// 取指定语言下的文案。
+ (NSString *)CustomLocalizedStringWithKey:(NSString *)key LanguageType:(NSString *)language;

@end

FOUNDATION_EXPORT NSString * FSSharedLanaguageTypeChinese;
FOUNDATION_EXPORT NSString * FSSharedLanaguageTypeEnglish;
FOUNDATION_EXPORT NSString * FSSharedLanaguageTypeMalay;
FOUNDATION_EXPORT NSString * FSSharedLanaguageTypeVietnamese;
FOUNDATION_EXPORT NSString * FSSharedLanaguageTypeIndonesian;
FOUNDATION_EXPORT NSString * FSSharedLanaguageTypeThai;
FOUNDATION_EXPORT NSString * FSSharedLanaguageTypeTamil;
FOUNDATION_EXPORT NSString * FSSharedLanaguageTypeTelugu;
FOUNDATION_EXPORT NSString * FSSharedLanaguageTypeBangla;
FOUNDATION_EXPORT NSString * FSSharedLanaguageTypeHindi;
FOUNDATION_EXPORT NSString * FSSharedLanaguageTypeArabic;
FOUNDATION_EXPORT NSString * FSSharedLanaguageTypeTurkey;
FOUNDATION_EXPORT NSString * FSSharedLanaguageTypeGerman;

