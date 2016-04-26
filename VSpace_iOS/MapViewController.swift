//
//  MapViewController.swift
//  VSpace
//
//  Created by 李昂 on 15/9/12.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

import UIKit

enum SchoolMapMode {
    case Nanhu
    case Hunnan
}

enum NanhuBuildings {
    case Nanhu
    case DaCheng
    case HeShiLi
    case YiFu
    case CaiKuang
    case YeJin
    case JianZhu
    case JiDian
    case XinXi
    case NingEnCheng
    case ZongHe
    case JiSuan
    case ZhiXing
    case ShuangXin
    case DaHuo
    case LiuChangChun
    case YouYong
    case Dorm1
    case Dorm2
    case Dorm3
    case Dorm4
    case Dorm5
    case Dorm6
    case Dorm7
    case Dorm8
    case Dorm9
    case Dorm10
    case Restaurant1
    case Restaurant2
    case CanYinZhongXin
    case Restaurant9
    case HuiMinRestaurant
    case NewShower
    case OldShower
    case May4Stadium
    case May5Stadium
}

enum HunnanBuildings {
    case Hunnan
    case WenGuanA
    case WenGuanB
    case JianZhuLouA
    case JianZhuLouB
    case XinXiKeXueLouA
    case XinXiKeXueLouB
    case ShengMingKeXueLouA
    case ShengMingKeXueLouB
    case Library
    case StudentServiceCenter
    case Shower
    case Dorm1
    case Dorm2
    case Dorm3
}

class MapViewController: VSpaceOutViewController, MAMapViewDelegate {
    let apikey="1e5a8099f206e870aee3c7d17df710e5"
    var mapView:MAMapView=MAMapView(frame: CGRectMake(0, 94, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-134))
    var SchoolSwitchView:UIView=UIView(frame: CGRectMake(0, 64, UIScreen.mainScreen().bounds.width, 30))
    var SchMapMode:SchoolMapMode=SchoolMapMode.Nanhu
    //var SatelliteLabel:UILabel?
    //var IsSatelliteSwitch:UISwitch?
    @IBOutlet var NanhuLabel: UILabel!
    @IBOutlet var HunnanLabel: UILabel!
    @IBOutlet var MapLabel: UILabel!
    var IsSchoolMapModeColor:UIColor=UIColor(red: 11/255, green: 96/255, blue: 254/255, alpha: 1)
    
    // 南湖教学楼坐标
    // 南湖校区
    let NanhuLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.429477, 41.767193)
    // 大成教学馆
    let DaChengLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.421177, 41.763818)
    // 何世礼教学馆
    let HeShiLiLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.417551, 41.76467)
    // 逸夫教学馆
    let YiFuLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.41688, 41.764038)
    // 采矿
    let CaiKuangLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.420941, 41.766655)
    // 冶金
    let YeJinLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.421215, 41.76511)
    // 建筑
    let JianZhuLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.418044, 41.766895)
    // 机电
    let JiDianLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.417331, 41.765338)
    // 信息
    let XinXiLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.419611, 41.768387)
    // 宁恩承
    let NingEnChengLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.419461, 41.767015)
    // 综合
    let ZongHeLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.419187, 41.764566)
    // 计算
    let JiSuanLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.41776, 41.767671)
    // 知行
    let ZhiXingLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.422771, 41.762921)
    // 双馨
    let ShuangXinLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.417369, 41.768851)
    // 大活
    let DaHuoLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.417937, 41.764078)
    // 刘长春
    let LiuChangChunLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.423194, 41.765794)
    // 游泳
    let YouYongLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.421912, 41.767383)
    // 一舍
    let Dormitory1Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.419825, 41.76329)
    // 二舍
    let Dormitory2Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.418458, 41.763366)
    // 三舍
    let Dormitory3Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.421537, 41.761909)
    // 四舍
    let Dormitory4Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.417551, 41.762501)
    // 五舍
    let Dormitory5Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.418087, 41.761969)
    // 六舍
    let Dormitory6Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.414086, 41.766599)
    // 七舍
    let Dormitory7Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.419434, 41.761877)
    // 八舍
    let Dormitory8Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.412884, 41.767087)
    // 九舍
    let Dormitory9Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.412551, 41.765402)
    // 十舍
    let Dormitory10Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.412642, 41.764298)
    // 一舍食堂
    let Restaurant1Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.420539, 41.763045)
    // 二舍食堂
    let Restaurant2Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.417497, 41.763193)
    // 餐饮中心
    let CanYinZhongXinLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.418216, 41.762185)
    // 九舍食堂
    let Restaurant9Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.41246, 41.765418)
    // 回民食堂
    let HuiMinRestaurantLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.420163, 41.762377)
    // 新澡堂
    let NewShowerLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.413587, 41.76433)
    // 旧澡堂
    let OldShowerLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.420421, 41.762353)
    // 五四体育场
    let May4StadiumLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.423414, 41.767715)
    // 五五体育场
    let May5StadiumLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.414064, 41.76533)
    
    // 浑南教学楼坐标
    // 浑南校区
    let HunnanLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.419685, 41.655008)
    // 文管A
    let WenGuanALocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.423007, 41.654477)
    // 文管B
    let WenGuanBLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.422256, 41.654044)
    // 建筑楼A
    let JianZhuLouALocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.423135, 41.655664)
    // 建筑楼B
    let JianZhuLouBLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.422256, 41.656096)
    // 信息科学楼A
    let XinXiKeXueLouALocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.426225, 41.655647)
    // 信息科学楼B
    let XinXiKeXueLouBLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.426869, 41.656032)
    // 生命科学楼A
    let ShengMingKeXueLouALocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.426332, 41.654525)
    // 生命科学楼B
    let ShengMingKeXueLouBLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.426869, 41.65398)
    // 图书馆
    let Hunnan_LibraryLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.424723, 41.65507)
    // 学生服务中心
    let StudentServiceCenterLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.421676, 41.652136)
    // 澡堂
    let Hunnan_ShowerLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.421011, 41.652056)
    // 一舍
    let Hunnan_Dormitory1Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.421762, 41.651222)
    // 二舍
    let Hunnan_Dormitory2Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.419917, 41.651158)
    // 三舍
    let Hunnan_Dormitory3Location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(123.419852, 41.652184)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 接入高德地图
        MAMapServices.sharedServices().apiKey=apikey
        // 地图显示浑南或南湖
        if NanhuLabel.textColor == IsSchoolMapModeColor {
            mapView.centerCoordinate=NanhuLocation
        }
        else {
            mapView.centerCoordinate=HunnanLocation
        }
        mapView.delegate=self
        
        self.view.addSubview(mapView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
