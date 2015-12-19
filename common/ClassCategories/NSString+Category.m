//
//  wiNSString+MD5HexDigest.m
//  wiIos
//
//  Created by qq on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
#import "NSString+Category.h"
#import "NSObject+Category.h"
#import "UIDevice+Category.h"
#import "NSData+Category.h"

//#import "OpenUDID.h"


@implementation NSString (Category)

//+ (NSString *)getOpenUDID
//{
//    NSString *appUID = [OpenUDID value];
//    
//    return appUID;
//}

// 转换16进制字符串为10进制数字
+ (NSUInteger)intFromHexStr:(NSString *)hexString
{
    return strtoul([hexString UTF8String], 0, 16);
}

+ (NSUInteger)intFromStr:(NSString *)string withBase:(NSInteger)base
{
    return strtoul([string UTF8String], 0, (int)base);
}

// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString
{
    if (![hexString isNotEmpty])
    {
        return nil;
    }

    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2)
    {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }

    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@", unicodeString);

    free(myBuffer);

    return unicodeString;
}

+ (NSInteger)subStringLengthByCount:(NSString *)string withCount:(NSInteger)count
{
    if (string==nil) {
        return 0;
    }
    int i;
    int sum=0;
    int count2=0;
    for(i=0;i<[string length];i++)
    {
        unichar str = [string characterAtIndex:i];
        if(str < 256)
        {
            sum+=1;
        }else {
            sum+=2;
        }
        count2++;
        if (sum>=count){
            break;
        }
    }
    if(sum>count)
    {
        return count2-1;
    }else{
        return count2;
    }
}

+ (NSString *)subStringByCount:(NSString *)string withCount:(NSInteger)count
{
    if (string==nil) {
        return @"";
    }
    int i;
    int sum=0;
    for(i=0;i<[string length];i++)
    {
        unichar str = [string characterAtIndex:i];
        if(str < 256)
        {
            sum+=1;
        }else {
            sum+=2;
        }
        if(sum>count){
            NSString * str=[string substringWithRange:NSMakeRange(0,[self subStringLengthByCount:string withCount:count-3])];
            return [NSString stringWithFormat:@"%@...",str];
        }
    }
    return string;
}

// 普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string
{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];

    //下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for(int i=0; i<myD.length; i++)
    {
        // 16进制数
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i]&0xff];

        if(newHexStr.length == 1)
        {
            hexStr = [NSString stringWithFormat:@"%@0%@", hexStr, newHexStr];
        }
        else
        {
            hexStr = [NSString stringWithFormat:@"%@%@", hexStr, newHexStr];
        }
    }

    return hexStr; 
}

// 十进制转换成16进制
+ (NSString *)ToHex:(long long int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;  
        }  
        
    }  
    return str;
}

- (NSString *)md5HexDigest32
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);

    NSMutableString *hash = [NSMutableString string];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02x", result[i]];

    return hash;
}

- (NSString *)md5HexDigest16
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    for (NSInteger i = 4; i < 12; i++)
        [hash appendFormat:@"%02x", result[i]];
    
    return hash;
}

