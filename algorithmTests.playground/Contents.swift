import UIKit
import CryptoSwift

var base32Convert : [Character:String] = ["A" : "00000", "B" : "00001", "C" : "00010", "D" : "00011", "E" : "00100", "F" : "00101", "G" : "00110", "H" : "00111", "I" : "01000", "J" : "01001", "K" : "01010", "L" : "01011", "M" : "01100", "N" : "01101", "O" : "01110", "P" : "01111", "Q" : "10000", "R" : "10001", "S" : "10010", "T" : "10011", "U" : "10100", "V" : "10101", "W" : "10110", "X" : "10111", "Y" : "11000", "Z" : "11001", "2" : "11010", "3" : "11011", "4" : "11100", "5" : "11101", "6" : "11110", "7" : "11111" ]
var binaryString : String = ""
var base32BinaryByteStrings = [String]()

var key = "aoebjgedmihikr6qln56zvszfrh5rqh2"

//secret keys are provided in lower case to make it easier for a human to read  & differentiate between characters. Unfortunately, proper base32 has no lower case, so we must make all characters uppercase
key = key.uppercased()

let test = "JBSWY3DP"

//take the characters in the base 32 string, convert to a 5 bit binary value and combine them all into a binary string
for digit in test.characters {
	binaryString.append(base32Convert[digit]!)
}
print(binaryString)

//now confirm that the length of the string is divisible by 8 (otherwise proper base 32 conversion will not work)
if binaryString.characters.count % 8 == 0 {
	var iterationPositionInString = 0
	var currentByte = 0
	for bit in binaryString.characters {
		base32BinaryByteStrings[currentByte].append(bit)
		iterationPositionInString += 1
		if iterationPositionInString % 8 == 0 {
			currentByte += 1
		}
	}
} else {
	print("ERROR: NOT A FULL BASE 32 STRING")
}
print(base32BinaryByteStrings)