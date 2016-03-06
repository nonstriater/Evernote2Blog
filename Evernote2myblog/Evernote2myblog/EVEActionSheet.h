//
//  EVEActionSheet.h
//  Evernote2myblog
//
//  Created by null on 15-3-19.
//
//

#ifndef Evernote2myblog_EVEActionSheet_h
#define Evernote2myblog_EVEActionSheet_h

@class UIViewController,UITableView;
@interface EVEActionSheet : UIViewController
@property(nonatomic,retain) UITableView *tableView;
@property(nonatomic,retain) UIButton *cancelButton;
@property(nonatomic,assign) UIViewController *hostViewController;

- (BOOL)isHostBeDefaultNote;

@end

@implementation EVEActionSheet
@synthesize tableView = _tableView;

@end

#endif
