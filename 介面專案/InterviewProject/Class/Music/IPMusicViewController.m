//
//  IPMusicViewController.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/15.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPMusicViewController.h"

@interface IPMusicViewController ()
{
    CADisplayLink *dpLink;
    float *currentData;
    int currentLength;
    
    NSInteger groupCount;
    NSInteger groupMenberNumber;
}

@end

@implementation IPMusicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    groupCount = 128;
    groupMenberNumber = 4096 / groupCount / 8;
    
    currentData = (float *)malloc(sizeof(float) * groupCount);
    for (NSInteger k = 0; k < groupCount; k++) {
        currentData[k] = 0.0;
    }
    
    {//設定輸出
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *error;
        [session setCategory:AVAudioSessionCategoryPlayback error:&error];
        if (error) {
            NSLog(@"Error setting up audio session category: %@", error.localizedDescription);
        }
        [session setActive:YES error:&error];
        if (error) {
            NSLog(@"Error setting up audio session active: %@", error.localizedDescription);
        }
        
        [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
        if (error) {
            NSLog(@"Error overriding output to the speaker: %@", error.localizedDescription);
        }
    }
    
    {//設定資料來源
        self.player = [EZAudioPlayer audioPlayerWithDelegate:self];
        self.player.shouldLoop = YES;
        [self.player setVolume:0.5];
        
        NSString *kAudioFileDefault =
        [[NSBundle mainBundle] pathForResource:@"TheFatRat - Unity" ofType:@"mp3"];
        self.audioFile = [EZAudioFile audioFileWithURL:[NSURL fileURLWithPath:kAudioFileDefault]];
        
        [self.player setAudioFile:self.audioFile];
        
        
        self.fft = [EZAudioFFTRolling fftWithWindowSize:4096
                                             sampleRate:44100
                                               delegate:self];
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.player play];
    });
    
    dpLink =
    [CADisplayLink displayLinkWithTarget:musicView
                                selector:@selector(setNeedsDisplay)];
    [dpLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    musicView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [dpLink invalidate];
    dpLink = nil;
    [super viewWillDisappear:animated];
}

#pragma mark - EZAudioPlayerDelegate
- (void)  audioPlayer:(EZAudioPlayer *)audioPlayer
          playedAudio:(float **)buffer
       withBufferSize:(UInt32)bufferSize
 withNumberOfChannels:(UInt32)numberOfChannels
          inAudioFile:(EZAudioFile *)audioFile
{
    weakSelfMake(weakSelf);
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.fft computeFFTWithBuffer:buffer[0]
                            withBufferSize:bufferSize];
    });
}

#pragma mark - EZAudioFFTDelegate
- (void)        fft:(EZAudioFFT *)fft
 updatedWithFFTData:(float *)fftData
         bufferSize:(vDSP_Length)bufferSize
{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf updateBuffer:fftData withBufferSize:(UInt32)bufferSize];
    });
}

- (void)updateBuffer:(float *)buffer withBufferSize:(UInt32)bufferSize
{
    [self setSampleData:buffer
                 length:bufferSize];
}

- (void)setSampleData:(float *)data length:(int)length
{
    float maxValue = logf(4000);
    float maxC = 0;
    
    for (NSInteger k = 0; k < groupCount; k++) {
        
        float sum = 0.0;
        for (NSInteger t = k * groupMenberNumber;
             t < length && t < (k + 1) * groupMenberNumber;
             t++) {
            sum += data[t] * data[t];
        }
        
        for (NSInteger t = 0; t < groupMenberNumber; t++) {
            NSInteger index = k * groupMenberNumber - t;
            if (index >= 0 && index < length) {
                sum += data[index] * data[index] / 2;
            }
        }
        
        for (NSInteger t = 0; t < groupMenberNumber; t++) {
            NSInteger index = (k + 1) * groupMenberNumber + t;
            if (index >= 0 && index < length) {
                sum += data[index] * data[index] / 2;
            }
        }
        
        float value = sqrtf(sum / groupMenberNumber / 3);
        value = MAX(logf(value) + 6 ,0);
        
        maxC = MAX(maxC, value);
        
        float oldHeight = currentData[k];
        float newHeight = MAX(value / maxValue * 150.0f, 1);
        
        currentData[k] = newHeight * 0.5 + oldHeight * 0.5;
    }
    
    currentLength = length;
}

#pragma mark - IPMusicViewDelegate
- (float *)data
{
    return currentData;
}

- (NSInteger)groupCount
{
    return groupCount;
}

@end