- (NSString *)SHA1
{
    if(self == nil || [self length] == 0)
        return nil;
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
    CC_SHA1([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_SHA1_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

- (NSString *)SHA256
{
    if(self == nil || [self length] == 0)
        return nil;
    
    unsigned char digest[CC_SHA256_DIGEST_LENGTH], i;
    CC_SHA256([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_SHA256_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

- (NSString *)SHA512
{
    if(self == nil || [self length] == 0)
        return nil;
    
    unsigned char digest[CC_SHA512_DIGEST_LENGTH], i;
    CC_SHA512([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_SHA512_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)getFileName
{
    NSString *fileName;
    NSArray *pathComponents = [self pathComponents];

    if (pathComponents.count > 0)
    {
        fileName = [NSString stringWithString:[pathComponents lastObject]];
    }
    else
    {
        return @"";
    }
    
    return fileName;
}

- (NSString *)getFilePath
{
    return [self stringByDeletingLastPathComponent];
}

+ (NSString *)storeString:(NSInteger)bsize
{
    if (bsize < 1024)
    {
        return [NSString stringWithFormat:@"%ldB", (long)bsize];
    }
    else if (bsize < 1024*1024)
    {
        CGFloat kbsize = (CGFloat)bsize / 1024;
        return [NSString stringWithFormat:@"%0.2fKB", kbsize];
    }
    else if (bsize < 1024*1024*1024)
    {
        CGFloat kbsize = (CGFloat)bsize / (1024*1024);
        return [NSString stringWithFormat:@"%0.2fM", kbsize];
    }
    else
    {
        CGFloat kbsize = (CGFloat)bsize / (1024*1024*1024);
        return [NSString stringWithFormat:@"%0.2fG", kbsize];
    }
}

+ (NSString *)countString:(NSUInteger)count
{
    if (count < 999)
    {
        return [NSString stringWithFormat:@"%ld", (long)count];
    }
    else if (count < 99000)
    {
        NSUInteger kcount = count / 1000;
        return [NSString stringWithFormat:@"%ldK", (long)kcount];
    }
    else
    {
        return @"99k+";
    }
}

- (NSString *)escapeHTML
{
    NSMutableString *result = [[NSMutableString alloc] initWithString:self];
    
    [result replaceOccurrencesOfString:@"&" withString:@"&amp;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"<" withString:@"&lt;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@">" withString:@"&gt;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"'" withString:@"&#39;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    return result;
}

// 校验邮箱格式  
- (BOOL)isEmail
{
    NSString *emailRegEx =  
	@"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"  
	@"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" 
	@"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"  
	@"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"  
	@"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"  
	@"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"  
	@"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    BOOL result;
	
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    result = [regExPredicate evaluateWithObject:[self lowercaseString]];
    
    return result;
}

// 校验用户密码  
- (BOOL)isUserPasswd
{
    NSString *patternStr = @"^[a-zA-Z0-9]{6,16}$";
    
    NSPredicate *strTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", patternStr];
    if ([strTest evaluateWithObject:self])
    {
        NSLog(@"%@ is Valid UserPasswd", self);
        return YES;
    }
    
    NSLog(@"%@ is inValid UserPasswd", self);  
    return NO;
}

// 校验手机号
- (BOOL)isPhoneNum
{
    if (![self isNotEmpty])
        return NO;
    
    if (self.length != 11)
        return NO;
    
    //NSString *num = @"^((147)|(177)|(13\\d{1})|(15\\d{1})|(18\\d{1}))\\d{8}$";
    NSString *num = @"^([1][3-9])\\d{9}$";    //@"^([1-9])\\d{10}$";
    
    NSPredicate *phoneNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
    if ([phoneNum evaluateWithObject:self])
    {
        NSLog(@"%@ is Valid mobil Number", self);  
        return YES;
    }

    NSLog(@"%@ is inValid mobil Number", self);  
    return NO;
}

// 校验身份证号码
- (BOOL)isIDCardNum
{
    // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
    if (![self isNotEmpty])
        return NO;
    
    if (self.length > 18)
        return NO;
    
    NSString *num = @"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    
    NSPredicate *iDCardNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
    if ([iDCardNum evaluateWithObject:self])
    {
        NSLog(@"%@ is Valid IDCard Number", self);
        return YES;
    }
    
    NSLog(@"%@ is inValid IDCard Number", self);
    return NO;
}

- (NSString *)getBack4VisibleStr
{
    NSMutableString *frontUnvisibleStr = [NSMutableString string];
    for (NSInteger index = 0; index < self.length; index++)
    {
        if (index != 0 && (index % 4) == 0 && index != self.length-1)
        {
            [frontUnvisibleStr appendString:@" "];
        }
        
        if (index >= self.length-4)
        {
            NSRange range = NSMakeRange(index, 1);
            [frontUnvisibleStr appendString:[self substringWithRange:range]];
        }
        else
        {
            [frontUnvisibleStr appendString:@"*"];
        }
    }
    
    return frontUnvisibleStr;
}

- (NSString *)makeHidePhoneNum
{
    NSMutableString *frontUnvisibleStr = [NSMutableString string];
    for (NSInteger index = 0; index < self.length; index++)
    {
        if (index >= self.length-4)
        {
            NSRange range = NSMakeRange(index, 1);
            [frontUnvisibleStr appendString:[self substringWithRange:range]];
        }
        else
        {
            [frontUnvisibleStr appendString:@"*"];
        }
    }
    
    return frontUnvisibleStr;
}


// 一个汉字当两个字符 长度的计算
- (NSInteger)lengthByUnicode
{
    NSInteger i,n=[self length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[self characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return a+b+2*l;
}

// 校验验证码  
- (BOOL)isVerifyCode
{
    NSString *patternStr = @"^[0-9]{4,8}$";
    
    NSPredicate *strTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", patternStr];
    if ([strTest evaluateWithObject:self])
    {
        NSLog(@"%@ is Valid VerifyCode", self);  
        return YES;
    }
    
    NSLog(@"%@ is inValid VerifyCode", self);
    return NO;
}

+ (NSString *)stringTrim:(NSString *)str
{
    NSString *string1;
    
    string1 = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return string1;
}

+ (NSString *)stringTrimEnd:(NSString *)str
{
    NSString *string1;
    
    string1 = [[@"a" stringByAppendingString:str] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [string1 substringFromIndex:1];
}

+ (NSString *)stringTrimStart:(NSString *)str
{
    NSString *string1;
    
    string1 = [[str stringByAppendingString:@"a"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [string1 substringToIndex:[string1 length]-1];
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (NSString *)stringTrimAllSpace:(NSString *)trimmingStr
{
    return [trimmingStr trimAllSpace];
}

- (NSString *)trimAllSpace
{
    NSString *resultStr;
    
    resultStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSArray *components = [resultStr componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ' '"]];
    resultStr = [components componentsJoinedByString:@""];
    
    return resultStr;
}

- (BOOL)containString:(NSString *)string
{
    return ([self rangeOfString:string].location == NSNotFound) ? NO : YES;
}

+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key
{
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    // uint8_t ivkCCBlockSize3DES;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    //    NSString *key = @"123456789012345678901234";
    NSString *initVec = @"init Vec";
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey, //"123456789012345678901234", //key
                       kCCKeySize3DES,
                       vinitVec, //"init Vec", //iv,
                       vplainText, //"Your Name", //plainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    if (kCCSuccess != ccStatus)
    {
        free(bufferPtr);
        return @"";
    }
    //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    /*else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; */
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                length:(NSUInteger)movedBytes]
                                        encoding:NSUTF8StringEncoding];
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    free(bufferPtr);
    return result;
}

// 编码
+ (NSString *)encodeDES:(NSString*)plainText key:(NSString*)key
{
    NSString* ret = [NSString TripleDES:plainText encryptOrDecrypt:kCCEncrypt key:key];        
    NSLog(@"3DES/Base64 Encode Result=%@", ret);
    
    return ret;
}

// 解码
+ (NSString *)decodeDES:(NSString*)plainText key:(NSString*)key
{
    NSString* ret = [NSString TripleDES:plainText encryptOrDecrypt:kCCDecrypt key:key];
    NSLog(@"3DES/Base64 Decode Result=%@", ret);
    
    return ret;
}

//添加随机数
+ (NSString *)string:(NSString *)str appendRandom:(NSUInteger)ram
{
    int randValue = arc4random();
    if (randValue < 0) 
    {
        randValue = randValue * -1;
    }
    randValue = randValue % (ram+1);
    return [NSString stringWithFormat:@"%@%d", str, randValue];
}

+ (NSString *)string:(NSString *)str appendRandom:(NSUInteger)ram startFrom:(NSUInteger)start
{
    NSUInteger randValue = arc4random();
    randValue = randValue % (ram+1-start) + start;
    return [NSString stringWithFormat:@"%@%lu", str, (unsigned long)randValue];
}

//判断是否为整形
- (BOOL)isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形
- (BOOL)isPureFloat
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    
    float val;
    
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (NSUInteger)hexStrToInt
{
    return strtoul([self UTF8String], 0, 16);
}

- (NSString *)getPinIn
{
    if (self.length)
    {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO))
        {
            NSLog(@"pinyin: %@", ms);
            
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO))
            {
                NSLog(@"pinyin: %@", ms);
                
                return ms;
            }
        }
    }
    
    return nil;
}

@end



@implementation NSString (Size)

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode
{
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGFloat)widthForFont:(UIFont *)font
{
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByCharWrapping];
    return size.width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width
{
    CGSize size = [self sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByCharWrapping];
    return size.height;
}


- (CGSize)sizeToFitWidth:(CGFloat)width withFont:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    return [self sizeToFit:maxSize withFont:font lineBreakMode:NSLineBreakByCharWrapping];
}

- (CGSize)sizeToFitHeight:(CGFloat)height withFont:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, height);
    return [self sizeToFit:maxSize withFont:font lineBreakMode:NSLineBreakByCharWrapping];
}

- (CGSize)sizeToFit:(CGSize)maxSize withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin |  NSStringDrawingUsesFontLeading;

    if (lineBreakMode ==  NSLineBreakByTruncatingHead ||
        lineBreakMode ==  NSLineBreakByTruncatingTail ||
        lineBreakMode ==  NSLineBreakByTruncatingMiddle )
    {
        options |= NSStringDrawingTruncatesLastVisibleLine;
    }

    CGRect textRect = [self boundingRectWithSize:maxSize options:options attributes:@{NSFontAttributeName:font} context:nil];

    return textRect.size;
}

@end


#pragma mark - Hash

@implementation NSString (HASH)

- (NSString *)md2String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md2String];
}

- (NSString *)md4String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md4String];
}

- (NSString *)md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
}

- (NSString *)sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha1String];
}

