//
//  IPBikeViewController.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/15.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPBikeViewController.h"

@interface IPBikeViewController ()

@property(nonatomic, strong) NSArray *bikeStationArray;

@end

@implementation IPBikeViewController

#pragma mark - Init
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [IPNetWorkAPI taipeiBikeCompletionBlock:^(NSDictionary *responseObject) {
        self.bikeStationArray = responseObject[@"result"][@"results"];
        
        //NSLog(@"%@",responseObject);
    }];
    
    MKCoordinateRegion region;
    region.center.latitude = 25.040772;
    region.center.longitude = 121.543802;
    MKCoordinateSpan span;
    span.latitudeDelta  = .002;
    span.longitudeDelta = .002;
    region.span = span;
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - Setter / Getter
- (void)setBikeStationArray:(NSArray *)bikeStationArray
{
    _bikeStationArray = bikeStationArray;
    [self.mapView addAnnotations:self.bikeStationArray];
}

#pragma mark - MKMapViewDelegate
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView
                     viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *MyAnnotationIdentifier = @"myAnnotation";
    MKPinAnnotationView *pinView =
    (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:MyAnnotationIdentifier];
    
    if (!pinView){
        pinView =
        [[MKPinAnnotationView alloc]initWithAnnotation:annotation
                                        reuseIdentifier:MyAnnotationIdentifier];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
    }
    
    NSDictionary *dict = (NSDictionary *)annotation;
    NSInteger number = [dict[@"sbi"] integerValue];
    NSInteger fullNumber = [dict[@"tot"] integerValue];
    
    if (number > 1) {
        pinView.pinColor = MKPinAnnotationColorGreen;
    }
    else if (number == 0){
        pinView.pinColor = MKPinAnnotationColorRed;
    }
    else if (number == fullNumber){
        pinView.pinColor = MKPinAnnotationColorPurple;
    }

    return pinView;
}

//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
//{
//    NSDictionary *dict = (NSDictionary *)view.annotation;
//    NSLog(@"%@",dict[@"sna"]);
//}

@end

@implementation NSDictionary(MKAnnotation)

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self[@"lat"] floatValue];
    coordinate.longitude =  [self[@"lng"] floatValue];
    return coordinate;
}

- (NSString *)title
{
    return self[@"sna"];
}

- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"%@/%@",self[@"sbi"],self[@"tot"]];
}

@end
