#line 1 "/Users/null/Desktop/Evernote2myblog/Evernote2myblog/ENMarketSVProgressHUD.xm"





#import "ENMarketSVProgressHUD.h"

#include <logos/logos.h>
#include <substrate.h>
@class ENMarketSVProgressHUD; 
static void (*_logos_meta_orig$_ungrouped$ENMarketSVProgressHUD$showWithStatus$)(Class, SEL, id); static void _logos_meta_method$_ungrouped$ENMarketSVProgressHUD$showWithStatus$(Class, SEL, id); static void (*_logos_meta_orig$_ungrouped$ENMarketSVProgressHUD$dismiss)(Class, SEL); static void _logos_meta_method$_ungrouped$ENMarketSVProgressHUD$dismiss(Class, SEL); 

#line 8 "/Users/null/Desktop/Evernote2myblog/Evernote2myblog/ENMarketSVProgressHUD.xm"


static void _logos_meta_method$_ungrouped$ENMarketSVProgressHUD$showWithStatus$(Class self, SEL _cmd, id stauts){
    return _logos_meta_orig$_ungrouped$ENMarketSVProgressHUD$showWithStatus$(self, _cmd, stauts);
}

static void _logos_meta_method$_ungrouped$ENMarketSVProgressHUD$dismiss(Class self, SEL _cmd){
    return%orig;
}




static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$ENMarketSVProgressHUD = objc_getClass("ENMarketSVProgressHUD"); Class _logos_metaclass$_ungrouped$ENMarketSVProgressHUD = object_getClass(_logos_class$_ungrouped$ENMarketSVProgressHUD); MSHookMessageEx(_logos_metaclass$_ungrouped$ENMarketSVProgressHUD, @selector(showWithStatus:), (IMP)&_logos_meta_method$_ungrouped$ENMarketSVProgressHUD$showWithStatus$, (IMP*)&_logos_meta_orig$_ungrouped$ENMarketSVProgressHUD$showWithStatus$);MSHookMessageEx(_logos_metaclass$_ungrouped$ENMarketSVProgressHUD, @selector(dismiss), (IMP)&_logos_meta_method$_ungrouped$ENMarketSVProgressHUD$dismiss, (IMP*)&_logos_meta_orig$_ungrouped$ENMarketSVProgressHUD$dismiss);} }
#line 21 "/Users/null/Desktop/Evernote2myblog/Evernote2myblog/ENMarketSVProgressHUD.xm"
