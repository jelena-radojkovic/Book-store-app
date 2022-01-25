//
//  ImageManager.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 17.1.22..
//

import Foundation
import SwiftUI

struct ImageManager {
    static let shared = ImageManager()
    static var uniqueID = 0
    private init() {
        // on every running of a program, we need to refresh this id
        let defaults = UserDefaults.standard
        defaults.set(0, forKey: "imageId")
    }
    
    func saveImage(image: UIImage) -> (Bool, String?) {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return (false, nil)
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return (false, nil)
        }
        do {
            let imageUrl = "image_" + getId() + ".png"
            try data.write(to: directory.appendingPathComponent(imageUrl)!)
            return (true, imageUrl)
        } catch {
            print(error.localizedDescription)
            return (false, nil)
        }
    }
    
    func getImage(imageUrl: String) -> Image {
        if imageUrl.hasPrefix("bookstore") {
            return Image(imageUrl)
        } else {
            if let image = getSavedImage(named: imageUrl) {
                return Image(uiImage: image)
            }
        }
        //default pic in case of an error
        return Image("X")
    }
    
    private func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    private func getId() -> String {
        let defaults = UserDefaults.standard
        let id = defaults.integer(forKey: "imageId")
        defaults.set(id + 1, forKey: "imageId")
        return String(id)
    }
}
