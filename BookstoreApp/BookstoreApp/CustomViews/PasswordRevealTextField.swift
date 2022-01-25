//
//  PasswordRevealTextField.swift
//  LFSwiftUIToolkit
//
//  Created by Miljana Ratkov on 9.9.21..
//

import SwiftUI

public struct PasswordRevealTextField: View {
    public init(placeholder: String, text: Binding<String>, showPasswordIcon: Image,showPasswordIconForegroundColor: Color? = nil, hidePasswordIcon: Image, hidePasswordIconForegroundColor: Color? = nil, onCommit: @escaping () -> Void = {} ) {
        self.placeholder = placeholder
        self._text = text
        self.showPasswordIcon = showPasswordIcon
        self.hidePasswordIcon = hidePasswordIcon
        self.showPasswordIconForegroundColor = showPasswordIconForegroundColor
        self.hidePasswordIconForegroundColor = hidePasswordIconForegroundColor
        self.onCommit = onCommit
    }
    @State private var isSecured: Bool = true
    @Binding private var text: String
    
    private let placeholder: String
    private let showPasswordIcon: Image
    private let showPasswordIconForegroundColor: Color?
    private let hidePasswordIcon: Image
    private let hidePasswordIconForegroundColor: Color?
    private let onCommit: () -> Void
    
    private var icon: some View {
        if isSecured {
            return showPasswordIcon.foregroundColor(showPasswordIconForegroundColor)
        } else {
            return hidePasswordIcon.foregroundColor(hidePasswordIconForegroundColor)
        }
    }
    
    public var body: some View {
        HStack{
            if isSecured {
                SecureField(placeholder, text: $text,
                            onCommit: onCommit)
                    .disableAutocorrection(true)
            } else {
                TextField(placeholder, text: $text,
                          onCommit: onCommit)
                    .disableAutocorrection(true)
            }
            Button(action: { isSecured.toggle() }){
                icon
            }
        }
        .background(Color.white)
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
