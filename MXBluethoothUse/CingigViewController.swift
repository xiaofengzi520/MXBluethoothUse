//
//  CingigViewController.swift
//  MXBluethoothUse
//
//  Created by 牟潇 on 16/1/14.
//  Copyright © 2016年 muxiao. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation
class CingigViewController: UIViewController,CBPeripheralManagerDelegate {

    @IBOutlet weak var identityLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var UDIDLabel: UILabel!
    var beaconRegion: CLBeaconRegion! // CLBeaconRegin 属性，用来设置基站需要的 proximityUUID ，major 和 minor 的给你信息。
    var beaconPeripheralData: NSDictionary! // NSDictionary 的属性，用来获取外设的数据。
    var peripheralManager : CBPeripheralManager! //CBPeripheralManager 的属性，用来开启基站的数据传输。
    func initBeacon(){
        self.beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString:"E7CC6536-28B6-4FB9-88F1-1FE430B606C1")!, major: 1, minor: 1, identifier: "com.mybeacon.region" ) //uuid通过终端uuidgen命令生成
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initBeacon()
        self.setLabels()

        // Do any additional setup after loading the view.
    }
    //点击之后开始使用蓝牙外设发出信号
    @IBAction func transmitAction(sender: UIButton) {
       self.beaconPeripheralData = self.beaconRegion.peripheralDataWithMeasuredPower(nil)
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil);
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        if peripheral.state == CBPeripheralManagerState.PoweredOn{
            print("Powered on")
            self.peripheralManager.startAdvertising(self.beaconPeripheralData as? [String:AnyObject])
        }
        else if peripheral.state == CBPeripheralManagerState.PoweredOff{
            print("Powerd off")
            self.peripheralManager.stopAdvertising()
        }
    }
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        
        
        
        
    }
    func setLabels(){
        self.UDIDLabel.text = self.beaconRegion.proximityUUID.UUIDString;
        self.majorLabel.text = self.beaconRegion.major?.stringValue;
        self.minorLabel.text = self.beaconRegion.minor?.stringValue;
        self.identityLabel.text = self.beaconRegion.identifier
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
