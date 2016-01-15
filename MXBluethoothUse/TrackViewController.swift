//
//  TrackViewController.swift
//  MXBluethoothUse
//
//  Created by 牟潇 on 16/1/14.
//  Copyright © 2016年 muxiao. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation
class TrackViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var RSSLLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var MajorLabel: UILabel!
    @IBOutlet weak var UDIDLabel: UILabel!
    @IBOutlet weak var iBeaconLabel: UILabel!
    var beaconRegion:CLBeaconRegion! //CLBeaconRegion属性是用来定义我们要寻找的beacon的。这个app只会接收到有同样的UUID的的发射机发射的信号。
    var trackLocationManager :CLLocationManager! //CLLocationManager属性是用来建立位置服务并搜索beacon的。
    override func viewDidLoad() {
        super.viewDidLoad()
        self.trackLocationManager = CLLocationManager();
        self.trackLocationManager.delegate = self;
        self.initRegion()
        self.locationManager(self.trackLocationManager, didStartMonitoringForRegion: self.beaconRegion)
        // Do any additional setup after loading the view.
    }
    func initRegion(){
        self.beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString:"E7CC6536-28B6-4FB9-88F1-1FE430B606C1")!, identifier: "com.mybeacon.region")
        self.trackLocationManager.startMonitoringForRegion(self.beaconRegion)

    }
    
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        self.trackLocationManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        self.trackLocationManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        self.trackLocationManager.stopMonitoringForRegion(self.beaconRegion)
        self.iBeaconLabel.text = "No"
    }
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        print("beacons count" + String(beacons.count))
        if beacons.count <= 0{
            return
        }
        let beacon:AnyObject = beacons[beacons.count - 1]
        self.iBeaconLabel.text = "Yes"
        self.UDIDLabel.text = beacon.proximityUUID!.UUIDString
        self.MajorLabel.text = beacon.major!!.stringValue
        self.minorLabel.text = beacon.minor!!.stringValue
        self.accuracyLabel.text = String(beacon.accuracy)
        if (beacon.proximity != nil){
            switch(beacon.proximity!){
            case .Unknown:
                self.distanceLabel.text = "Unkown"
            case CLProximity.Immediate:
                self.distanceLabel.text = "Immediate"
            case CLProximity.Near:
                self.distanceLabel.text = "Near"
            case CLProximity.Far:
                self.distanceLabel.text = "far"
            default:
                print("default")
            }
        }
        self.RSSLLabel.text = beacon.rssi.description
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