- (NSString *)sha224String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha224String];
}

- (NSString *)sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha256String];
}

- (NSString *)sha384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha384String];
}

- (NSString *)sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha512String];
}

- (NSString *)crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] crc32String];
}

- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacMD5StringWithKey:key];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA1StringWithKey:key];
}

- (NSString *)hmacSHA224StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA224StringWithKey:key];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA256StringWithKey:key];
}

- (NSString *)hmacSHA384StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA384StringWithKey:key];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA512StringWithKey:key];
}

- (NSString *)base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}

+ (NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString {
    NSData *data = [NSData dataWithBase64EncodedString:base64EncodedString];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end


@implementation NSString (paths)

#pragma mark Standard Paths

- (NSString *)getFullFileExtension
{
    NSString *extension = [self pathExtension];
    if (![extension isEqualToString:@""])
    {
        extension = [NSString stringWithFormat:@".%@", extension];
    }
    
    return extension;
}

+ (NSString *)cachesPath
{
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    });
    
    return cachedPath;
}

+ (NSString *)documentsPath
{
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    });
    
    return cachedPath;
}

+ (NSString *)libraryPath
{
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    });
    
    return cachedPath;
}

+ (NSString *)bundlePath
{
    return [[NSBundle mainBundle] bundlePath];
}


