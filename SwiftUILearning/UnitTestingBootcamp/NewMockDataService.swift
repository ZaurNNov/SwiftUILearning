//
//  NewMockDataService.swift
//  SwiftUILearning
//
//  Created by Zaur  on 04.04.2025.
//

import SwiftUI
import Combine

protocol NewDataServiceProtocol {
    
    func downloadItemsWithEscaping(completeion: @escaping (_ items: [String]) -> Void)
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

class NewMockDataService: NewDataServiceProtocol {
    
    let items: [String] // = ["String", "Strong", "Weak"]
    
    init(items: [String]?) {
        self.items = items ?? ["String", "Strong", "Weak"]
    }
    
    func downloadItemsWithEscaping(completeion: @escaping (_ items: [String]) -> Void) {
        // fake
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            completeion(self.items)
        })
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap({ publishValue in
                guard !publishValue.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishValue
            })
            .eraseToAnyPublisher()
    }
}
