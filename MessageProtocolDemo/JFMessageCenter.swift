//
//  JFMessageCenter.swift
//  MessageProtocolDemo
//
//  Created by JerryFans on 2023/11/8.
//

import UIKit

@objc protocol JFMessageProtocol: NSObjectProtocol {
    @objc optional func messageProtocol_testMethod()
}

class JFMessageCenter: NSObject {
    
    @objc dynamic static let shared = JFMessageCenter()
    
    private var pushClients = NSHashTable<AnyObject>.weakObjects()
    
    @objc func obs(with target: AnyObject) {
        self.pushClients.add(target)
    }
    
    //因为是弱引用，不手动调用也没事
    @objc func removeObs(with target: AnyObject) {
        self.pushClients.remove(target)
    }
    
    @objc public func sendMessage(selector: Selector ,completion: @escaping (JFMessageProtocol) -> Void) {
        for client in self.pushClients.allObjects {
            if client.responds(to: selector), let client = client as? JFMessageProtocol {
                print("receive message")
                if Thread.current != .main {
                    DispatchQueue.main.async {
                        completion(client)
                    }
                } else {
                    completion(client)
                }
            }
        }
    }
}

