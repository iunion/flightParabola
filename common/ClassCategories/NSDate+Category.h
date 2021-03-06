
/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

#import <Foundation/Foundation.h>

#define D_MINUTE 60
#define D_HOUR 3600
#define D_DAY 86400
#define D_WEEK 604800
#define D_YEAR 31556926

#define MAX_PREGMENT_DAYS   280


@interface NSDate (Category)

+ (NSString *)stringFromDate:(NSDate *)aDate;
+ (NSString *)stringFromDate:(NSDate *)aDate formatter:(NSString *)formatter;
+ (NSString *)stringFromTs:(NSTimeInterval)timestamp;
+ (NSString *)stringFromTs:(NSTimeInterval)timestamp formatter:(NSString *)formatter;
+ (NSString *)stringFromNow;
+ (NSString *)mqStringFromTs:(NSTimeInterval)timestamp;
+ (NSString *)hmStringDateFromDate:(NSDate *)aDate;
+ (NSString *)hmStringDateFromTs:(NSTimeInterval)timestamp;

+ (NSTimeInterval)timeIntervalFromString:(NSString *)dateString;
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)format;

+ (NSCalendar *) currentCalendar;

+ (NSDate *) getCurrentDateWithSystemTimeZone;
+ (NSDate *) getCurrentDateWithTimeZone:(NSTimeZone *)timezone;

+ (NSString *)babyAgeWithDueDate:(NSDate *)dueDate;

/**
 * Returns the current date with the time set to midnight.
 */
+ (NSDate *) dateToday;


// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// Comparing dates
+ (BOOL) isSameDayfirst:(NSTimeInterval)firstDate second:(NSTimeInterval)secondDate;
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isSameDayAsDate: (NSDate *) aDate;

- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;

- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;

- (BOOL) isSameMonthAsDate: (NSDate *) aDate; 
- (BOOL) isThisMonth;
- (BOOL) isNextMonth;
- (BOOL) isLastMonth;

- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;

- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

- (BOOL) isInFuture;
- (BOOL) isInPast;

// Date roles
- (BOOL) isTypicallySunday;
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Date to String
- (NSString *) stringByFormatter: (NSString *) formatter;
- (NSString *) stringByDefaultFormatter;

// Adjusting dates
- (NSDate *) dateByAddingYears: (NSInteger) dYears;
- (NSDate *) dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;

// Date extremes
/*
 * Returns a copy of the date with the time set to 00:00:00 on the same day.
 */
- (NSDate *) dateAtStartOfDay;
/*
 * Returns a copy of the date with the time set to 23:59:59 on the same day.
 */
- (NSDate *) dateAtEndOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger weekOfYear;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

// Date to String
- (NSString *) stringWithDefaultFormat;
- (NSString *) stringWithFormat: (NSString *) format;
- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;

@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;


@end
