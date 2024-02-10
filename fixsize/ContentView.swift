//
//  ContentView.swift
//  fixsize
//
//  Created by Krzysztof Czura on 09/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var elements: Array<String> = ["J", "e", "s", "t", "e", "m", " ", "p", "r", "o", "g", "r", "a", "m", "e", "m", " ", "k", "o", "m", "p", "u", "t", "e", "r", "o", "w", "y", "m", ",", " ", "g", "o", "t", "o", "w", "y", "m", " ", "d", "o", " ", "p", "o", "m", "o", "c", "y", " ", "w", " ", "d", "o", "w", "o", "l", "n", "y", "c", "h", " ", "z", "a", "d", "a", "n", "i", "a", "c", "h", " ", "p", "r", "o", "g", "r", "a", "m", "i", "s", "t", "y", "c", "z", "n", "y", "c", "h", "."]

    
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
        var currentWord: String = ""
        var words: [String] = []
        
        // Build words
        for (index, element) in elements.enumerated() {
            if element == " " {
                currentWord.append(element)
                words.append(currentWord)
                currentWord = ""
            } else {
                // Add the element to the current word
                currentWord.append(element)
                
                // Check if this is the last element
                if index == elements.count - 1 {
                    words.append(currentWord)
                }
            }
        }
        
        for (index, word) in words.enumerated() {
            let wordWidth = word.width(withConstrainedHeight: 1000, font: .systemFont(ofSize: 18)) // Assuming font size 18
            
            if index == 0 {
                lines[currentLineIndex].append(word)
                remainingWidth -= wordWidth
            } else {
                if wordWidth > remainingWidth {
                    currentLineIndex += 1
                    lines.append([word])
                    remainingWidth = UIScreen.main.bounds.width - wordWidth - 50
                } else {
                    lines[currentLineIndex].append(word)
                    remainingWidth -= wordWidth
                }
            }
        }
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
