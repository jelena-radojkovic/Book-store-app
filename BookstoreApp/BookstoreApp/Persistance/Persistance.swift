//
//  Persistance.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 13.12.21..
//

import CoreData

struct Persistance {
    static var userType = ""
    static var uniqueId = 0
    static let shared = Persistance()
    static var currentUser: CurrentUser?
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "BookstoreDB")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Error: \(error)")
            }
        }
    }
    
    // MARK: - update users
    private func updateusers() {
        let fetchRequest = User.fetchRequest()
        
        fetchRequest.predicate = NSPredicate (
            format: "username LIKE %@", "Jecka"
        )
        
        do {
            let userObject = try container.viewContext.fetch(fetchRequest)[0]
            userObject.setValue("admin", forKey: "userType")
            saveContext()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Add books
    private func addBooks() {
        let book1 = Book(context: container.viewContext)
        book1.author = "Matija Pesic"
        book1.bookDescription = "Knjiga o planinama"
        book1.bookId = UUID()
        book1.imageUrl = "bookstore3"
        book1.name = "Planine"
        book1.numPages = 1
        book1.promotion = false
        book1.publishedYear = 1999
        book1.rating = 0
        
        let book2 = Book(context: container.viewContext)
        book2.author = "Tijana Tadic"
        book2.bookDescription = "Knjiga o farmi"
        book2.bookId = UUID()
        book2.imageUrl = "bookstore3"
        book2.name = "Farma"
        book2.numPages = 1
        book2.promotion = true
        book2.publishedYear = 1999
        book2.rating = 0
        
        let book3 = Book(context: container.viewContext)
        book3.author = "Jelena Radojkovic"
        book3.bookDescription = "Knjiga o zivotinjama"
        book3.bookId = UUID()
        book3.imageUrl = "bookstore3"
        book3.name = "Zivotinje"
        book3.numPages = 1
        book3.promotion = true
        book3.publishedYear = 1999
        book3.rating = 0
        
        saveContext()
    }
    
    // MARK: - Register
    func register(_ user: CurrentUser) {
        let newUser = User(context: container.viewContext)
        newUser.name = user.name
        newUser.surname = user.surname
        newUser.phoneNumber = user.phoneNumber
        newUser.adress = user.adress
        newUser.username = user.username
        newUser.password = user.password
        newUser.userId = UUID()
        newUser.userType = user.userType
        
        saveContext()
    }
    
    // MARK: - Login
    func login(username: String, password: String) -> (Bool, String) {
        let fetchRequest = User.fetchRequest()
        
        fetchRequest.predicate = NSPredicate (
            format: "username LIKE %@ AND password LIKE %@", username, password
        )
        
        do {
            let userObject = try container.viewContext.fetch(fetchRequest)
            if userObject.isEmpty || userObject.count > 1 {
                return (false,  userObject.isEmpty ? "No user with those credentials" : "More than one wtf")
            } else {
                let user = userObject[0]
                Persistance.currentUser = CurrentUser(adress: user.adress ?? "",
                                                      phoneNumber: user.phoneNumber ?? "",
                                                      name: user.name ?? "",
                                                      surname: user.surname ?? "",
                                                      password: user.password ?? "",
                                                      username: user.username ?? "",
                                                      userId: user.userId ?? UUID(),
                                                      userType: user.userType ?? "")
                if let userType = user.userType {
                    Persistance.userType = userType
                }
                return (true, "Successful login")
            }
        } catch {
            return (false, error.localizedDescription)
        }
    }
    
    func getUsername(for userId: UUID?) -> String {
        if let id = userId {
            let fetchRequest = User.fetchRequest()
            
            fetchRequest.predicate = NSPredicate (
                format: "userId == %@", id as CVarArg
            )
            do {
                let userObject = try container.viewContext.fetch(fetchRequest)
                if !userObject.isEmpty {
                    return userObject[0].username ?? "FAULT"
                } else {
                    return "FAULT"
                }
                
            } catch {
                return "FAULT"
            }
        } else {
            return "FAULT"
        }
    }
    
    func getUserId(for username: String) -> UUID? {
        let fetchRequest = User.fetchRequest()
        
        fetchRequest.predicate = NSPredicate (
            format: "username == %@", username
        )
        
        do {
            let userObject = try container.viewContext.fetch(fetchRequest)
            return userObject[0].userId ?? nil
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getUser(for username: String) -> User? {
        let fetchRequest = User.fetchRequest()
        
        fetchRequest.predicate = NSPredicate (
            format: "username == %@", username
        )
        
        do {
            let userObject = try container.viewContext.fetch(fetchRequest)
            if !userObject.isEmpty {
                return userObject[0]
            }
            return nil
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getAllUsernames() -> [String] {
        let fetchRequest = User.fetchRequest()
        
        do {
            let userObject = try container.viewContext.fetch(fetchRequest)
            var usernames: [String] = []
            for user_ in userObject {
                usernames.append(user_.username ?? "fault")
            }
            return usernames
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - User information
    func updateInfo(user: CurrentUser) -> String? {
        let fetchRequest = User.fetchRequest()
        
        fetchRequest.predicate = NSPredicate (
            format: "username LIKE %@", user.username
        )
        
        do {
            let userObject = try container.viewContext.fetch(fetchRequest)[0]
            userObject.setValue(user.username, forKey: "username")
            userObject.setValue(user.userId, forKey: "userId")
            userObject.setValue(user.adress, forKey: "adress")
            userObject.setValue(user.name, forKey: "name")
            userObject.setValue(user.surname, forKey: "surname")
            userObject.setValue(user.phoneNumber, forKey: "phoneNumber")
            saveContext()
        } catch {
            return error.localizedDescription
        }
        return nil
    }
    
    // MARK: - data deleting
    func delete() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Book")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(deleteRequest)
            saveContext()
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    private func deleteRatings() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Ratings")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(deleteRequest)
            saveContext()
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    private func deleteUsers(usernames: [String]) {
        for username in usernames {
            if let user = getUser(for: username) {
                container.viewContext.delete(user)
                saveContext()
            }
        }
    }
    
    // MARK: - update ids
    func update(book: String, author: String) -> String? {
        let fetchRequest = Book.fetchRequest()
        
        fetchRequest.predicate = NSPredicate (
            format: "name LIKE %@ and author LIKE %@", book, author
        )
        
        do {
            let bookObject = try container.viewContext.fetch(fetchRequest)[0]
            bookObject.setValue(UUID(), forKey: "bookId")
            saveContext()
        } catch {
            return error.localizedDescription
        }
        return nil
    }
    
    func getAllBooks() -> [Book] {
        let fetchRequest = Book.fetchRequest()
        
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getBooksOnPromotion() -> [Book] {
        let fetchRequest = Book.fetchRequest()
        
        fetchRequest.predicate = NSPredicate (
            format: "promotion == true"
        )
        
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func onPromotion(book: UUID, status: Bool) {
        let fetchRequest = Book.fetchRequest()
        
        fetchRequest.predicate = NSPredicate (
            format: "bookId == %@", book as CVarArg
        )
        
        do {
            let bookObject = try container.viewContext.fetch(fetchRequest)[0]
            bookObject.setValue(status, forKey: "promotion")
            saveContext()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addBook(bookName: String, author: String, description: String, imageUrl: String, numPages: Int, publishedYear: Int) {
        let book = Book(context: container.viewContext)
        book.author = author
        book.bookDescription = description
        book.bookId = UUID()
        book.imageUrl = imageUrl
        book.name = bookName
        book.numPages = Int32(numPages)
        book.promotion = false
        book.publishedYear = Int32(publishedYear)
        book.rating = 0
        
        saveContext()
    }
    
    // MARK: - Password change
    func change(password: String, username: String) -> String? {
        let fetchRequest = User.fetchRequest()
        
        fetchRequest.predicate = NSPredicate (
            format: "username LIKE %@", username
        )
        
        do {
            let userObject = try container.viewContext.fetch(fetchRequest)[0]
            userObject.setValue(password, forKey: "password")
            saveContext()
        } catch {
            return error.localizedDescription
        }
        return nil
    }
    
    // MARK: - Leave a comment
    func leave(comment: String, for book: UUID) {
        let userId = Persistance.currentUser?.userId
        let newComment = Comment(context: container.viewContext)
        newComment.comment = comment
        newComment.userId = userId
        newComment.bookId = book
        
        saveContext()
    }
    
    // MARK: - Rate a book
    func rate(book: UUID, with rating: Int, by user: UUID) {
        let newRating = Ratings(context: container.viewContext)
        newRating.bookId = book
        newRating.rating = Int16(rating)
        newRating.userId = user
        
        saveContext()
    }
    
    // MARK: - Get book details
    func getBookDetails(for id: UUID?) -> Book? {
        if let id = id {
            let fetchRequest = Book.fetchRequest()
            fetchRequest.predicate = NSPredicate (
                format: "bookId == %@", id as CVarArg
            )
            
            do {
                let book = try container.viewContext.fetch(fetchRequest)
                return book[0]
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    // MARK: - Get all comments
    func getComments() -> [Comment]? {
        let fetchRequest = Comment.fetchRequest()
        
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            return nil
        }
    }
    
    func getComments(for book: UUID) -> [CommentsModel] { //username & comment
        let fetchRequest = Comment.fetchRequest()
        fetchRequest.predicate = NSPredicate (
            format: "bookId == %@", book as CVarArg
        )
        
        var res: [CommentsModel] = []
        do {
            let commentObjects = try container.viewContext.fetch(fetchRequest)
            for comment in commentObjects {
                let rating = getRating(for: comment.bookId, by: comment.userId)
                res.append(CommentsModel(id: Persistance.uniqueId,
                                         username: getUsername(for: comment.userId),
                                         comment: comment.comment,
                                         rating: rating))
                Persistance.uniqueId = Persistance.uniqueId + 1
            }
            return res + getRatings(for: book, comments: res)
        } catch {
            return res
        }
    }
    
    func getRatings(for book: UUID, comments: [CommentsModel]) -> [CommentsModel] {
        let fetchRequest = Ratings.fetchRequest()
        fetchRequest.predicate = NSPredicate (
            format: "bookId == %@",  book as CVarArg
        )
        
        var res: [CommentsModel] = []
        do {
            let ratingObjects = try container.viewContext.fetch(fetchRequest)
            for rating in ratingObjects {
                // if username is not in the comments list, than add it
                if !commentExists(by: getUsername(for: rating.userId), in: comments) {
                    res.append(CommentsModel(id: Persistance.uniqueId,
                                             username: getUsername(for: rating.userId),
                                             comment: "-",
                                             rating: Int(rating.rating)))
                    Persistance.uniqueId = Persistance.uniqueId + 1
                }
            }
            return res
        } catch {
            fatalError("418: " + error.localizedDescription)
        }
    }
    
    private func commentExists( by user: String, in comments: [CommentsModel]) -> Bool {
        if let _ = comments.firstIndex(where: { $0.username == user }) {
            return true
        }
        return false
    }
    
    func getRating(for book: UUID?, by user: UUID?) -> Int? {
        if let bookId = book, let userId = user {
            let fetchRequest = Ratings.fetchRequest()
            
            fetchRequest.predicate = NSPredicate (
                format: "bookId == %@ and userId == %@", bookId as CVarArg, userId as CVarArg
            )
            
            do {
                let ratings = try container.viewContext.fetch(fetchRequest)
                if !ratings.isEmpty {
                    return Int(ratings[0].rating)
                } else {
                    return nil
                }
            } catch {
                return nil
            }
        } else {
            return nil
        }
        
    }
    
    func getRatingByCurrentUser(for book: UUID?) -> Int? {
        if let bookId = book, let userId = Persistance.currentUser?.userId {
            let fetchRequest = Ratings.fetchRequest()
            
            fetchRequest.predicate = NSPredicate (
                format: "bookId == %@ and userId == %@", bookId as CVarArg, userId as CVarArg
            )
            
            do {
                let ratings = try container.viewContext.fetch(fetchRequest)
                if !ratings.isEmpty {
                    return Int(ratings[0].rating)
                } else {
                    return nil
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            return nil
        }
    }
    
    // MARK: - Recommended books
    
    // works for current user
    func getRecommendedBooks() -> [Recommended] {
        guard let currentUserId = Persistance.currentUser?.userId else {
            return []
        }
        
        let fetchRequest = Recommended.fetchRequest()
        fetchRequest.predicate = NSPredicate (
            format: "toUser == %@", currentUserId as CVarArg
        )
        
        do {
            let recommendedBooks = try container.viewContext.fetch(fetchRequest)
            return recommendedBooks
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // recommended by current user
    func recommend(book: UUID, to user: String) {
        if let userId = getUserId(for: user), Persistance.currentUser?.userId != nil {
            let recommendedBook = Recommended(context: container.viewContext)
            recommendedBook.bookId = book
            recommendedBook.fromUser = Persistance.currentUser?.userId
            recommendedBook.toUser = userId
            
            saveContext()
        }
    }
    
    // MARK: - Context save
    private func saveContext() {
        do {
            try container.viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Error: \(error.description)")
        }
    }
}
