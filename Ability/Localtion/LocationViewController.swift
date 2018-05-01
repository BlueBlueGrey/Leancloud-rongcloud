//
//  LocationViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/4/30.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class LocationViewController: UIViewController ,CLLocationManagerDelegate {
    
    var textView: UITextView?
    var lat:CLLocationDegrees=0
    var longi:CLLocationDegrees=0
    override func viewDidLoad() {
        super.viewDidLoad()
        textView=UITextView(frame: self.view.frame)
        textView?.backgroundColor=UIColor.red
        self.view.backgroundColor=UIColor.blue
        self.view.addSubview(textView!)
        
        
        print("sadfds\n\n \(lat)")
        
       print("sadfds\n\n  \(longi)")
        reverseGeocode()
    }
    
    //地理信息反编码
    func reverseGeocode(){
        let geocoder = CLGeocoder()
      
  
        let currentLocation = CLLocation(latitude:lat, longitude:longi)
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            //强制转成简体中文
            let array = NSArray(object: "zh-hans")
            UserDefaults.standard.set(array, forKey: "AppleLanguages")
            //显示所有信息
            if error != nil {
                //print("错误：\(error.localizedDescription))")
                self.textView?.text = "错误：\(error!.localizedDescription))"
                return
            }
            
            if let p = placemarks?[0]{
                print(p) //输出反编码信息
                var address = ""
                
                if let country = p.country {
                    address.append("国家：\(country)\n")
                }
                if let administrativeArea = p.administrativeArea {
                    address.append("省份：\(administrativeArea)\n")
                }
                if let subAdministrativeArea = p.subAdministrativeArea {
                    address.append("其他行政区域信息（自治区等）：\(subAdministrativeArea)\n")
                }
                if let locality = p.locality {
                    address.append("城市：\(locality)\n")
                }
                if let subLocality = p.subLocality {
                    address.append("区划：\(subLocality)\n")
                }
                if let thoroughfare = p.thoroughfare {
                    address.append("街道：\(thoroughfare)\n")
                }
                if let subThoroughfare = p.subThoroughfare {
                    address.append("门牌：\(subThoroughfare)\n")
                }
                if let name = p.name {
                    address.append("地名：\(name)\n")
                }
                if let isoCountryCode = p.isoCountryCode {
                    address.append("国家编码：\(isoCountryCode)\n")
                }
                if let postalCode = p.postalCode {
                    address.append("邮编：\(postalCode)\n")
                }
                if let areasOfInterest = p.areasOfInterest {
                    address.append("关联的或利益相关的地标：\(areasOfInterest)\n")
                }
                if let ocean = p.ocean {
                    address.append("海洋：\(ocean)\n")
                }
                if let inlandWater = p.inlandWater {
                    address.append("水源，湖泊：\(inlandWater)\n")
                }
                
                self.textView?.text = address
            } else {
                print("No placemarks!")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
