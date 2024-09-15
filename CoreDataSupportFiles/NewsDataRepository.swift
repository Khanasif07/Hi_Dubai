//
//  NewsDataRepository.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 15/09/2024.
//

import Foundation
import CoreData

struct NewsDataRepository : NewsCoreDataRepository {

    func insertNewsRecords(records: Array<NewsModel>) -> Bool {

        debugPrint("NewsDataRepository: Insert record operation is starting")

        PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in
            //insert code
            records.forEach { newsRecord in
                let cdNews = CDNews(context: privateManagedContext)
//                cdAnimal.id = UUID()
                cdNews.title = newsRecord.title
                cdNews.postURL = newsRecord.postURL
                cdNews.publishedAt = newsRecord.publishedAt
                cdNews.postImageURL = newsRecord.postImageURL
                cdNews.readTime = newsRecord.readTime
                cdNews.primaryTag = newsRecord.primaryTag
                cdNews.content = newsRecord.content
            }

            if(privateManagedContext.hasChanges){
                try? privateManagedContext.save()
                debugPrint("NewsDataRepository: Insert record operation is completed")
            }
        }

        return true
    }


    func getNewsRecords(completionHandler: @escaping (Array<NewsModel>?) -> Void) {

        PersistentStorage.shared.printDocumentDirectoryPath()

        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDNews.self)
            var newsList : Array<NewsModel> = []
            result?.forEach({ (cdNews) in
                newsList.append(cdNews.convertToNews())
            })

            completionHandler(newsList)

    }
}
