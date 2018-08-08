//
//  ViewController.swift
//  GCDSamples
//
//  Created by Gabriel Theodoropoulos on 07/11/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let queue = DispatchQueue(label: "unique identifier")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // simpleQueues()
        
        // queuesWithQoS()
        
        // concurrentQueues()
        
         concurrentQueues()
         if let queue = inactiveQueue {
            queue.activate()
         }
        
        
        // queueWithDelay()
        
        // fetchImage()
        
        // useWorkItem()
    }
    
    
    
    func simpleQueues() {
        /*
        queue.sync {
            for i in 0...10{
                print("🔴", i)
            }
            
            for i in 0...10{
                print("🔵", i)
            }
        }
        
        for i in 100...110{
            print(i)
        }
         */
        
        /*
         queue.async {
         for i in 0...10{
         print("🔴", i)
         }
         
         for i in 0...10{
         print("🔵", i)
         }
         }
         
         for i in 100...110{
         print(i)
         }
         */
    }
    
    
    func queuesWithQoS() {
        /*
        let queue1 = DispatchQueue(label: "com.piyush.queue1", qos: DispatchQoS.userInteractive)
        let queue2 = DispatchQueue(label: "com.piyush.queue2", qos: DispatchQoS.utility)
        
        queue1.async {
            for i in 1...10{
                print("🔴",i)
            }
        }
        
        queue2.async {
            for i in 1...10{
                print("🔵",i)
            }
        }
        for i in 100...110{
            print("🔷",i)
        }
        */
    }
    
    
    var inactiveQueue: DispatchQueue!
    func concurrentQueues() {
        
        /*
         
        // This is serial as in sense of a single queue
        let queue1 = DispatchQueue(label: "com.piyush.xyz", qos: DispatchQoS.default)
        
        queue1.async {
            for i in 1...10{
                print("🔵",i)
            }
        }
        queue1.async {
            for i in 1...10{
                print("🔴",i)
            }
        }
        queue1.async {
            for i in 100...110{
                print("🔷",i)
            }
        }
        
        */
        
        /*
        let queue2 = DispatchQueue(label: "com.piyush.abc", qos: .default, attributes: .concurrent)
        
        queue2.async {
            for i in 1...10{
                print("🔵",i)
            }
        }
        queue2.async {
            for i in 1...10{
                print("🔴",i)
            }
        }
        queue2.async {
            for i in 100...110{
                print("🔷",i)
            }
        }
        */
        
        /*
        let tempQueue = DispatchQueue(label: "SerialQwithAsyncWorkObjects", qos: DispatchQoS.default, attributes: .initiallyInactive)
        
        inactiveQueue = tempQueue
        inactiveQueue.async {
            for i in 1...10{
                print("🔵",i)
            }
        }
        
        inactiveQueue.async {
            for i in 1...10{
                print("🔴",i)
            }
        }
        
        inactiveQueue.async {
            for i in 100...110{
                print("🔷",i)
            }
        }
        
        */
        
        let tempQueue = DispatchQueue(label: "SerialQwithAsyncWorkObjects", qos: DispatchQoS.default, attributes: [.concurrent , .initiallyInactive])
        
        inactiveQueue = tempQueue
        inactiveQueue.async {
            for i in 1...10{
                print("🔵",i)
            }
        }
        
        inactiveQueue.async {
            for i in 1...10{
                print("🔴",i)
            }
        }
        
        inactiveQueue.async {
            for i in 100...110{
                print("🔷",i)
            }
        }
    }
    
    
    func queueWithDelay() {
        
    }
    
    
    func fetchImage() {
        
    }
    
    
    func useWorkItem() {
        
    }
}

