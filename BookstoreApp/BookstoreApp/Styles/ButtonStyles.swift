//
//  ButtonStyles.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 15.12.21..
//

import Foundation
import SwiftUI

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 200, height: 30)
            .background(Color(red: 0, green: 0, blue: 1))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .circular))
    }
}

struct BlueishButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 170, height: 40)
            .background(Color(red: 117/256, green: 166/256, blue: 199/256))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .circular))
    }
}

struct SmallerBlueishButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 100, height: 40)
            .background(Color(red: 117/256, green: 166/256, blue: 199/256))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .circular))
    }
}

struct WhiteishButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 300, height: 40)
            .background(Color(red: 1, green: 1, blue: 1))
            .foregroundColor(.gray)
            .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .circular))
    }
}

struct PurpleishButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 240, height: 40)
            .background(Color(red: 161/256, green: 132/256, blue: 195/256))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .circular))
    }
}

