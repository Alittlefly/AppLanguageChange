# AppLanguageChange

-

### How to use?
	pod 'LanguageChange'
	

### Demo Code

- 设置table,table只能设置一次

```OC
	//   tableName "LanguageChange"
	[[FSSharedLanguages SharedLanguage] setTableName:@"LanguageChange"];
```

- 读取文字

```OC
	NSString *value = [FSSharedLanguages CustomLocalizedStringWithKey:@"key"];
```

### 其他方法
- followSystem

YES: 跟随系统当前的语言
NO：自己设定

### 读取特定的语言的value

```
    NSLog(@"%@",[FSSharedLanguages CustomLocalizedStringWithKey:@"keyaaa" LanaguageType:FSSharedLanaguageTypeChinese]);
```