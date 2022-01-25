//
//  CommentsModel.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 21.12.21..
//

import Foundation

struct CommentsModel: Identifiable, Hashable {
    var id: Int
    let username: String
    let comment: String?
    let rating: Int?
}
