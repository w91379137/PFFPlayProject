//
//  IPNavigationViewController.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPNavigationViewController.h"
#import "IPNavigationViewController+BackGround.h"

#import "IPMenuTableViewCell.h"
#import "IPMenuCollectionViewCell.h"

#import "IPHomeViewController.h"
#import "IPFoodViewController.h"
#import "IPBikeViewController.h"
#import "IPMusicViewController.h"
#import "IPVideoViewController.h"

static const NSString *actionIconString = @"actionIconString";
static const NSString *actionTitleString = @"actionTitleString";
static const NSString *actionViewControllerClass = @"actionViewControllerClass";
//static const NSString *actionBlock = @"actionBlock";

@interface IPNavigationViewController ()
{
    NSTimer *timer;
    NSMutableArray *actionArray;
}

@end

@implementation IPNavigationViewController

#pragma mark - Init
- (instancetype)initWithHome
{
    IPHomeViewController *vc =
    [[IPHomeViewController alloc] init];
    
    return [self initWithRootViewController:vc];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.navigationBarHidden = YES;
        
        actionArray = [NSMutableArray array];
        
        float fontSize = 20;
        {
            [actionArray addObject:
             @{actionIconString :
                   [self attributedStringFromFontAwesome:
                    [FAKFontAwesome homeIconWithSize:fontSize]],
               actionTitleString : @"城市",
               actionViewControllerClass : NSStringFromClass([IPHomeViewController class])
               }];
        }
        {
            [actionArray addObject:
             @{actionIconString :
                   [self attributedStringFromFontAwesome:
                    [FAKFontAwesome cutleryIconWithSize:fontSize]],
               actionTitleString : @"食物",
               actionViewControllerClass : NSStringFromClass([IPFoodViewController class])
               }];
        }
        {
            [actionArray addObject:
             @{actionIconString :
                   [self attributedStringFromFontAwesome:
                    [FAKFontAwesome bicycleIconWithSize:fontSize]],
               actionTitleString : @"交通",
               actionViewControllerClass : NSStringFromClass([IPBikeViewController class])
               }];
        }
        {
            [actionArray addObject:
             @{actionIconString :
                   [self attributedStringFromFontAwesome:
                    [FAKFontAwesome musicIconWithSize:fontSize]],
               actionTitleString : @"音樂",
               actionViewControllerClass : NSStringFromClass([IPMusicViewController class])
               }];
        }
        {
            [actionArray addObject:
             @{actionIconString :
                   [self attributedStringFromFontAwesome:
                    [FAKFontAwesome videoCameraIconWithSize:fontSize]],
               actionTitleString : @"影片",
               actionViewControllerClass : NSStringFromClass([IPVideoViewController class])
               }];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.containerView) {
        if ([[NSBundle mainBundle] pathForResource:NSStringFromClass([self class])
                                            ofType:@"nib"]) {
            
            [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                          owner:self
                                        options:nil];
        }
    }
    
    if (!self.containerView.superview) {
        [self.view addSubview:self.containerView];
        [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        self.containerView.alpha = 0;
        self.isMenuShow = self.isMenuShow;
    }
    
    {
        [self.mainTableView registerClass:[IPMenuTableViewCell class]
                   forCellReuseIdentifier:cellReuseIdentifier];
    }
    {
        [self.mainCollectionView registerClass:[IPMenuCollectionViewCell class]
                    forCellWithReuseIdentifier:cellReuseIdentifier];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createBgImage];
}

#pragma mark - Data
- (NSAttributedString *)attributedStringFromFontAwesome:(FAKFontAwesome *)fontAwesome
{
    [fontAwesome addAttribute:NSForegroundColorAttributeName
                        value:[UIColor blackColor]];
    return [fontAwesome attributedString];
}

#pragma mark - IBAction
- (IBAction)closeAction:(id)sender
{
    self.isMenuShow = NO;
}

#pragma mark - Setter / Getter
- (void)setIsMenuShow:(BOOL)isMenuShow
{
    _isMenuShow = isMenuShow;
    //self.sideBarView.layer.shadowOpacity = _isMenuShow ? 0.8 : 0;
    //self.sideBarView.layer.shadowRadius = 7;
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         
                         self.closeButton.alpha = _isMenuShow ? 1 : 0;
                         {
                             self.clockView.transform = _isMenuShow ?
                             CGAffineTransformIdentity :
                             CGAffineTransformTranslate(CGAffineTransformIdentity, -150, -150);
                             
                             self.clockView.alpha = _isMenuShow ? 1 : 0;
                         }
                         
                         {
                             self.leftContainerView.transform = _isMenuShow ?
                             CGAffineTransformIdentity :
                             CGAffineTransformTranslate(CGAffineTransformIdentity, -150, 0);
                             
                             self.leftContainerView.alpha = _isMenuShow ? 1 : 0;
                         }
                         {
                             self.topContainerView.transform = _isMenuShow ?
                             CGAffineTransformIdentity :
                             CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -75);
                             
                             self.topContainerView.alpha = _isMenuShow ? 1 : 0;
                         }
                     } completion:^(BOOL finished) {
                        self.containerView.alpha = 1;
                     }];
    
    if (!timer && _isMenuShow) {
        timer =
        [NSTimer scheduledTimerWithTimeInterval:0.25
                                         target:self.clockView
                                       selector:@selector(setCurrentTime)
                                       userInfo:nil
                                        repeats:YES];
        [timer fire];
    }
    else if (timer && !_isMenuShow) {
        [timer invalidate];
        timer = nil;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return actionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IPMenuTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    [self cellForActionDict:maybe(actionArray[indexPath.row], NSDictionary)
                       Cell:cell];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)       tableView:(UITableView *)tableView
 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectActionDict:maybe(actionArray[indexPath.row], NSDictionary)];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return actionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IPMenuCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier
                                              forIndexPath:indexPath];
    [self cellForActionDict:maybe(actionArray[indexPath.row], NSDictionary)
                       Cell:cell];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)   collectionView:(UICollectionView *)collectionView
 didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectActionDict:maybe(actionArray[indexPath.row], NSDictionary)];
}

#pragma mark - 公用
- (void)cellForActionDict:(NSDictionary *)infoDict Cell:(id<IPMenuCellProtocol>)cell
{
    cell.iconLabel.attributedText =
    maybe(infoDict[actionIconString], NSAttributedString);
    
    cell.titleLabel.text =
    maybe(infoDict[actionTitleString], NSString);
}

- (void)selectActionDict:(NSDictionary *)infoDict
{
    NSString *className =
    maybe(infoDict[actionViewControllerClass], NSString);
    
    if (className) {
        Class class =
        NSClassFromString(className);
        
        NSString *rootViewControllerClassName =
        NSStringFromClass([self.viewControllers.firstObject class]);
        
        if (![rootViewControllerClassName isEqualToString:className] &&
            [class isSubclassOfClass:[UIViewController class]]) {
            
            [self setViewControllers:@[[[class alloc] init]]
                            animated:YES];
        }
    }
    
    [self closeAction:nil];
}

@end
