//
//  ViewController.swift
//  TwoFactorAuthentication
//
//  Created by   on
//  Copyright © 2017  . All rights reserved.
//

import UIKit
import CryptoSwift
var tableArray : [String] = ["Code: \t", "Time Remaining: \t"]

extension String {
	
	//new function added to String class that converts 8 digit long binary strings to unsigned 8 bit integers
	public func binaryToInteger() -> UInt8 {
		
		//initialize integerValue variable
		var integerValue = UInt8()
		
		//only return a result if the string is exactly 8 characters in length
		if self.characters.count / 8 == 1{
			
			//go through the string, LSB first, adding a power of 2 appropriate to the bit position each time
			for (index, bit) in self.characters.reversed().enumerated() {
				
				
				//only add the power of 2 if the bit is a 1
				if bit == "1" {
					
					//ensure power is casted to a UInt8 as the pow function returns a double
					integerValue += UInt8(round(pow(2, Double(index))))
				}
			}
		}
		
		//return "integerValue" variable
		return integerValue
	}
}

extension UInt64 {
	public func integerTo64BitBinary() -> String {
		var result = String(self, radix: 2)
		for _ in 1...(64-result.characters.count) {
			result = "0" + result
		}
		return result
	}
}

var base32Inputkey : String = "HXDMVJECJJWSRB3HWIZR4IFUGFTMXBOZ"



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	//MARK: Properties
	
	//MARK: Functions
	
	func authenticate(key: String) -> String {
		var base32Convert : [Character:String] = ["A" : "00000", "B" : "00001", "C" : "00010", "D" : "00011", "E" : "00100", "F" : "00101", "G" : "00110", "H" : "00111", "I" : "01000", "J" : "01001", "K" : "01010", "L" : "01011", "M" : "01100", "N" : "01101", "O" : "01110", "P" : "01111", "Q" : "10000", "R" : "10001", "S" : "10010", "T" : "10011", "U" : "10100", "V" : "10101", "W" : "10110", "X" : "10111", "Y" : "11000", "Z" : "11001", "2" : "11010", "3" : "11011", "4" : "11100", "5" : "11101", "6" : "11110", "7" : "11111" ]
		var binaryString = String()
		var base32BinaryByteStrings : [String] = [""]
		var decodedBase32 = Array<UInt8>()
		var inputKey = String()
		var timeHMACInput = Array<UInt8>()
		
		//get UNIX time/30 for the external input to the HMAC operation
		var timeString = UInt64((Date().timeIntervalSince1970)/30)
		
		//user input for shared secret key provided by 2FA service
		inputKey = key
		
		//secret keys are often provided in lower case to make it easier for a human to read & differentiate between characters. Unfortunately, proper base32 has no lower case, so we must make all characters uppercase
		
		inputKey = inputKey.uppercased()
		
		//take the characters in the base 32 string, convert to a 5 bit binary value and combine them all into a binary string
		for digit in inputKey.characters {
			binaryString.append(base32Convert[digit]!)
		}
		
		//now confirm that the length of the string is divisible by 8 (otherwise proper base 32 conversion will not work)
		if binaryString.characters.count % 8 == 0 {
			
			//create temporary variables that mark how many bytes have been iterated in the for loop
			var currentByte = 0
			
			//separates binary string into 8 bit binary string chunks
			for (index, bit) in binaryString.characters.enumerated() {
				
				//add current character in string to array at specified position
				base32BinaryByteStrings[currentByte].append(bit)
				
				
				//if a full byte has been filled and there are still bytes left, add an element to the array
				if index % 8 == 0 && index != binaryString.characters.count{
					currentByte += 1
					base32BinaryByteStrings += [""]
				}
			}
		} else {
			print("ERROR: NOT A FULL BASE 32 STRING")
		}
		
		//iterate through chunks of binary string and convert to UInt8 chunks
		for byteChunk in base32BinaryByteStrings {
			decodedBase32.append(byteChunk.binaryToInteger())
		}
		
		do {
			withUnsafeBytes(of: &timeString) { bytes in
				for byte in bytes {
					timeHMACInput = [byte] + timeHMACInput
				}
			}
		}
		
		var hashed = try! HMAC(key: timeHMACInput, variant: .sha1).authenticate(decodedBase32)
		
		let offset : Int = Int(hashed[19]) & Int(0xF) //offset = value of the last nibble of the hashed array
		
		var testCode = Int32()
		
		testCode |= Int32(hashed[offset] & 0x7F) << 24
		testCode |= Int32(hashed[offset + 1]) << 16
		testCode |= Int32(hashed[offset + 2]) << 8
		testCode |= Int32(hashed[offset + 3])
		
		var output: String = String(testCode%1000000)
		
		if (output.characters.count <= 5) {
			output.insert("0", at: output.startIndex)
		}
		
		output.insert(" ", at: output.index(output.startIndex, offsetBy: 3))
		
		return output
		
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		
		// Do any additional setup after loading the view, typically from a nib.
		let twoFactorCode = authenticate(key: base32Inputkey)
		tableArray[0] += (twoFactorCode)
		tableArray[1] += (String(Int(Date().timeIntervalSince1970) % 30) + "s")
		
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
		print("?")
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableArray.count
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellIdentifier = "Cell"
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
		cell.textLabel?.text = tableArray[indexPath.row]
		
		return cell
		
	}
	
	//MARK: Actions
	

	
	
	
	//	override func viewDidAppear(_ animated: Bool) {
	//
	//		super.viewDidAppear(true)
	//		while(true){
	//			let twoFactorCode = authenticate(key: base32key)
	//			tableArray[0] = (twoFactorCode)
	//			tableArray[1] = (String(Int(Date().timeIntervalSince1970) % 30))
	//		}
	//	}
	
	
}


