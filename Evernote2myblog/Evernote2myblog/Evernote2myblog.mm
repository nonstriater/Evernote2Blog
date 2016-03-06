#line 1 "/Users/null/Desktop/Evernote2myblog/Evernote2myblog/Evernote2myblog.xm"




#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import "Private/CPDistributedMessagingCenter.h"
#import "Private/rocketbootstrap.h"
#import <objc/runtime.h>
#import "EVEActionSheetCell.h"
#import "EVEActionSheet.h"
#import "EVEDefaultNoteViewController.h"
#import "UIWebView+addtions.h"
#import "ENMarketSVProgressHUD.h"


#include <logos/logos.h>
#include <substrate.h>
@class ENMarketSVProgressHUD; @class EVEActionSheet; 
static void (*_logos_orig$_ungrouped$EVEActionSheet$viewWillLayoutSubviews)(EVEActionSheet*, SEL); static void _logos_method$_ungrouped$EVEActionSheet$viewWillLayoutSubviews(EVEActionSheet*, SEL); static NSInteger (*_logos_orig$_ungrouped$EVEActionSheet$tableView$numberOfRowsInSection$)(EVEActionSheet*, SEL, UITableView *, NSInteger); static NSInteger _logos_method$_ungrouped$EVEActionSheet$tableView$numberOfRowsInSection$(EVEActionSheet*, SEL, UITableView *, NSInteger); static UITableViewCell * (*_logos_orig$_ungrouped$EVEActionSheet$tableView$cellForRowAtIndexPath$)(EVEActionSheet*, SEL, UITableView *, NSIndexPath *); static UITableViewCell * _logos_method$_ungrouped$EVEActionSheet$tableView$cellForRowAtIndexPath$(EVEActionSheet*, SEL, UITableView *, NSIndexPath *); static void (*_logos_orig$_ungrouped$EVEActionSheet$tableView$didSelectRowAtIndexPath$)(EVEActionSheet*, SEL, UITableView *, NSIndexPath *); static void _logos_method$_ungrouped$EVEActionSheet$tableView$didSelectRowAtIndexPath$(EVEActionSheet*, SEL, UITableView *, NSIndexPath *); static BOOL _logos_method$_ungrouped$EVEActionSheet$isHostBeDefaultNote(EVEActionSheet*, SEL); 
static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$ENMarketSVProgressHUD(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("ENMarketSVProgressHUD"); } return _klass; }
#line 17 "/Users/null/Desktop/Evernote2myblog/Evernote2myblog/Evernote2myblog.xm"


static void _logos_method$_ungrouped$EVEActionSheet$viewWillLayoutSubviews(EVEActionSheet* self, SEL _cmd){
    _logos_orig$_ungrouped$EVEActionSheet$viewWillLayoutSubviews(self, _cmd);
    
    NSLog(@"self.hostViewController=%@",self.hostViewController);
    
    











    
    if([self isHostBeDefaultNote]){
        UIView *cv = MSHookIvar<UIView *>(self,"_containerView");
        cv.frame = CGRectMake(-6.f,111.f,332.f,463.f);
        self.tableView.frame = CGRectMake(0.f,0.f,320.f,401.f);
        self.cancelButton.frame = CGRectMake(0.f,401.f,320.f,50.f);
        NSLog(@"objc_getClassName  viewWillLayout,cv=%@",cv);
    }
    
}





static NSInteger _logos_method$_ungrouped$EVEActionSheet$tableView$numberOfRowsInSection$(EVEActionSheet* self, SEL _cmd, UITableView * tableView, NSInteger section){
    NSInteger rows = _logos_orig$_ungrouped$EVEActionSheet$tableView$numberOfRowsInSection$(self, _cmd, tableView, section);
    if([self isHostBeDefaultNote]){
        rows+=2;
    }
    NSLog(@"hook rows=%ld",(long)rows);
    return rows;
}


