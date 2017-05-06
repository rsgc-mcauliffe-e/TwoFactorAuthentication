//
//  inputVCViewController.swift
//  TwoFactorAuthentication
//
//  Created by Ethan on 2017-05-06.
//  Copyright © 2017 Russell Gordon. All rights reserved.
//

import UIKit

class inputVC: UIViewController {
	
	@IBOutlet weak var sharedSecretKey: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	@IBAction func enterButton(_: Any) {
		let myVC = storyboard?.instantiateViewController(withIdentifier: "Code View") as! codeVC
		if sharedSecretKey.text != ""{
			myVC.base32Inputkey = sharedSecretKey.text!
		}
	}

}
