//
//  GenericsBootcamp.swift
//  SwiftUILearning
//
//  Created by Заур Гиясов on 27.03.2025.
//

import SwiftUI

struct StringModel {
    let info: String?
    func removeInfo() -> StringModel {
        return StringModel(info: nil)
    }
}

struct GenericModel<T> {
    let info: T?
    func removeInfo() -> GenericModel {
        return GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
    @Published var stringModel = StringModel(info: "Hello World!")
    @Published var genericStringModel = GenericModel(info: "Hello World from generic")
    @Published var genericBoolModel = GenericModel(info: false)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

struct GenericView<T: View>: View {
    
    let content: T
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

struct GenericsBootcamp: View {
    
    @StateObject private var vm = GenericsViewModel()
    
    var body: some View {
        VStack {
            // GenericView(title: "new title")
            GenericView(content: Text("drrr"), title: "new view")
            Text(vm.stringModel.info ?? "no data")
            Text(vm.genericStringModel.info ?? "no data")
            Text(vm.genericBoolModel.info?.description ?? "no data")
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

#Preview {
    GenericsBootcamp()
}