#pragma mark - Temporary Paths

+ (NSString *)temporaryPath
{
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = NSTemporaryDirectory();
    });
    
    return cachedPath;
}

+ (NSString *)pathForTemporaryFile
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    NSString *tmpPath = [[NSString temporaryPath] stringByAppendingPathComponent:(__bridge NSString *)newUniqueIdString];
    CFRelease(newUniqueId);
    CFRelease(newUniqueIdString);
    
    return tmpPath;
}

#pragma mark Working with Paths

// sdfds123 --> sdfds124
- (NSString *)pathByIncrementingSequenceNumber
{
    NSString *baseName = [self stringByDeletingPathExtension];
    NSString *extension = [self pathExtension];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\(([0-9]+)\\)$" options:0 error:NULL];
    __block NSInteger sequenceNumber = 0;
    
    [regex enumerateMatchesInString:baseName options:0 range:NSMakeRange(0, [baseName length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
        
        NSRange range = [match rangeAtIndex:1]; // first capture group
        NSString *substring= [self substringWithRange:range];
        
        sequenceNumber = [substring integerValue];
        *stop = YES;
    }];
    
    NSString *nakedName = [baseName pathByDeletingSequenceNumber];
    
    if ([extension isEqualToString:@""])
    {
        return [nakedName stringByAppendingFormat:@"(%ld)", (long)sequenceNumber+1];
    }
    
    return [[nakedName stringByAppendingFormat:@"(%ld)", (long)sequenceNumber+1] stringByAppendingPathExtension:extension];
}

// sdfds123 --> sdfds
- (NSString *)pathByDeletingSequenceNumber
{
    NSString *baseName = [self stringByDeletingPathExtension];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\([0-9]+\\)$" options:0 error:NULL];
    __block NSRange range = NSMakeRange(NSNotFound, 0);
    
    [regex enumerateMatchesInString:baseName options:0 range:NSMakeRange(0, [baseName length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop) {
        
        range = [match range];
        
        *stop = YES;
    }];
    
    if (range.location != NSNotFound)
    {
        return [self stringByReplacingCharactersInRange:range withString:@""];
    }
    
    return self;
}

@end

@implementation NSString (Emoji)

- (BOOL)containsEmoji
{
    return [self containsEmojiForSystemVersion:[UIDevice iOSVersion]];
}

- (BOOL)containsEmojiForSystemVersion:(float)systemVersion
{
    // If detected, it MUST contains emoji; otherwise it MAY not contains emoji.
    static NSMutableCharacterSet *minSet8_3, *minSetOld;
    // If detected, it may contains emoji; otherwise it MUST NOT contains emoji.
    static NSMutableCharacterSet *maxSet;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        minSetOld = [NSMutableCharacterSet new];
        [minSetOld addCharactersInString:@"u2139\u2194\u2195\u2196\u2197\u2198\u2199\u21a9\u21aa\u231a\u231b\u23e9\u23ea\u23eb\u23ec\u23f0\u23f3\u24c2\u25aa\u25ab\u25b6\u25c0\u25fb\u25fc\u25fd\u25fe\u2600\u2601\u260e\u2611\u2614\u2615\u261d\u261d\u263a\u2648\u2649\u264a\u264b\u264c\u264d\u264e\u264f\u2650\u2651\u2652\u2653\u2660\u2663\u2665\u2666\u2668\u267b\u267f\u2693\u26a0\u26a1\u26aa\u26ab\u26bd\u26be\u26c4\u26c5\u26ce\u26d4\u26ea\u26f2\u26f3\u26f5\u26fa\u26fd\u2702\u2705\u2708\u2709\u270a\u270b\u270c\u270c\u270f\u2712\u2714\u2716\u2728\u2733\u2734\u2744\u2747\u274c\u274e\u2753\u2754\u2755\u2757\u2764\u2795\u2796\u2797\u27a1\u27b0\u27bf\u2934\u2935\u2b05\u2b06\u2b07\u2b1b\u2b1c\u2b50\u2b55\u3030\u303d\u3297\u3299\U0001f004\U0001f0cf\U0001f170\U0001f171\U0001f17e\U0001f17f\U0001f18e\U0001f191\U0001f192\U0001f193\U0001f194\U0001f195\U0001f196\U0001f197\U0001f198\U0001f199\U0001f19a\U0001f201\U0001f202\U0001f21a\U0001f22f\U0001f232\U0001f233\U0001f234\U0001f235\U0001f236\U0001f237\U0001f238\U0001f239\U0001f23a\U0001f250\U0001f251\U0001f300\U0001f301\U0001f302\U0001f303\U0001f304\U0001f305\U0001f306\U0001f307\U0001f308\U0001f309\U0001f30a\U0001f30b\U0001f30c\U0001f30d\U0001f30e\U0001f30f\U0001f310\U0001f311\U0001f312\U0001f313\U0001f314\U0001f315\U0001f316\U0001f317\U0001f318\U0001f319\U0001f31a\U0001f31b\U0001f31c\U0001f31d\U0001f31e\U0001f31f\U0001f320\U0001f330\U0001f331\U0001f332\U0001f333\U0001f334\U0001f335\U0001f337\U0001f338\U0001f339\U0001f33a\U0001f33b\U0001f33c\U0001f33d\U0001f33e\U0001f33f\U0001f340\U0001f341\U0001f342\U0001f343\U0001f344\U0001f345\U0001f346\U0001f347\U0001f348\U0001f349\U0001f34a\U0001f34b\U0001f34c\U0001f34d\U0001f34e\U0001f34f\U0001f350\U0001f351\U0001f352\U0001f353\U0001f354\U0001f355\U0001f356\U0001f357\U0001f358\U0001f359\U0001f35a\U0001f35b\U0001f35c\U0001f35d\U0001f35e\U0001f35f\U0001f360\U0001f361\U0001f362\U0001f363\U0001f364\U0001f365\U0001f366\U0001f367\U0001f368\U0001f369\U0001f36a\U0001f36b\U0001f36c\U0001f36d\U0001f36e\U0001f36f\U0001f370\U0001f371\U0001f372\U0001f373\U0001f374\U0001f375\U0001f376\U0001f377\U0001f378\U0001f379\U0001f37a\U0001f37b\U0001f37c\U0001f380\U0001f381\U0001f382\U0001f383\U0001f384\U0001f385\U0001f386\U0001f387\U0001f388\U0001f389\U0001f38a\U0001f38b\U0001f38c\U0001f38d\U0001f38e\U0001f38f\U0001f390\U0001f391\U0001f392\U0001f393\U0001f3a0\U0001f3a1\U0001f3a2\U0001f3a3\U0001f3a4\U0001f3a5\U0001f3a6\U0001f3a7\U0001f3a8\U0001f3a9\U0001f3aa\U0001f3ab\U0001f3ac\U0001f3ad\U0001f3ae\U0001f3af\U0001f3b0\U0001f3b1\U0001f3b2\U0001f3b3\U0001f3b4\U0001f3b5\U0001f3b6\U0001f3b7\U0001f3b8\U0001f3b9\U0001f3ba\U0001f3bb\U0001f3bc\U0001f3bd\U0001f3be\U0001f3bf\U0001f3c0\U0001f3c1\U0001f3c2\U0001f3c3\U0001f3c4\U0001f3c6\U0001f3c7\U0001f3c8\U0001f3c9\U0001f3ca\U0001f3e0\U0001f3e1\U0001f3e2\U0001f3e3\U0001f3e4\U0001f3e5\U0001f3e6\U0001f3e7\U0001f3e8\U0001f3e9\U0001f3ea\U0001f3eb\U0001f3ec\U0001f3ed\U0001f3ee\U0001f3ef\U0001f3f0\U0001f400\U0001f401\U0001f402\U0001f403\U0001f404\U0001f405\U0001f406\U0001f407\U0001f408\U0001f409\U0001f40a\U0001f40b\U0001f40c\U0001f40d\U0001f40e\U0001f40f\U0001f410\U0001f411\U0001f412\U0001f413\U0001f414\U0001f415\U0001f416\U0001f417\U0001f418\U0001f419\U0001f41a\U0001f41b\U0001f41c\U0001f41d\U0001f41e\U0001f41f\U0001f420\U0001f421\U0001f422\U0001f423\U0001f424\U0001f425\U0001f426\U0001f427\U0001f428\U0001f429\U0001f42a\U0001f42b\U0001f42c\U0001f42d\U0001f42e\U0001f42f\U0001f430\U0001f431\U0001f432\U0001f433\U0001f434\U0001f435\U0001f436\U0001f437\U0001f438\U0001f439\U0001f43a\U0001f43b\U0001f43c\U0001f43d\U0001f43e\U0001f440\U0001f442\U0001f443\U0001f444\U0001f445\U0001f446\U0001f447\U0001f448\U0001f449\U0001f44a\U0001f44b\U0001f44c\U0001f44d\U0001f44e\U0001f44f\U0001f450\U0001f451\U0001f452\U0001f453\U0001f454\U0001f455\U0001f456\U0001f457\U0001f458\U0001f459\U0001f45a\U0001f45b\U0001f45c\U0001f45d\U0001f45e\U0001f45f\U0001f460\U0001f461\U0001f462\U0001f463\U0001f464\U0001f465\U0001f466\U0001f467\U0001f468\U0001f469\U0001f46a\U0001f46b\U0001f46c\U0001f46d\U0001f46e\U0001f46f\U0001f470\U0001f471\U0001f472\U0001f473\U0001f474\U0001f475\U0001f476\U0001f477\U0001f478\U0001f479\U0001f47a\U0001f47b\U0001f47c\U0001f47d\U0001f47e\U0001f47f\U0001f480\U0001f481\U0001f482\U0001f483\U0001f484\U0001f485\U0001f486\U0001f487\U0001f488\U0001f489\U0001f48a\U0001f48b\U0001f48c\U0001f48d\U0001f48e\U0001f48f\U0001f490\U0001f491\U0001f492\U0001f493\U0001f494\U0001f495\U0001f496\U0001f497\U0001f498\U0001f499\U0001f49a\U0001f49b\U0001f49c\U0001f49d\U0001f49e\U0001f49f\U0001f4a0\U0001f4a1\U0001f4a2\U0001f4a3\U0001f4a4\U0001f4a5\U0001f4a6\U0001f4a7\U0001f4a8\U0001f4a9\U0001f4aa\U0001f4ab\U0001f4ac\U0001f4ad\U0001f4ae\U0001f4af\U0001f4b0\U0001f4b1\U0001f4b2\U0001f4b3\U0001f4b4\U0001f4b5\U0001f4b6\U0001f4b7\U0001f4b8\U0001f4b9\U0001f4ba\U0001f4bb\U0001f4bc\U0001f4bd\U0001f4be\U0001f4bf\U0001f4c0\U0001f4c1\U0001f4c2\U0001f4c3\U0001f4c4\U0001f4c5\U0001f4c6\U0001f4c7\U0001f4c8\U0001f4c9\U0001f4ca\U0001f4cb\U0001f4cc\U0001f4cd\U0001f4ce\U0001f4cf\U0001f4d0\U0001f4d1\U0001f4d2\U0001f4d3\U0001f4d4\U0001f4d5\U0001f4d6\U0001f4d7\U0001f4d8\U0001f4d9\U0001f4da\U0001f4db\U0001f4dc\U0001f4dd\U0001f4de\U0001f4df\U0001f4e0\U0001f4e1\U0001f4e2\U0001f4e3\U0001f4e4\U0001f4e5\U0001f4e6\U0001f4e7\U0001f4e8\U0001f4e9\U0001f4ea\U0001f4eb\U0001f4ec\U0001f4ed\U0001f4ee\U0001f4ef\U0001f4f0\U0001f4f1\U0001f4f2\U0001f4f3\U0001f4f4\U0001f4f5\U0001f4f6\U0001f4f7\U0001f4f9\U0001f4fa\U0001f4fb\U0001f4fc\U0001f500\U0001f501\U0001f502\U0001f503\U0001f504\U0001f505\U0001f506\U0001f507\U0001f508\U0001f509\U0001f50a\U0001f50b\U0001f50c\U0001f50d\U0001f50e\U0001f50f\U0001f510\U0001f511\U0001f512\U0001f513\U0001f514\U0001f515\U0001f516\U0001f517\U0001f518\U0001f519\U0001f51a\U0001f51b\U0001f51c\U0001f51d\U0001f51e\U0001f51f\U0001f520\U0001f521\U0001f522\U0001f523\U0001f524\U0001f525\U0001f526\U0001f527\U0001f528\U0001f529\U0001f52a\U0001f52b\U0001f52c\U0001f52d\U0001f52e\U0001f52f\U0001f530\U0001f531\U0001f532\U0001f533\U0001f534\U0001f535\U0001f536\U0001f537\U0001f538\U0001f539\U0001f53a\U0001f53b\U0001f53c\U0001f53d\U0001f550\U0001f551\U0001f552\U0001f553\U0001f554\U0001f555\U0001f556\U0001f557\U0001f558\U0001f559\U0001f55a\U0001f55b\U0001f55c\U0001f55d\U0001f55e\U0001f55f\U0001f560\U0001f561\U0001f562\U0001f563\U0001f564\U0001f565\U0001f566\U0001f567\U0001f5fb\U0001f5fc\U0001f5fd\U0001f5fe\U0001f5ff\U0001f600\U0001f601\U0001f602\U0001f603\U0001f604\U0001f605\U0001f606\U0001f607\U0001f608\U0001f609\U0001f60a\U0001f60b\U0001f60c\U0001f60d\U0001f60e\U0001f60f\U0001f610\U0001f611\U0001f612\U0001f613\U0001f614\U0001f615\U0001f616\U0001f617\U0001f618\U0001f619\U0001f61a\U0001f61b\U0001f61c\U0001f61d\U0001f61e\U0001f61f\U0001f620\U0001f621\U0001f622\U0001f623\U0001f624\U0001f625\U0001f626\U0001f627\U0001f628\U0001f629\U0001f62a\U0001f62b\U0001f62c\U0001f62d\U0001f62e\U0001f62f\U0001f630\U0001f631\U0001f632\U0001f633\U0001f634\U0001f635\U0001f636\U0001f637\U0001f638\U0001f639\U0001f63a\U0001f63b\U0001f63c\U0001f63d\U0001f63e\U0001f63f\U0001f640\U0001f645\U0001f646\U0001f647\U0001f648\U0001f649\U0001f64a\U0001f64b\U0001f64c\U0001f64d\U0001f64e\U0001f64f\U0001f680\U0001f681\U0001f682\U0001f683\U0001f684\U0001f685\U0001f686\U0001f687\U0001f688\U0001f689\U0001f68a\U0001f68b\U0001f68c\U0001f68d\U0001f68e\U0001f68f\U0001f690\U0001f691\U0001f692\U0001f693\U0001f694\U0001f695\U0001f696\U0001f697\U0001f698\U0001f699\U0001f69a\U0001f69b\U0001f69c\U0001f69d\U0001f69e\U0001f69f\U0001f6a0\U0001f6a1\U0001f6a2\U0001f6a3\U0001f6a4\U0001f6a5\U0001f6a6\U0001f6a7\U0001f6a8\U0001f6a9\U0001f6aa\U0001f6ab\U0001f6ac\U0001f6ad\U0001f6ae\U0001f6af\U0001f6b0\U0001f6b1\U0001f6b2\U0001f6b3\U0001f6b4\U0001f6b5\U0001f6b6\U0001f6b7\U0001f6b8\U0001f6b9\U0001f6ba\U0001f6bb\U0001f6bc\U0001f6bd\U0001f6be\U0001f6bf\U0001f6c0\U0001f6c1\U0001f6c2\U0001f6c3\U0001f6c4\U0001f6c5"];
        
        maxSet = minSetOld.mutableCopy;
        [maxSet addCharactersInRange:NSMakeRange(0x20e3, 1)]; // Combining Enclosing Keycap (multi-face emoji)
        [maxSet addCharactersInRange:NSMakeRange(0xfe0f, 1)]; // Variation Selector
        [maxSet addCharactersInRange:NSMakeRange(0x1f1e6, 26)]; // Regional Indicator Symbol Letter
        
        minSet8_3 = minSetOld.mutableCopy;
        [minSet8_3 addCharactersInRange:NSMakeRange(0x1f3fb, 5)]; // Color of skin
    });
    
    // 1. Most of string does not contains emoji, so test the maximum range of charset first.
    if ([self rangeOfCharacterFromSet:maxSet].location == NSNotFound) return NO;
    
    // 2. If the emoji can be detected by the minimum charset, return 'YES' directly.
    if ([self rangeOfCharacterFromSet:((systemVersion < 8.3) ? minSetOld : minSet8_3)].location != NSNotFound) return YES;
    
    // 3. The string contains some characters which may compose an emoji, but cannot detected with charset.
    // Use a regular expression to detect the emoji. It's slower than using charset.
    static NSRegularExpression *regexOld, *regex8_3, *regex9_0;
    static dispatch_once_t onceTokenRegex;
    dispatch_once(&onceTokenRegex, ^{
        regexOld = [NSRegularExpression regularExpressionWithPattern:@"(©️|®️|™️|〰️|🇨🇳|🇩🇪|🇪🇸|🇫🇷|🇬🇧|🇮🇹|🇯🇵|🇰🇷|🇷🇺|🇺🇸)" options:kNilOptions error:nil];
        regex8_3 = [NSRegularExpression regularExpressionWithPattern:@"(©️|®️|™️|〰️|🇦🇺|🇦🇹|🇧🇪|🇧🇷|🇨🇦|🇨🇱|🇨🇳|🇨🇴|🇩🇰|🇫🇮|🇫🇷|🇩🇪|🇭🇰|🇮🇳|🇮🇩|🇮🇪|🇮🇱|🇮🇹|🇯🇵|🇰🇷|🇲🇴|🇲🇾|🇲🇽|🇳🇱|🇳🇿|🇳🇴|🇵🇭|🇵🇱|🇵🇹|🇵🇷|🇷🇺|🇸🇦|🇸🇬|🇿🇦|🇪🇸|🇸🇪|🇨🇭|🇹🇷|🇬🇧|🇺🇸|🇦🇪|🇻🇳)" options:kNilOptions error:nil];
        regex9_0 = [NSRegularExpression regularExpressionWithPattern:@"(©️|®️|™️|〰️|🇦🇫|🇦🇽|🇦🇱|🇩🇿|🇦🇸|🇦🇩|🇦🇴|🇦🇮|🇦🇶|🇦🇬|🇦🇷|🇦🇲|🇦🇼|🇦🇺|🇦🇹|🇦🇿|🇧🇸|🇧🇭|🇧🇩|🇧🇧|🇧🇾|🇧🇪|🇧🇿|🇧🇯|🇧🇲|🇧🇹|🇧🇴|🇧🇶|🇧🇦|🇧🇼|🇧🇻|🇧🇷|🇮🇴|🇻🇬|🇧🇳|🇧🇬|🇧🇫|🇧🇮|🇰🇭|🇨🇲|🇨🇦|🇨🇻|🇰🇾|🇨🇫|🇹🇩|🇨🇱|🇨🇳|🇨🇽|🇨🇨|🇨🇴|🇰🇲|🇨🇬|🇨🇩|🇨🇰|🇨🇷|🇨🇮|🇭🇷|🇨🇺|🇨🇼|🇨🇾|🇨🇿|🇩🇰|🇩🇯|🇩🇲|🇩🇴|🇪🇨|🇪🇬|🇸🇻|🇬🇶|🇪🇷|🇪🇪|🇪🇹|🇫🇰|🇫🇴|🇫🇯|🇫🇮|🇫🇷|🇬🇫|🇵🇫|🇹🇫|🇬🇦|🇬🇲|🇬🇪|🇩🇪|🇬🇭|🇬🇮|🇬🇷|🇬🇱|🇬🇩|🇬🇵|🇬🇺|🇬🇹|🇬🇬|🇬🇳|🇬🇼|🇬🇾|🇭🇹|🇭🇲|🇭🇳|🇭🇰|🇭🇺|🇮🇸|🇮🇳|🇮🇩|🇮🇷|🇮🇶|🇮🇪|🇮🇲|🇮🇱|🇮🇹|🇯🇲|🇯🇵|🇯🇪|🇯🇴|🇰🇿|🇰🇪|🇰🇮|🇰🇼|🇰🇬|🇱🇦|🇱🇻|🇱🇧|🇱🇸|🇱🇷|🇱🇾|🇱🇮|🇱🇹|🇱🇺|🇲🇴|🇲🇰|🇲🇬|🇲🇼|🇲🇾|🇲🇻|🇲🇱|🇲🇹|🇲🇭|🇲🇶|🇲🇷|🇲🇺|🇾🇹|🇲🇽|🇫🇲|🇲🇩|🇲🇨|🇲🇳|🇲🇪|🇲🇸|🇲🇦|🇲🇿|🇲🇲|🇳🇦|🇳🇷|🇳🇵|🇳🇱|🇳🇨|🇳🇿|🇳🇮|🇳🇪|🇳🇬|🇳🇺|🇳🇫|🇲🇵|🇰🇵|🇳🇴|🇴🇲|🇵🇰|🇵🇼|🇵🇸|🇵🇦|🇵🇬|🇵🇾|🇵🇪|🇵🇭|🇵🇳|🇵🇱|🇵🇹|🇵🇷|🇶🇦|🇷🇪|🇷🇴|🇷🇺|🇷🇼|🇧🇱|🇸🇭|🇰🇳|🇱🇨|🇲🇫|🇻🇨|🇼🇸|🇸🇲|🇸🇹|🇸🇦|🇸🇳|🇷🇸|🇸🇨|🇸🇱|🇸🇬|🇸🇰|🇸🇮|🇸🇧|🇸🇴|🇿🇦|🇬🇸|🇰🇷|🇸🇸|🇪🇸|🇱🇰|🇸🇩|🇸🇷|🇸🇯|🇸🇿|🇸🇪|🇨🇭|🇸🇾|🇹🇼|🇹🇯|🇹🇿|🇹🇭|🇹🇱|🇹🇬|🇹🇰|🇹🇴|🇹🇹|🇹🇳|🇹🇷|🇹🇲|🇹🇨|🇹🇻|🇺🇬|🇺🇦|🇦🇪|🇬🇧|🇺🇸|🇺🇲|🇻🇮|🇺🇾|🇺🇿|🇻🇺|🇻🇦|🇻🇪|🇻🇳|🇼🇫|🇪🇭|🇾🇪|🇿🇲|🇿🇼)" options:kNilOptions error:nil];
    });
    
    NSRange regexRange = [(systemVersion < 8.3 ? regexOld : systemVersion < 9.0 ? regex8_3 : regex9_0) rangeOfFirstMatchInString:self options:kNilOptions range:NSMakeRange(0, self.length)];
    return regexRange.location != NSNotFound;
}

@end


