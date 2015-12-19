//
//  wiNSString+MD5HexDigest.h
//  wiIos
//
//  Created by qq on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>

@interface NSString (Category)

//+ (NSString *)getOpenUDID;

// 删除空白字符
+ (NSString *)stringTrim:(NSString *)str;
+ (NSString *)stringTrimEnd:(NSString *)str;
+ (NSString *)stringTrimStart:(NSString *)str;
/**
 *  删除首尾和中间的空白字符 by HQF
 */
+ (NSString *)stringTrimAllSpace:(NSString *)trimmingStr;
- (NSString *)trimAllSpace;


- (NSString *)trim;
- (NSString *)trimSpace;

- (BOOL)containString:(NSString *)string;

// 添加随机数
+ (NSString *)string:(NSString *)str appendRandom:(NSUInteger)ram;
+ (NSString *)string:(NSString *)str appendRandom:(NSUInteger)ram startFrom:(NSUInteger)start;

+ (NSString *)subStringByCount:(NSString *)string withCount:(NSInteger)count;

// MD5
- (NSString *)md5HexDigest32;
- (NSString *)md5HexDigest16;

/**
 *  Create a SHA1 string from self
 *
 *  @return Return the SHA1 NSString from self
 */
- (NSString *)SHA1;

/**
 *  Create a SHA256 string from self
 *
 *  @return Return the SHA256 NSString from self
 */
- (NSString *)SHA256;

/**
 *  Create a SHA512 string from self
 *
 *  @return Return the SHA512 NSString from self
 */
- (NSString *)SHA512;

// 获取文件名
- (NSString *)getFileName;
// 获取路径
- (NSString *)getFilePath;

// 从bit转化为KB、MB、GB
+ (NSString *)storeString:(NSInteger)bsize;
+ (NSString *)countString:(NSUInteger)count;

// 判断Email
- (BOOL)isEmail;
// 校验用户密码  
- (BOOL)isUserPasswd;
// 校验验证码  
- (BOOL)isVerifyCode;
// 校验手机号
- (BOOL)isPhoneNum;
// 校验身份证号码
- (BOOL)isIDCardNum;

// 得到一个后四位显示的字符串(比如银行卡号)
- (NSString *)getBack4VisibleStr;
- (NSString *)makeHidePhoneNum;

// 一个汉字当两个字符 长度的计算
- (NSInteger)lengthByUnicode;

// key为24位 kCCKeySize3DES
// 编码
+ (NSString *)encodeDES:(NSString*)plainText key:(NSString*)key;
// 解码
+ (NSString *)decodeDES:(NSString*)plainText key:(NSString*)key;


// 判断是否为整形
- (BOOL)isPureInt;
// 判断是否为浮点形
- (BOOL)isPureFloat;

// 转换16进制字符串为10进制数字
+ (NSUInteger)intFromHexStr:(NSString *)hexString;
- (NSUInteger)hexStrToInt;

+ (NSUInteger)intFromStr:(NSString *)string withBase:(NSInteger)base;

// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString;
// 普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string;
// 十进制转换成16进制
+ (NSString *)ToHex:(long long int)tmpid;

- (NSString *)escapeHTML;

- (NSString *)getPinIn;

@end


#pragma mark - Size

@interface NSString (Size)

/**
 Returns the size of the string if it were rendered with the specified constraints.
 
 @param font          The font to use for computing the string size.
 
 @param size          The maximum acceptable size for the string. This value is
 used to calculate where line breaks and wrapping would occur.
 
 @param lineBreakMode The line break options for computing the size of the string.
 For a list of possible values, see NSLineBreakMode.
 
 @return              The width and height of the resulting string's bounding box.
 These values may be rounded up to the nearest whole number.
 */
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/**
 Returns the width of the string if it were to be rendered with the specified
 font on a single line.
 
 @param font  The font to use for computing the string width.
 
 @return      The width of the resulting string's bounding box. These values may be
 rounded up to the nearest whole number.
 */
- (CGFloat)widthForFont:(UIFont *)font;

/**
 Returns the height of the string if it were rendered with the specified constraints.
 
 @param font   The font to use for computing the string size.
 
 @param width  The maximum acceptable width for the string. This value is used
 to calculate where line breaks and wrapping would occur.
 
 @return       The height of the resulting string's bounding box. These values
 may be rounded up to the nearest whole number.
 */
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;


