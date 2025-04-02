//
//  DependencyInjectionBootcamp.swift
//  SwiftUILearning
//
//  Created by Zaur  on 02.04.2025.
//

import SwiftUI
import Combine

// PROBLEMS WITH SINGLETONS
// 1. Singleton's are GLOBAL
// 2. Can't customize init
// 3. Cant's swap out service

// DI - Dependence Injection


struct PostModel: Identifiable, Codable {
    /*
    {
      "id": 1,
      "title": "His mother had always taught him",
      "body": "His mother had always taught him not to ever think of himself as better than others. He'd tried to live by this motto. He never looked down on those who were less fortunate or who had less money than him. But the stupidity of the group of people he was talking to made him change his mind.",
      "tags": [
        "history",
        "american",
        "crime"
      ],
      "reactions": {
        "likes": 192,
        "dislikes": 25
      },
      "views": 305,
      "userId": 121
    },
    */
    let userId: Int
    let id: Int
    let body: String
    let title: String
}

struct PostModelsArray: Codable {
    let posts: [PostModel]
    // { "posts": [PostModel] }
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<PostModelsArray, Error>
}

class ProductionDataService: DataServiceProtocol {
    // static let instance = ProductionDataService() // Singleton
    let url: URL //? = URL(string: "https://dummyjson.com/posts")
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<PostModelsArray, Error> {
        URLSession.shared.dataTaskPublisher(for: url).map({ $0.data })
            .decode(type: PostModelsArray.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockDataService: DataServiceProtocol {
    /*
    let testArrayData: [PostModel] = [
        PostModel(userId: 1, id: 1, body: "one", title: "one"),
        PostModel(userId: 2, id: 2, body: "two", title: "two"),
        PostModel(userId: 3, id: 3, body: "three", title: "three")
    ]
    var testData1: PostModelsArray = PostModelsArray(posts:
        [
            PostModel(userId: 1, id: 1, body: "one", title: "one"),
            PostModel(userId: 2, id: 2, body: "two", title: "two"),
            PostModel(userId: 3, id: 3, body: "three", title: "three")
        ]
    )
    // {"posts": testArrayData}
    */
    let testData: PostModelsArray
    
    init(testData: PostModelsArray? = nil) {
        guard let testData else {
            self.testData = PostModelsArray(posts: [
                    PostModel(userId: 1, id: 1, body: "one", title: "one"),
                    PostModel(userId: 2, id: 2, body: "two", title: "two"),
                    PostModel(userId: 3, id: 3, body: "three", title: "three")
                ])
            return
        }
        self.testData = testData
    }
    
    
    func getData() -> AnyPublisher<PostModelsArray, any Error> {
        Just(testData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
}

class DependecyInjectionViewModel: ObservableObject {
    
    @Published var dataArray: [PostModel] = []
    var cancelables = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { error in
                print(error)
            } receiveValue: { [weak self] value in
                guard let self else { return }
                dataArray = value.posts
            }
            .store(in: &cancelables)

    }
}

struct DependencyInjectionBootcamp: View {
    
    @StateObject private var vm: DependecyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DependecyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        
        VStack {
            Text("Hello, World!")
            ScrollView {
                VStack {
                    ForEach(vm.dataArray) { post in
                        VStack {
                            Text(post.title)
                            Text(post.body)
                        }
                        Spacer()
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    // URL(string: "https://dummyjson.com/posts")
    // let dataService = ProductionDataService(url: URL(string: "https://dummyjson.com/posts")!)
    // let dataService = MockDataService()
    let dataService = MockDataService(testData: PostModelsArray(posts: [PostModel(userId: 3245, id: 5436, body: "treyt", title: "sd6f7g")]))
    
    DependencyInjectionBootcamp(dataService: dataService)
}
