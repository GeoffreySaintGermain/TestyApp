//
//  HTMLStringView.swift
//  Testy
//
//  Created by Saint Germain on 06/07/2022.
//
//  Copyright 2022 Geoffrey Saint-Germain
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import WebKit
import SwiftUI


/// Convert HTML raw text in displayable string
struct HTMLStringView: UIViewRepresentable {
    
    /// App scheme
    @Environment(\.colorScheme) var colorScheme
    
    /// Html text
    let text: String
    
    /// Current textView
    private  let textView = UITextView()
    
    init(_ content: String) {
        self.text = content
    }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UITextView {
        textView.widthAnchor.constraint(equalToConstant:UIScreen.main.bounds.width).isActive = true
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<Self>) {
        DispatchQueue.main.async {
            if let attributeText = self.converHTML(text: text) {
                textView.attributedText = attributeText
                textView.textColor = (colorScheme == .dark ? UIColor.white : UIColor.black)
            } else {
                textView.text = ""
            }
            
        }
    }
    
    /// Convert raw html to standard string
    private func converHTML(text: String) -> NSAttributedString? {        
        let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: 16\">\(text)</span>")
        
        if let attrStr = try? NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil) {
            return attrStr
        } else {
            return nil
        }
    }
}
