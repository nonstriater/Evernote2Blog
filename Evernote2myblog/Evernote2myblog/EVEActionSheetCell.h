//
//  EVEActionSheetCell.h
//  Evernote2myblog
//
//  Created by null on 15-3-19.
//
//

#ifndef Evernote2myblog_EVEActionSheetCell_h
#define Evernote2myblog_EVEActionSheetCell_h

@class UITableViewCell;
@interface EVEActionSheetCell : UITableViewCell

@property(nonatomic,retain) UIImageView *cellImageView;

@end

@implementation EVEActionSheetCell

@synthesize cellImageView = _cellImageView;

@end

#endif
