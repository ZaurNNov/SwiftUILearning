//
//  UnitTestingBootcampViewModel.swift
//  SwiftUILearning
//
//  Created by Zaur  on 03.04.2025.
//

import SwiftUI
import Combine


class UnitTestingBootcampViewModel: ObservableObject {
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    let dataService: NewDataServiceProtocol
    var cancellables: Set<AnyCancellable> = []
    
    init(isPremium: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else {
            return
        }
        dataArray.append(item)
    }
    
    func selectItem(item: String) {
        guard let item = dataArray.first(where: { $0 == item}) else {
            selectedItem = nil
            return
        }
        selectedItem = item
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw LocalErrors.noData
        }
        
        if let item = dataArray.first(where: { $0 == item}) {
            print("save here: \(item)")
        }
        else {
            throw LocalErrors.itemNotFound
        }
    }
    
    enum LocalErrors: LocalizedError {
        case noData
        case itemNotFound
    }
    
    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping { [weak self] items in
            guard let self else { return }
            self.dataArray = items
        }
    }
    
    func downloadWithCombine() {
        dataService.downloadItemsWithCombine()
            .sink { error in
                print(error)
            } receiveValue: { [weak self] items in
                guard let self else { return }
                self.dataArray = items
            }
            .store(in: &cancellables)

    }
    
    
}

