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
		if (sharedSecretKey.text?.characters.count)! % 16 == 0 && (sharedSecretKey.text?.characters.count)! != 0{
			myVC.base32Inputkey = sharedSecretKey.text!
		} else {
			showAlertButtonTapped()
		}
	}
	
	@IBAction func showAlertButtonTapped() {
		
		// create the alert
		let alert = UIAlertController(title: "ERROR", message: "Code must have \n a multiple of 16 characters", preferredStyle: UIAlertControllerStyle.alert)
		
		// add an action (button)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
		
		// show the alert
		self.present(alert, animated: true, completion: nil)
	}
	
}
