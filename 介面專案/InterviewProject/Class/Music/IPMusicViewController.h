//
//  IPMusicViewController.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/15.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPBasicViewController.h"
#import "IPMusicView.h"
#include <EZAudio/EZAudio.h>

@interface IPMusicViewController : IPBasicViewController
<EZAudioPlayerDelegate, EZAudioFFTDelegate, IPMusicViewDelegate>
{
    IBOutlet IPMusicView *musicView;
}

@property (nonatomic, strong) EZAudioFile *audioFile;
@property (nonatomic, strong) EZAudioPlayer *player;
@property (nonatomic, strong) EZAudioFFTRolling *fft;

@end
