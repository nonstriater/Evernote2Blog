
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos

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


%hook EVEActionSheet

- (void)viewWillLayoutSubviews{
    %orig;
    
    NSLog(@"self.hostViewController=%@",self.hostViewController);
    //<EVEDefaultNoteViewController: 0x18bcd000> noteURL: evernotecid://E5B36D91-33C6-42D2-992F-7137FF492F23/ENNote/p550; isNewNote: 0; isModified: 0 documentURL: evernotecid://E5B36D91-33C6-42D2-992F-7137FF492F23/ENNote/p550
    
//    const char *className = object_getClassName(self.hostViewController);
//    if([[NSString stringWithCString:className encoding:NSUTF8StringEncoding] isEqualToString:@"EVEDefaultNoteViewController"]){
//        UIView *cv = MSHookIvar<UIView *>(self,"_containerView");
//        NSLog(@"objc_getClassName  viewWillLayout,cv=%@",cv);
//    }
//    
//    
//    if([self.hostViewController isKindOfClass:[EVEDefaultNoteViewController class]]){
//        UIView *cv = MSHookIvar<UIView *>(self,"_containerView");
//        NSLog(@" isKindOfClass  viewWillLayout,cv=%@",cv);
//    }
    
    if([self isHostBeDefaultNote]){
        UIView *cv = MSHookIvar<UIView *>(self,"_containerView");
        cv.frame = CGRectMake(-6.f,111.f,332.f,463.f);
        self.tableView.frame = CGRectMake(0.f,0.f,320.f,401.f);
        self.cancelButton.frame = CGRectMake(0.f,401.f,320.f,50.f);
        NSLog(@"objc_getClassName  viewWillLayout,cv=%@",cv);
    }
    
}

//处理旋转事件



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = %orig;
    if([self isHostBeDefaultNote]){
        rows+=2;
    }
    NSLog(@"hook rows=%ld",(long)rows);
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

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

    return %orig;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    %orig;
    
    if([self isHostBeDefaultNote]){
        
        NSInteger totalRows = [tableView numberOfRowsInSection:0];
        if(indexPath.row==totalRows-1){
            NSLog(@"分享笔记到我的博客");
        
            NSDictionary *userInfo = @{@"category":@"",@"postPath":@""};
            CPDistributedMessagingCenter *center = [CPDistributedMessagingCenter centerNamed:@"com.nonstriater.evernote2myblogd"];
            rocketbootstrap_distributedmessagingcenter_apply(center);
            [center sendMessageName:@"com.nonstriater.evernote2myblogd.push" userInfo:userInfo];
            
            //CFNotificationCenterPostNotification(center,CFSTR("com.nonstriater.evernote2myblog.push"),object,userInfo,true);
            
        }else if(indexPath.row==totalRows-2){
            
            if([self.hostViewController isKindOfClass:UIViewController.class]){
                if([self.hostViewController.view isKindOfClass:[UIWebView class]]){
                    
                    [self dismissViewControllerAnimated:YES completion:^{
                        NSLog(@"截图");
                        [%c(ENMarketSVProgressHUD) showWithStatus:@"截图..."];
                        UIImage *image = [(UIWebView *)self.hostViewController.view screenshot];
                        UIImageWriteToSavedPhotosAlbum(image,nil,nil,NULL);
                        [%c(ENMarketSVProgressHUD) dismiss];
                    }];
                    
                }
            }
        }
    
    }
 
}


%new
- (BOOL)isHostBeDefaultNote{
    const char *className = object_getClassName(self.hostViewController);
    if([[NSString stringWithCString:className encoding:NSUTF8StringEncoding] isEqualToString:@"EVEDefaultNoteViewController"]){
        return YES;
    }
    return NO;
}


%end
