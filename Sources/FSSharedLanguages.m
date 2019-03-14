//
//  SharedLanguages.m
//  FlyShow
//
//  Created by gaochao on 15/2/3.
//  Copyright (c) 2015年 高超. All rights reserved.
//

#import "FSSharedLanguages.h"
#define keyAppLanguage @"appLanguage"
#define keyAppLanguageAuto @"keyAppLanguageAuto"

#define keyAppLanguageFollowSystemDefault YES


#define keyAppDefaultLanguage @"en" //用来屏蔽没有的语言
#define keyAppFirstLanguage @"en"   //跟随系统的第一语言

NSString * FSSharedLanaguageTypeChinese = @"zh-Hans";
NSString * FSSharedLanaguageTypeEnglish = @"en";
NSString * FSSharedLanaguageTypeMalay = @"ms";
NSString * FSSharedLanaguageTypeVietnamese = @"vi";
NSString * FSSharedLanaguageTypeIndonesian = @"id";
NSString * FSSharedLanaguageTypeThai = @"th";

NSString * FSSharedLanaguageTypeTamil = @"ta";
NSString * FSSharedLanaguageTypeTelugu = @"te";
NSString * FSSharedLanaguageTypeBangla = @"bn";
NSString * FSSharedLanaguageTypeHindi = @"hi";


NSString * FSSharedLanaguageTypeArabic = @"ar";
NSString * FSSharedLanaguageTypeTurkey = @"tr";
NSString * FSSharedLanaguageTypeGerman = @"de";

static FSSharedLanguages *staticLanguage;
@interface FSSharedLanguages()
{
    NSString *_language;
    BOOL _followSystem;
    BOOL _inited;
}
@end
@implementation FSSharedLanguages
@synthesize tableName = _tableName;

