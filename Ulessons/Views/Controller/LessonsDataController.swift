//
//  LessonsDataController.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/6/21.
//

//import UIKit
//import CoreData
//
//class LessonsDataController: NSObject {
//
//    static let sharedinstance: LessonsDataController = {
//        let instance = LessonsDataController()
//        return instance
//    }()
//
//    public lazy var fetchedResultsController: NSFetchedResultsController<Lessons> = {
//
//        // Initialize Fetch Request
//        let fetchRequest:NSFetchRequest<Lessons> = Lessons.fetchRequest()
//
//        // Add sort descriptor
//        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        // Initialize Fetched Results Controller
//        let fetchedResultsController = NSFetchedResultsController(
//            fetchRequest: fetchRequest,
//            managedObjectContext: DataStore.shared.newViewContext(),
//            sectionNameKeyPath: nil,
//            cacheName: nil)
//
//        return fetchedResultsController
//    }()
//
//    var fetchedItems:Array<Lessons> {
//        get {
//            return fetchedResultsController.fetchedObjects ?? [Lessons]()
//        }
//    }
//
//    override init() {
//        super.init()
//        // Execute initial fetch command
//        try? executeFetch()
//    }
//
//    public func executeFetch() throws {
//
//        // Perform fetch
//        do {
//            try self.fetchedResultsController.performFetch()
//        } catch {
//            let fetchError = error as NSError
//            print("Unable to Perform Fetch Request")
//            print("\(fetchError), \(fetchError.localizedDescription)")
//        }
//    }
//}
