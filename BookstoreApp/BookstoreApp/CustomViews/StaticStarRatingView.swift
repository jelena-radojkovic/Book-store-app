//
//  StarRatingView.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 16.12.21..
//

import SwiftUI

struct StaticStarRatingView: View {
    var rating: Int
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .frame(width: 13, height: 15)
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct StaticStarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StaticStarRatingView(rating: 4)
    }
}
