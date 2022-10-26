//
//  PhoneFormat.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/25/22.
//

import Foundation

extension String {
    func applyPatternOnNumbers(pattern: String = "(###) ###-####", replacementCharacter: Character = "#") -> String {
        // replace anything that's not 0-9 with ""
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0..<pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
