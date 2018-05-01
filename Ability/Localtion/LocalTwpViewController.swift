//
//  LocalTwpViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/4/30.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import CoreLocation

class LocalTwpViewController: UIViewController , CLLocationManagerDelegate {
    
    //定位管理器
    let locationManager:CLLocationManager = CLLocationManager()
    
    var label1: UILabel?
    var label2: UILabel?
    var label3: UILabel?
    var label4: UILabel?
    var label5: UILabel?
    var label6: UILabel?
    var label7: UILabel?
    
    var butn:UIButton?
    var lat:CLLocationDegrees?
    var longi:CLLocationDegrees?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.blue
        label1=UILabel(frame: CGRect(x: 30, y: 330, width: 200, height: 50))
       
        self.view.addSubview(label1!)
        
        label2=UILabel(frame: CGRect(x: 30, y: 80, width: 200, height: 50))
        self.view.addSubview(label2!)
        
        
        label3=UILabel(frame: CGRect(x: 30, y: 130, width: 200, height: 50))
        self.view.addSubview(label3!)
        
        label4=UILabel(frame: CGRect(x: 30, y: 180, width: 200, height: 50))
        self.view.addSubview(label4!)
        
        label5=UILabel(frame: CGRect(x: 30, y: 230, width: 200, height: 50))
        self.view.addSubview(label5!)
        
        label6=UILabel(frame: CGRect(x: 30, y: 280, width:200, height: 50))
        
    
        self.view.addSubview(label6!)
        
         label1?.backgroundColor=UIColor.red
         label2?.backgroundColor=UIColor.red
         label3?.backgroundColor=UIColor.red
         label4?.backgroundColor=UIColor.red
         label5?.backgroundColor=UIColor.red
         label6?.backgroundColor=UIColor.red
        
        //设置定位服务管理器代理
        locationManager.delegate = self
        //设置定位进度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        locationManager.distanceFilter = 100
        ////发送授权申请
        locationManager.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled())
        {
            //允许使用定位服务的话，开启定位服务更新
            locationManager.startUpdatingLocation()
            print("定位开始")
        }
        
        butn=UIButton(frame: CGRect(x: 50, y: 50, width: 500, height: 50))
        butn?.setTitle("定位", for: .normal)
        
        self.view.addSubview(butn!)
        
        butn?.addTarget(self, action: #selector(click), for: .touchUpInside)
        
    }
    
    //定位改变执行，可以得到新位置、旧位置
    
    
    @objc func click(){
        
        
        let vc=LocationViewController()
        vc.lat=self.lat!
        vc.longi=self.longi!
      
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
   
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        //获取最新的坐标
        let currLocation:CLLocation = locations.last!
        label1?.text = "经度：\(currLocation.coordinate.longitude)"
        longi = currLocation.coordinate.longitude
        //获取纬度
        label2?.text = "纬度：\(currLocation.coordinate.latitude)"
        lat = currLocation.coordinate.latitude
        //获取海拔
        label3?.text = "海拔：\(currLocation.altitude)"
        //获取水平精度
        label4?.text = "水平精度：\(currLocation.horizontalAccuracy)"
        //获取垂直精度
        label5?.text = "垂直精度：\(currLocation.verticalAccuracy)"
        //获取方向
        label6?.text = "方向：\(currLocation.course)"
        //获取速度
        label7?.text = "速度：\(currLocation.speed)"
        
    }
   
}