+(instancetype)SharedLanguage
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        staticLanguage = [[FSSharedLanguages alloc] init];
    });
    return staticLanguage;
}
- (instancetype)init
{
    if (self = [super init]) {
        
        // 不跟随系统
        _followSystem = [self followSystem]; // yes 跟随  no 不跟随
        _language = [[NSUserDefaults standardUserDefaults] valueForKey:keyAppLanguage];
        
        if (_language.length == 0) {// 没有设置过系统语言
            _language =  keyAppDefaultLanguage;//[[NSLocale preferredLanguages] objectAtIndex:0];
            if([_language isEqualToString:FSSharedLanaguageTypeChinese])
            {
                _language = keyAppDefaultLanguage;
            }
        }
        [[NSUserDefaults standardUserDefaults] setValue:_language forKey:keyAppLanguage];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return self;
}
- (void)resetLanguage
{
    if(!self.followSystem)
    {
        [[NSUserDefaults standardUserDefaults] setValue:_language forKey:keyAppLanguage];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSString *)language
{
    if (_inited) {
        return _language;
    }

    if(self.followSystem)
    {
        NSArray *perferredArray = [NSLocale preferredLanguages];
        if (perferredArray) {
            _language = [perferredArray firstObject];
        }else{
            _language = keyAppDefaultLanguage;
        }
        
        if ([_language isEqualToString:FSSharedLanaguageTypeChinese]) {
            _language = keyAppDefaultLanguage;
        }
        
        // 屏蔽系统语言
//        _language = keyAppFirstLanguage;
    }else
    {
        NSString *currentLanage = [[NSUserDefaults standardUserDefaults]  valueForKey:keyAppLanguage];
        _language = currentLanage;
        
        if (_language.length == 0) {// 没有设置过
            _language = keyAppDefaultLanguage;//[[NSLocale preferredLanguages] objectAtIndex:0];
            if ([_language isEqualToString:FSSharedLanaguageTypeChinese]) {
                _language = keyAppDefaultLanguage;
            }
        }
    }
    
    if ([_language hasPrefix:FSSharedLanaguageTypeThai]){
        _language = FSSharedLanaguageTypeThai;
    }else if ([_language hasPrefix:FSSharedLanaguageTypeIndonesian]){
        _language = FSSharedLanaguageTypeIndonesian;
    }else if ([_language hasPrefix:FSSharedLanaguageTypeMalay]){
        _language = FSSharedLanaguageTypeMalay;
    }else if ([_language hasPrefix:FSSharedLanaguageTypeVietnamese]){
        _language = FSSharedLanaguageTypeVietnamese;
    }else if ([_language hasPrefix:FSSharedLanaguageTypeTamil]){
        _language = FSSharedLanaguageTypeTamil;
    }else if ([_language hasPrefix:FSSharedLanaguageTypeTelugu]){
        _language = FSSharedLanaguageTypeTelugu;
    }else if ([_language hasPrefix:FSSharedLanaguageTypeBangla]){
        _language = FSSharedLanaguageTypeBangla;
    }else if ([_language hasPrefix:FSSharedLanaguageTypeHindi]){
        _language = FSSharedLanaguageTypeHindi;
    }else if ([_language hasPrefix:FSSharedLanaguageTypeArabic]){
        _language = FSSharedLanaguageTypeArabic;
    }else if ([_language hasPrefix:FSSharedLanaguageTypeTurkey]){
        _language = FSSharedLanaguageTypeTurkey;
    }else{
        _language = FSSharedLanaguageTypeEnglish;
    }
    
    _inited = YES;
    
    return _language;
}
- (void)setLanguage:(NSString *)language //手动设置语种 不跟随系统
{
    // 不跟随系统的
    [self setFollowSystem:NO];

    // 设置语言  当前设置和别的不同就重新设置
    if (_language != language) {
        
        _language = language;
        [self resetLanguage];
    }
}
-(void)setFollowSystem:(BOOL)followSystem //设置跟随服务器
{
    _followSystem = followSystem;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:followSystem] forKey:keyAppLanguageAuto];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)followSystem
{
    NSNumber *followSystem = [[NSUserDefaults standardUserDefaults] valueForKey:keyAppLanguageAuto];
    if (followSystem == nil) {
        //
        return keyAppLanguageFollowSystemDefault;
    }
    return [followSystem boolValue];
}
- (NSString *)CustomLocalizedStringFromTable:(NSString *)key Comment:(NSString *)comment Table:(NSString *)table
{
    
    NSString *RecoursePath;
    if (!self.followSystem) {//不跟随系统
        RecoursePath = [[NSUserDefaults standardUserDefaults] valueForKey:keyAppLanguage];
    }else //跟随系统
    {
        RecoursePath = [[NSLocale preferredLanguages] objectAtIndex:0];
        // 中文开始
        if ([RecoursePath hasPrefix:@"zh"] ) {
            RecoursePath = keyAppDefaultLanguage;
        }
    }
    // 兼容 iOS 9.0
    if ([RecoursePath hasPrefix:FSSharedLanaguageTypeVietnamese]) {
        RecoursePath = FSSharedLanaguageTypeVietnamese;
    }else if ([RecoursePath hasPrefix:FSSharedLanaguageTypeThai]) {
        RecoursePath = FSSharedLanaguageTypeThai;
    }else if ([RecoursePath hasPrefix:FSSharedLanaguageTypeMalay]) {
        RecoursePath = FSSharedLanaguageTypeMalay;
    }else if ([RecoursePath hasPrefix:FSSharedLanaguageTypeIndonesian]) {
        RecoursePath = FSSharedLanaguageTypeIndonesian;
    }else if ([RecoursePath hasPrefix:FSSharedLanaguageTypeHindi]) {
        RecoursePath = FSSharedLanaguageTypeHindi;
    }else if ([RecoursePath hasPrefix:FSSharedLanaguageTypeBangla]) {
        RecoursePath = FSSharedLanaguageTypeBangla;
    }else if ([RecoursePath hasPrefix:FSSharedLanaguageTypeTamil]) {
        RecoursePath = FSSharedLanaguageTypeTamil;
    }else if ([RecoursePath hasPrefix:FSSharedLanaguageTypeTelugu]) {
        RecoursePath = FSSharedLanaguageTypeTelugu;
    }else if ([_language hasPrefix:FSSharedLanaguageTypeArabic]){
        RecoursePath = FSSharedLanaguageTypeArabic;
    }else if ([_language hasPrefix:FSSharedLanaguageTypeTurkey]){
        RecoursePath = FSSharedLanaguageTypeTurkey;
    }else{
        RecoursePath = FSSharedLanaguageTypeEnglish;
    }
    /*
     else if ([RecoursePath rangeOfString:@"ar"].location != NSNotFound) {
     RecoursePath = @"ar";
     }else if ([RecoursePath rangeOfString:@"tr"].location != NSNotFound) {
     RecoursePath = @"tr";
     }else if ([RecoursePath rangeOfString:@"zh-hans"].location != NSNotFound){
        RecoursePath = @"zh-hans";
     }
     */
    
    return [self localizeStringWithResourceName:RecoursePath withKey:key table:table];
}

- (NSString *)localizeStringWithResourceName:(NSString *)RecoursePath withKey:(NSString *)key table:(NSString *)table{
    NSString *PathString = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",RecoursePath] ofType:@"lproj"];
    
    if (PathString.length == 0) { //没有这种语言 默认取系统偏好
        
        NSString *perferredLanguage =  keyAppDefaultLanguage; //[[NSLocale preferredLanguages] objectAtIndex:0];
        if ([perferredLanguage isEqualToString:@"zh-Hans"]) {
            perferredLanguage = keyAppDefaultLanguage;
        }
        PathString = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",perferredLanguage] ofType:@"lproj"];
    }
    NSBundle * currentBundle = [NSBundle bundleWithPath:PathString];
    NSString * LoaclizedString = [currentBundle localizedStringForKey:key value:nil table:table];
    
    return LoaclizedString;
}
- (NSString *)tableName {
    if (!_tableName) {
        _tableName = keyLanguageTable;
    }
    return _tableName;
}
- (void)setTableName:(NSString *)tableName {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self->_tableName = tableName;
    });
}

+ (NSString *)CustomLocalizedStringWithKey:(NSString *)key
{
    return  [[FSSharedLanguages SharedLanguage] CustomLocalizedStringFromTable:key Comment:nil Table:[FSSharedLanguages SharedLanguage].tableName];
}
+ (NSString *)CustomLocalizedStringWithKey:(NSString *)key LanguageType:(NSString *)language {
    
    return  [[FSSharedLanguages SharedLanguage] localizeStringWithResourceName:language withKey:key table:[FSSharedLanguages SharedLanguage].tableName];
}
@end
