//
//  ENMarketSVProgressHUD.h
//  Evernote2myblog
//
//  Created by null on 15-3-24.
//
//

#ifndef Evernote2myblog_ENMarketSVProgressHUD_h
#define Evernote2myblog_ENMarketSVProgressHUD_h

#import <UIKit/UIKit.h>

@interface ENMarketSVProgressHUD : UIView

+ (void)showWithStatus:(id)status;
+ (void)dismiss;

@end

#endif