- (CGSize)sizeToFitWidth:(CGFloat)width withFont:(UIFont *)font;
- (CGSize)sizeToFitHeight:(CGFloat)height withFont:(UIFont *)font;
- (CGSize)sizeToFit:(CGSize)maxSize withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end


#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

@interface NSString (HASH)

/**
 Returns a lowercase NSString for md2 hash.
 */
- (NSString *)md2String;

/**
 Returns a lowercase NSString for md4 hash.
 */
- (NSString *)md4String;

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)md5String;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (NSString *)sha1String;

/**
 Returns a lowercase NSString for sha224 hash.
 */
- (NSString *)sha224String;

/**
 Returns a lowercase NSString for sha256 hash.
 */
- (NSString *)sha256String;

/**
 Returns a lowercase NSString for sha384 hash.
 */
- (NSString *)sha384String;

/**
 Returns a lowercase NSString for sha512 hash.
 */
- (NSString *)sha512String;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key The hmac key.
 */
- (NSString *)hmacMD5StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key The hmac key.
 */
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha224 with key.
 @param key The hmac key.
 */
- (NSString *)hmacSHA224StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha256 with key.
 @param key The hmac key.
 */
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha384 with key.
 @param key The hmac key.
 */
- (NSString *)hmacSHA384StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha512 with key.
 @param key The hmac key.
 */
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for crc32 hash.
 */
- (NSString *)crc32String;

/**
 Returns an NSString for base64 encoded.
 */
- (NSString *)base64EncodedString;

/**
 Returns an NSString from base64 encoded string.
 @param base64Encoding The encoded string.
 */
+ (NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString;

@end

/**
 A collection of useful additions for `NSString` to deal with paths.
 */

@interface NSString (paths)

/**-------------------------------------------------------------------------------------
 @name Getting Standard Paths
 ---------------------------------------------------------------------------------------
 */

/** Determines the path to the Library/Caches folder in the current application's sandbox.
 
 The return value is cached on the first call.
 
 @return The path to the app's Caches folder.
 */
+ (NSString *)cachesPath;


/** Determines the path to the Documents folder in the current application's sandbox.
 
 The return value is cached on the first call.
 
 @return The path to the app's Documents folder.
 */
+ (NSString *)documentsPath;

+ (NSString *)libraryPath;
+ (NSString *)bundlePath;

/**-------------------------------------------------------------------------------------
 @name Getting Temporary Paths
 ---------------------------------------------------------------------------------------
 */

/** Determines the path for temporary files in the current application's sandbox.
 
 The return value is cached on the first call. This value is different in Simulator than on the actual device. In Simulator you get a reference to /tmp wheras on iOS devices it is a special folder inside the application folder.
 
 @return The path to the app's folder for temporary files.
 */
+ (NSString *)temporaryPath;


/** Creates a unique filename that can be used for one temporary file or folder.
 
 The returned string is different on every call. It is created by combining the result from temporaryPath with a unique UUID.
 
 @return The generated temporary path.
 */
+ (NSString *)pathForTemporaryFile;


/**-------------------------------------------------------------------------------------
 @name Working with Paths
 ---------------------------------------------------------------------------------------
 */
/*!
 Path extension with . or "" as before.
 
 "spliff.tiff" => ".tiff"
 "spliff" => ""
 
 @result Full path extension with .
 */
- (NSString *) getFullFileExtension;

/** Appends or Increments a sequence number in brackets
 
 If the receiver already has a number suffix then it is incremented. If not then (1) is added.
 
 @return The incremented path
 */
- (NSString *)pathByIncrementingSequenceNumber;


/** Removes a sequence number in brackets
 
 If the receiver number suffix then it is removed. If not the receiver is returned.
 
 @return The modified path
 */
- (NSString *)pathByDeletingSequenceNumber;

@end

#pragma mark - Emoji
///=============================================================================
/// @name Emoji
///=============================================================================
@interface NSString (Emoji)

/**
 Whether the receiver contains Apple Emoji (displayed in current version of iOS).
 */
- (BOOL)containsEmoji;

- (BOOL)containsEmojiForSystemVersion:(float)systemVersion;


@end

