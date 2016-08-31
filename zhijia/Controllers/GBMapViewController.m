//
//  GBMapViewController.m
//  zhijia
//
//  Created by 童星 on 16/6/8.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBMapViewController.h"
#import <MapKit/MapKit.h>

@interface GBMapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) MKMapView *customMapView;
@property (nonatomic, strong) CLLocationManager *mgr;
@property (nonatomic, copy) NSString *locationString;
/**
 *  地理编码对象
 */
@property (nonatomic ,strong) CLGeocoder *geocoder;
@end

@implementation GBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customlizeNavigationBarBackBtn];
    self.navigationTitleLabel.text = @"当前位置";
    
    self.customMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        // 主动请求权限
        self.mgr = [[CLLocationManager alloc] init];
        _mgr.delegate=self;
        //设置定位精度
        _mgr.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        _mgr.distanceFilter=distance;
//        [_mgr startUpdatingLocation];


        [self.mgr requestAlwaysAuthorization];
    }
    self.customMapView.userTrackingMode = MKUserTrackingModeFollowWithHeading; // 跟踪用户并且获取方向
    
    // 设置不允许地图旋转
    self.customMapView.showsScale = YES;
    self.customMapView.rotateEnabled = NO;
    // 成为mapVIew的代理
    self.customMapView.delegate = self;
    [self.view addSubview:_customMapView];
}

#pragma mark -- MKMapViewDelegate

/*!
 *  @brief  每次更新到用户的位置就会调用,调用不平凡,只有位置改变才会调用
 *
 *  @param mapView      促发事件的控件
 *  @param userLocation 大头针模型
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    // 利用反地理编码获取位置之后设置标题
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placeMark = [placemarks firstObject];
        
        DLog(@"获取地理位置成功 name = %@ subLocality = %@, thoroughfare = %@", placeMark.name, placeMark.subLocality,placeMark.thoroughfare);
        userLocation.title = placeMark.name;
        userLocation.subtitle = placeMark.locality;
        if (placeMark.locality &&placeMark.subLocality && placeMark.thoroughfare) {
            self.locationString = [NSString stringWithFormat:@"%@%@%@", placeMark.locality, placeMark.subLocality, placeMark.thoroughfare];
        }else if (placeMark.locality &&placeMark.subLocality){
        
            self.locationString = [NSString stringWithFormat:@"%@%@", placeMark.locality, placeMark.subLocality];

        }else{
        
            self.locationString = [NSString stringWithFormat:@"%@", placeMark.locality];

        }
    }];
    
    // 移动地图到当前用户所在位置
    [self.customMapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    // 获取用户位置
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    // 指定经纬度的跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.000001, 0.000001);
    // 将用户当前的位置作为显示区域的中心点,并且指向需要显示的跨度范围
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    // 设置显示区域
    [self.customMapView setRegion:region animated:YES];
    
}

/*!
 *  @brief  每次添加大头针,就会调用(地图上有几个大头针就会调用几次)
 *
 *  @param mapView    地图
 *  @param annotation 大头针模型
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    // 如果返回nil,系统会按照自己默认的方式显示
    static NSString *identifier = @"anno";
    // 从缓存池中取
    // 1.注意:默认情况下MKAnnotationView是无法显示的,如果想自定义大头针可以使用MKAnnotationView的子类MKPinAnnotationView
    // 2.注意:如果是自定义大头针,默认情况点击大头针之后是不会显示标题的,需要我们自己手动设置显示
    MKPinAnnotationView *annoView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    // 如果没有创建一个新的
    if (annoView == nil) {
        annoView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
        
        // 设置大头针颜色
        annoView.pinColor = MKPinAnnotationColorGreen;
        // 设置大头针出现动画
        annoView.animatesDrop = YES;
        // 手动设置大头针标题是否显示
        annoView.canShowCallout = YES;
        // 设置大头针标题显示的偏移量
        //        annoView.calloutOffset = CGPointMake(0, 20);
        // 设置大头针辅助视图
        //    annoView.leftCalloutAccessoryView
        // 给大头针View设置数据
        annoView.annotation = annotation;
        
    }
    
    // 设置大头针图片, 如果是使用MKPinAnnotationView那么设置图片无效,因为系统内部会自动覆盖掉
    //    annoView.image = [UIImage imageNamed:@"11"];
    // 返回大头针view
    return annoView;
    
}

#pragma mark 根据地名确定地理坐标
-(void)getCoordinateByAddress:(NSString *)address{
    //地理编码
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark=[placemarks firstObject];
        
        CLLocation *location=placemark.location;//位置
        CLRegion *region=placemark.region;//区域
        NSDictionary *addressDic= placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
        //        NSString *name=placemark.name;//地名
        //        NSString *thoroughfare=placemark.thoroughfare;//街道
        //        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
        //        NSString *locality=placemark.locality; // 城市
        //        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
        //        NSString *administrativeArea=placemark.administrativeArea; // 州
        //        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
        //        NSString *postalCode=placemark.postalCode; //邮编
        //        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
        //        NSString *country=placemark.country; //国家
        //        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
        //        NSString *ocean=placemark.ocean; // 海洋
        //        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
        DLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);
    }];
}

#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        DLog(@"详细信息:%@",placemark.addressDictionary);
    }];
}

// 懒加载
- (CLGeocoder *)geocoder{
    
    if (!_geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- life cycle
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    self.locationBlock(self.locationString);
}

- (void)backAction{

    [self.navigationController popViewControllerAnimated:YES];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
