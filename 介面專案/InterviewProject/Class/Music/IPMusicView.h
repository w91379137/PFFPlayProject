//
//  IPMusicView.h
//  InterviewProject
//
//  Created by w91379137 on 2016/5/11.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IPMusicViewDelegate <NSObject>

- (float *)data;
- (NSInteger)groupCount;

@end

@interface IPMusicView : UIView

@property(nonatomic, weak) IBOutlet id<IPMusicViewDelegate> delegate;

@end
