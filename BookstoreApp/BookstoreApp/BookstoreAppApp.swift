//
//  BookstoreAppApp.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 10.12.21..
//

import SwiftUI

/** User credentials
 **username: password
 *  W           : Q
 *  Ack         : Acko
 *  Jecka      :jecka
 *  Maki        :Maki
 */

@main
struct BookstoreAppApp: App {
    let persistanceContainer = Persistance.shared
    
    var body: some Scene {
        WindowGroup {
            LoginView().environment(\.managedObjectContext, persistanceContainer.container.viewContext)
        }
    }
}
