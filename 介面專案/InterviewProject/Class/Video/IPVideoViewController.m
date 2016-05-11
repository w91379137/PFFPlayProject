//
//  IPVideoViewController.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/15.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPVideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#import "XCDYouTubeKit.h"

@interface IPVideoViewController ()
{
    MPMoviePlayerController *player;
}

@end

@implementation IPVideoViewController

#pragma mark - Init
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerPlaybackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - IBAction
- (IBAction)topPlayAction:(id)sender
{
    [self displayVideoWithURLString:self.topTextView.text];
}

- (IBAction)bottomPlayAction:(id)sender
{
    [self displayVideoWithURLString:self.bottomTextView.text];
}

//http://stackoverflow.com/questions/21088471/how-to-play-youtube-vimeo-video-within-the-application-in-iphone
//http://stackoverflow.com/questions/2243801/iphone-parsing-url-for-get-params

- (void)displayVideoWithURLString:(NSString *)urlString
{
    NSArray *comp1 = [urlString componentsSeparatedByString:@"?"];
    NSString *query = [comp1 lastObject];
    NSArray *queryElements = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for (NSString *element in queryElements) {
        NSArray *keyVal = [element componentsSeparatedByString:@"="];
        if (keyVal.count > 0) {
            NSString *variableKey = [keyVal objectAtIndex:0];
            NSString *value = (keyVal.count == 2) ? [keyVal lastObject] : nil;
            
            if (variableKey && value) {
                params[variableKey] = value;
            }
        }
    }
    
    if (params[@"v"]) {
        XCDYouTubeVideoPlayerViewController *videoPlayerViewController =
        [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:params[@"v"]];
        [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
    }
}

- (void)moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
    MPMovieFinishReason finishReason =
    [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
    
    if (finishReason == MPMovieFinishReasonPlaybackError)
    {
//        NSError *error = notification.userInfo[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey];
        // Handle error
    }
}

@end
