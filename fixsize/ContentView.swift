//
//  ContentView.swift
//  fixsize
//
//  Created by Krzysztof Czura on 09/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var elements: Array<String> = ["J", "e", "s", "t", "e", "m", " ", "p", "r", "o", "g", "r", "a", "m", "e", "m", " ", "k", "o", "m", "p", "u", "t", "e", "r", "o", "w", "y", "m", ", ", " ", "g", "o", "t", "o", "w", "y", "m", " ", "d", "o", " ", "p", "o", "m", "o", "c", "y", " ", "w", " ", "d", "o", "w", "o", "l", "n", "y", "c", "h", " ", "z", "a", "d", "a", "n", "i", "a", "c", "h", " ", "p", "r", "o", "g", "r", "a", "m", "i", "s", "t", "y", "c", "z", "n", "y", "c", "h", "."]

    
    var body: some View {
        VStack {
            HStacksContainer(elements: elements)
        }
        .padding()
    }
}

struct HStacksContainer: View {
    let elements: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(splitElements(), id: \.self) { lineElements in
                HStack(spacing: 0) {
                    ForEach(lineElements, id: \.self) { element in
                        Text(element)
                    }
                }
            }
        }
    }
    
    func splitElements() -> [[String]] {
        var lines: [[String]] = [[]]
        var currentLineIndex = 0
        var remainingWidth: CGFloat = UIScreen.main.bounds.width - 50
        var currentWord: [String] = []
        
        for element in elements {
            let elementWidth = element.width(withConstrainedHeight: 1000, font: .systemFont(ofSize: 18)) // Assuming font size 18
            
            if element == " " {
                // Add current word to the line, reset currentWord
                lines[currentLineIndex] += currentWord + [element]
                currentWord = []
            } else if elementWidth > remainingWidth {
                // Move to the next line for non-space elements that don't fit
                lines.append(currentWord + [element])
                currentWord = []
                currentLineIndex += 1
                remainingWidth = UIScreen.main.bounds.width - elementWidth - 50
            } else {
                // Add the element to the current word
                currentWord.append(element)
                remainingWidth -= elementWidth
            }
        }
        
        // Add the last word to the last line
        lines[currentLineIndex] += currentWord
        
        return lines
    }
}

extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}


#Preview {
    ContentView()
}
