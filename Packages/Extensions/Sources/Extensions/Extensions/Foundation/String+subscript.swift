//
//  String+subscript.swift
//
//  Created by Ahmed Yamany on 25/10/2023.
//

import Foundation

extension String {
    /**
     Accesses the character at the specified index in the string.
     
     - Parameter index: The index of the character to access.
     - Returns: The character at the specified index.
     - Complexity: O(1)
     
     - Note: This subscript allows you to access individual characters in the string using an integer index.
            The index must be within the valid range of the string.
     
     - SeeAlso: `subscript(_:)`
     
     - Example:
     ```
     let str = "Hello"
     let char = str[1]
     // char is "e"
     ```
     */
    public subscript(_ index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }

    /**
     Accesses a substring of the string within the specified closed range of integer indices.
     
     - Parameter bounds: The closed range of indices to create a substring.
     - Returns: A substring of the original string within the specified bounds.
     - Complexity: O(n), where n is the size of the substring.
     
     - Note: This subscript allows you to create a substring of the string using a closed range of integer indices.
            The range must be within the valid range of the string.
     
     - SeeAlso: `subscript(bounds:)`
     
     - Example:
     ```
     let str = "Swift Programming"
     let substring = str[6...11]
     // substring is "Progra"
     ```
     */
    public subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    /**
     Accesses a substring of the string within the specified range of integer indices.
     
     - Parameter bounds: The range of indices to create a substring.
     - Returns: A substring of the original string within the specified bounds.
     - Complexity: O(n), where n is the size of the substring.
     
     - Note: This subscript allows you to create a substring of the string using a range of integer indices.
             The range must be within the valid range of the string.
     
     - SeeAlso: `subscript(bounds:)`
     
     - Example:
     ```
     let str = "Swift Programming"
     let substring = str[6..<12]
     // substring is "Progra"
     ```
     */
    public subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}
