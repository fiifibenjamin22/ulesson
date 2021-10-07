//
//  DataStore.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/6/21.
//

import Foundation
import CoreData

/*
This class maintain user's data base operations.
*/
class LessonsDBManager {
    
    func fetchAllLessons(onContext context: NSManagedObjectContext? = nil) -> Result<[Lessons], Error>{
        
        let context = context ?? Constants.appDelegate.mainContext
        let fetchRequest = NSFetchRequest<Lessons>(entityName: "Lessons")
        do {
            let result = try context.fetch(fetchRequest)
            return .success(result)
        } catch let error {
            print(error.localizedDescription)
            return .failure(error)
        }
    }


    func save(lessons: [Lesson],
              replaceOldData: Bool = false,
              onContext context: NSManagedObjectContext? = nil) -> [Lesson]{

        let context = context ?? Constants.appDelegate.mainContext
        
        //Fetch all saved lessons
        let allLessonsEntities = fetchAllLessons(onContext: context)
        guard case .success(let lessonsEntities) = allLessonsEntities  else {
            return []
        }
            
        //Create a hashmap for make search in O(1) Complexity
        var dict = [String: Lessons]()
        lessonsEntities.forEach{ dict[$0.id ?? ""] = $0 }
        var results = [Lesson]()
        for lesson in lessons {
            guard let lessonId = lesson.id else {
                continue
            }
            var lessonEntity: Lessons
            if let savedLesson = dict[lessonId] {
                // if replaceOldData is true than use the new data
                lessonEntity = replaceOldData ? lesson.toEntity() : savedLesson
            } else {
                lessonEntity = lesson.toEntity(onContext: context)
            }
            
            let lessonModel = lessonEntity.toLessonsModel()
            results.append(lessonModel)
        }
        try? context.save()
        return results
    }
}
