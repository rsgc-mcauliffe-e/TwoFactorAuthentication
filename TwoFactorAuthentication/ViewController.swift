//
//  ViewController.swift
//  TwoFactorAuthentication
//
//  Created by   on
//  Copyright © 2017  . All rights reserved.
//

import UIKit
import CryptoSwift
var accounts = ["Test"]

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		print("about to load view")
		let message = "Hey, did this work?"
		
		print(message.sha1())
		
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return accounts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellIdentifier = "Cell"
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
		cell.textLabel?.text = accounts[indexPath.row]
		
		return cell
		
	}
	
	
}

