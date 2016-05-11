//
//  IPBikeViewController.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/15.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPBasicViewController.h"
@import MapKit;

//http://furnacedigital.blogspot.tw/2011/01/map-view-pin.html

@interface IPBikeViewController : IPBasicViewController
<MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@end

@interface NSDictionary(MKAnnotation)<MKAnnotation>

@end