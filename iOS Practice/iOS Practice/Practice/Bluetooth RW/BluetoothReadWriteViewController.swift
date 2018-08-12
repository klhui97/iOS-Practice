//
//  BluetoothReadWriteViewController.swift
//  iOS Practice
//
//  Created by KL on 12/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import CoreBluetooth

class BluetoothReadWriteViewController: UIViewController {
    
    // MARK: - View
    let loggingTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    let container = UIView()
    
    // MARK: - Variable
    let deviceName = "SmartPlant\r\n"
    
    // MARK: - Init
    var centralManager: CBCentralManager?
    var peripheral: CBPeripheral? {
        didSet{
            peripheral?.delegate = self
            if peripheral != nil{
                centralManager?.connect(peripheral!)
            }
            
        }
    }
    var characteristic: CBCharacteristic?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let centralQueue: DispatchQueue = DispatchQueue(label: "com.iosbrain.centralQueueName", attributes: .concurrent)
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
        
        view.backgroundColor = .white
        setupAutoLayout()
    }
    
    // MARK: - View config
    private func setupAutoLayout() {
        view.add(container)
        NSLayoutConstraint.activate([container.topAnchor.constraint(equalTo: view.safeTopAnchor), container.bottomAnchor.constraint(equalTo: view.safeBottomAnchor), container.leftAnchor.constraint(equalTo: view.safeLeftAnchor), container.rightAnchor.constraint(equalTo: view.safeRightAnchor)])
        
        container.add(loggingTextView)
        let views = ["loggingTextView": loggingTextView]
        loggingTextView.backgroundColor = .yellow
        loggingTextView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.5).isActive = true
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|[loggingTextView]|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[loggingTextView]|", options: [], metrics: nil, views: views))
    }
    
    private func logMessage(_ text: String?) {
        DispatchQueue.main.async { () -> Void in
            self.loggingTextView.text = (text ?? "") + "\n" + (self.loggingTextView.text ?? "")
        }
    }
}

extension BluetoothReadWriteViewController: CBCentralManagerDelegate{
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            logMessage("Bluetooth status is UNKNOWN")
        case .resetting:
            logMessage("Bluetooth status is RESETTING")
        case .unsupported:
            logMessage("Bluetooth status is UNSUPPORTED")
        case .unauthorized:
            logMessage("Bluetooth status is UNAUTHORIZED")
        case .poweredOff:
            logMessage("Bluetooth status is POWERED OFF")
        case .poweredOn:
            logMessage("Bluetooth status is POWERED ON")
            DispatchQueue.main.async {
                self.centralManager?.scanForPeripherals(withServices: nil)
            }
            return
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if deviceName == peripheral.name{
            self.peripheral = peripheral
            logMessage("Connected to \(deviceName)")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        DispatchQueue.main.async { () -> Void in
            peripheral.discoverServices(nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        logMessage("Disconnected to \(peripheral.name ?? "")")
        DispatchQueue.main.async { () -> Void in
            self.peripheral = nil
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
}

extension BluetoothReadWriteViewController: CBPeripheralDelegate{
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if ((error) != nil) {
            logMessage("Error discovering services: \(error!.localizedDescription)")
            return
        }
        
        guard let services = peripheral.services else {
            return
        }
        if let service = services.last{
            logMessage("Found Service: \(service)")
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if ((error) != nil) {
            logMessage("Error discovering services: \(error!.localizedDescription)")
            return
        }
        
        guard let characteristics = service.characteristics else {
            return
        }
        
        logMessage("Found \(characteristics.count) characteristics!")
        for characteristic in characteristics {
            logMessage("Founded Characteristic: \(characteristic)")
            self.characteristic = characteristic
            peripheral.setNotifyValue(true, for: characteristic)
            //            peripheral.writeValue(Data(bytes: [14]), for: characteristic, type: CBCharacteristicWriteType.withoutResponse)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let err = error{
            logMessage("error: \(err)")
            return
        }
        
        guard let data = characteristic.value else {
            return
        }
        
        if let ASCIIstring = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            logMessage(ASCIIstring as String)
        }
    }
    
}
