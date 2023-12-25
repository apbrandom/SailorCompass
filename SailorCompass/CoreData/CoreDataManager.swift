//
//  CoreDataManager.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 15.12.2023.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    let viewContext: NSManagedObjectContext

    private init() {
        viewContext = PersistenceController.shared.container.viewContext
    }
    
    //For QuizManager
    func fetchQuestions(for test: Test) async throws -> [Question] {
        let context = viewContext

        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "test == %@", test)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Question.dateCreated, ascending: true)]

        return try context.fetch(request)
    }

    //Not using...
    func saveQuestion(text: String, answer: String, in test: Test) {
        let newQuestion = Question(context: viewContext)
        let newAnswer = Answer(context: viewContext)

        newQuestion.text = text
        newQuestion.correctAnswer = answer
        test.qcount += 1

        newAnswer.question = newQuestion
        newAnswer.isCorrect = true
        newAnswer.text = answer

        newQuestion.test = test

        do {
            try viewContext.save()
        } catch {
            print("Saving test failed: \(error.localizedDescription)")
        }
    }
}
