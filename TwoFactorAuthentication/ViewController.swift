//
//  ViewController.swift
//  TwoFactorAuthentication
//
//  Created by   on
//  Copyright © 2017  . All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("about to load view")
        let message = "Hey, did this work?"
        
        print(message.md5())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