static UITableViewCell * _logos_method$_ungrouped$EVEActionSheet$tableView$cellForRowAtIndexPath$(EVEActionSheet* self, SEL _cmd, UITableView * tableView, NSIndexPath * indexPath){

    if([self isHostBeDefaultNote]){
        
        NSInteger totalRows = [tableView numberOfRowsInSection:0];
        if(indexPath.row==totalRows-1){
            EVEActionSheetCell *cell = [[EVEActionSheetCell alloc] init];
            cell.backgroundColor = [UIColor clearColor];
            
            cell.textLabel.text = @"分享笔记到我的博客";
            cell.textLabel.font = [UIFont systemFontOfSize:16.f];
            cell.textLabel.textColor = [UIColor colorWithRed:0.176 green:0.745 blue:0.378 alpha:1.f];
            
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(282.f,15.f,20.f,20.f)];
            iv.image = [UIImage imageNamed:@"AppIcon29x29"];
            [cell.contentView addSubview:iv];
            cell.cellImageView = iv;
            
            return cell;
        }else if(indexPath.row==totalRows-2){
            EVEActionSheetCell *cell = [[EVEActionSheetCell alloc] init];
            cell.backgroundColor = [UIColor clearColor];
            
            cell.textLabel.text = @"截屏";
            cell.textLabel.font = [UIFont systemFontOfSize:16.f];
            cell.textLabel.textColor = [UIColor colorWithRed:0.176 green:0.745 blue:0.378 alpha:1.f];
            
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(282.f,15.f,20.f,20.f)];
            iv.image = [UIImage imageNamed:@"image_20x20"];
            iv.tintColor = [UIColor colorWithRed:0.176 green:0.745 blue:0.378 alpha:1.f];
            [cell.contentView addSubview:iv];
            cell.cellImageView = iv;
            
            return cell;
        }
    }

    return _logos_orig$_ungrouped$EVEActionSheet$tableView$cellForRowAtIndexPath$(self, _cmd, tableView, indexPath);
}

static void _logos_method$_ungrouped$EVEActionSheet$tableView$didSelectRowAtIndexPath$(EVEActionSheet* self, SEL _cmd, UITableView * tableView, NSIndexPath * indexPath){

    _logos_orig$_ungrouped$EVEActionSheet$tableView$didSelectRowAtIndexPath$(self, _cmd, tableView, indexPath);
    
    if([self isHostBeDefaultNote]){
        
        NSInteger totalRows = [tableView numberOfRowsInSection:0];
        if(indexPath.row==totalRows-1){
            NSLog(@"分享笔记到我的博客");
        
            NSDictionary *userInfo = @{@"category":@"",@"postPath":@""};
            CPDistributedMessagingCenter *center = [CPDistributedMessagingCenter centerNamed:@"com.nonstriater.evernote2myblogd"];
            rocketbootstrap_distributedmessagingcenter_apply(center);
            [center sendMessageName:@"com.nonstriater.evernote2myblogd.push" userInfo:userInfo];
            
            
            
        }else if(indexPath.row==totalRows-2){
            
            if([self.hostViewController isKindOfClass:UIViewController.class]){
                if([self.hostViewController.view isKindOfClass:[UIWebView class]]){
                    
                    [self dismissViewControllerAnimated:YES completion:^{
                        NSLog(@"截图");
                        [_logos_static_class_lookup$ENMarketSVProgressHUD() showWithStatus:@"截图..."];
                        UIImage *image = [(UIWebView *)self.hostViewController.view screenshot];
                        UIImageWriteToSavedPhotosAlbum(image,nil,nil,NULL);
                        [_logos_static_class_lookup$ENMarketSVProgressHUD() dismiss];
                    }];
                    
                }
            }
        }
    
    }
 
}



static BOOL _logos_method$_ungrouped$EVEActionSheet$isHostBeDefaultNote(EVEActionSheet* self, SEL _cmd){
    const char *className = object_getClassName(self.hostViewController);
    if([[NSString stringWithCString:className encoding:NSUTF8StringEncoding] isEqualToString:@"EVEDefaultNoteViewController"]){
        return YES;
    }
    return NO;
}



static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$EVEActionSheet = objc_getClass("EVEActionSheet"); MSHookMessageEx(_logos_class$_ungrouped$EVEActionSheet, @selector(viewWillLayoutSubviews), (IMP)&_logos_method$_ungrouped$EVEActionSheet$viewWillLayoutSubviews, (IMP*)&_logos_orig$_ungrouped$EVEActionSheet$viewWillLayoutSubviews);MSHookMessageEx(_logos_class$_ungrouped$EVEActionSheet, @selector(tableView:numberOfRowsInSection:), (IMP)&_logos_method$_ungrouped$EVEActionSheet$tableView$numberOfRowsInSection$, (IMP*)&_logos_orig$_ungrouped$EVEActionSheet$tableView$numberOfRowsInSection$);MSHookMessageEx(_logos_class$_ungrouped$EVEActionSheet, @selector(tableView:cellForRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$EVEActionSheet$tableView$cellForRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$EVEActionSheet$tableView$cellForRowAtIndexPath$);MSHookMessageEx(_logos_class$_ungrouped$EVEActionSheet, @selector(tableView:didSelectRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$EVEActionSheet$tableView$didSelectRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$EVEActionSheet$tableView$didSelectRowAtIndexPath$);{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(BOOL), strlen(@encode(BOOL))); i += strlen(@encode(BOOL)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$EVEActionSheet, @selector(isHostBeDefaultNote), (IMP)&_logos_method$_ungrouped$EVEActionSheet$isHostBeDefaultNote, _typeEncoding); }} }
#line 151 "/Users/null/Desktop/Evernote2myblog/Evernote2myblog/Evernote2myblog.xm"
