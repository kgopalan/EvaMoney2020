
#ifndef _WOL_UICOLOR_HEX_COLOR_H__
#define _WOL_UICOLOR_HEX_COLOR_H__


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIColor (HexColor)
+ (UIColor *) colorWithHex:(int)color;
+ (UIColor *) colorWithHexString:(NSString *)hexString;
@end


#endif
