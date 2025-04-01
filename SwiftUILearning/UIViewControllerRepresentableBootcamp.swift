//
//  UIViewControllerRepresentableBootcamp.swift
//  SwiftUILearning
//
//  Created by Zaur  on 01.04.2025.
//

import SwiftUI

struct UIViewControllerRepresentableBootcamp: View {
    
    @State var showScreen: Bool = false
    @State var image: UIImage?
    
    var body: some View {
        
        VStack(spacing: 30) {
            Text("Hello, World!")
            
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            Button {
                showScreen.toggle()
            } label: {
                Text("Open UIKit controller")
            }
            .sheet(isPresented: $showScreen) {
                //Text("Hello, World! from new controller")
                //BasicUIViewControllerRepresentable(labelText: "Hello, World! from new controller")
                UIImagePickerControllerRepresentable(image: $image, showScreen: $showScreen)
            }
        }
        Spacer()
        
    }
}

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Binding var showScreen: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    // from SwiftUI to UIKit
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //
    }
    
    // from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        Coordinator(image: $image, showScreen: $showScreen)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var inoutimage: UIImage?
        @Binding var inoutShowScreen: Bool

        
        init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._inoutimage = image
            self._inoutShowScreen = showScreen
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // get image
            guard let image = info[.originalImage] as? UIImage else { return }
            inoutimage = image
            inoutShowScreen = false
        }
        
    }
}


struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    
    let labelText: String // "Hello, World! from new controller"
    
    func makeUIViewController(context: Context) -> some UIViewController {
        //let viewController = UIViewController()
//        viewController.view.backgroundColor = UIColor.purple
//        
//        let label = UILabel()
//        label.text = labelText
//        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
//        label.textColor = UIColor.white
//        label.frame = viewController.view.frame
//        
//        viewController.view.addSubview(label)
        
        let vc = MyFirstViewController()
        vc.labelText = labelText
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
}


class MyFirstViewController: UIViewController {
    
    var labelText: String = "from other new controller"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.purple
        let label = UILabel()
        label.text = labelText
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = UIColor.white
        label.frame = view.frame
        
        view.addSubview(label)
    }
}

#Preview {
    UIViewControllerRepresentableBootcamp()
}
