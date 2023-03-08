# crash_category
avoid app crash
一句代码调用防止常见的app崩溃

// 防止unrecognizer selector崩溃

[NSObject CC_enableSelectorProtector];

//防止数组和字典崩溃

[NSArray becomeActive];

[NSDictionary becomeActive];

[NSMutableArray becomeActive];

[NSMutableDictionary becomeActive];
