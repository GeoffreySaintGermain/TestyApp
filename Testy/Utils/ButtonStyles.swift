//
// ButtonStyles.swift
//
// Copyright 2022 Geoffrey Saint-Germain
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import Foundation
import SwiftUI

/// Default style from buttons
public struct TestyButtonStyle: ButtonStyle {
    let backgroundColor: Color?

    public init(backgroundColor: Color? = nil) {
        self.backgroundColor = backgroundColor
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        return TestyButtonLabel(configuration: configuration)
    }
}

/// Default Button label, used by default style
private struct TestyButtonLabel: View {
    
    /// ButtonStyle configuration
    let configuration: ButtonStyle.Configuration
    
    var body: some View {
        configuration.label
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding(.vertical, testyPaddingS)
            .padding(.horizontal, testyPaddingL)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .clipShape(Capsule())
    }
}
