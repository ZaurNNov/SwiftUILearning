//
//  UIViewRepresentableBootcamp.swift
//  SwiftUILearning
//
//  Created by Zaur  on 01.04.2025.
//

import SwiftUI


// Convert a UIView from UIKit to SwiftUI
struct UIViewRepresentableBootcamp: View {
    
    @State private var text = ""
    @State private var placeholder = "Placeholder here"
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                Text("Hello, World! " + text)
                
                // BasicUIViewRepresentable()
                
                // SwiftUI
                HStack(spacing: 40) {
                    Text("SwiftUI:")
                    TextField(placeholder, text: $text)
                        .frame(height: 60)
                        .background(Color.gray.opacity(0.3))
                }
                
                // UIKit
                HStack(spacing: 60) {
                    Text("UIKit:")
                    UITextFieldViewRepresentable(text: $text, plaseholder: placeholder, plaseholderColor: .purple)
                        .frame(height: 60)
                        .background(Color.yellow.opacity(0.3))
                }
                
                HStack(spacing: 60) {
                    Text("UIKit:")
                    UITextFieldViewRepresentable(text: $text)
                        .updatePlaceholder(text: "Custom placeholder")
                        .frame(height: 60)
                        .background(Color.yellow.opacity(0.3))
                }
                
                HStack(spacing: 60) {
                    Text("UIKit:")
                    UITextFieldViewRepresentable(text: $text, plaseholder: "placeholder ...")
                        //.updatePlaceholder(text: "Custom placeholder")
                        .frame(height: 60)
                        .background(Color.yellow.opacity(0.3))
                }
            }
            .padding()
            Spacer()
        }
    }
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var plaseholder: String? // "Placeholder here"
    let plaseholderColor: UIColor // UIColor.red
    
    init(text: Binding<String>, plaseholder: String? = "Placeholder here", plaseholderColor: UIColor = .red) {
        self._text = text
        self.plaseholder = plaseholder ?? nil
        self.plaseholderColor = plaseholderColor
    }
    
    func makeUIView(context: Context) -> UITextField { // some UIView {
        let textfield = getTextField()
        textfield.delegate = context.coordinator
        return textfield
    }
    
    // from SwiftUI to UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextField() -> UITextField {
        let textfield = UITextField(frame: .zero)
        let placeholderText = plaseholder
        let plaseholderValue = NSAttributedString(string: placeholderText ?? "", attributes: [.foregroundColor: plaseholderColor])
        textfield.attributedPlaceholder = plaseholderValue
        return textfield
    }
    
    func updatePlaceholder(text: String) -> UITextFieldViewRepresentable {
        var viewRepresentable = self
        viewRepresentable.plaseholder = text
        return viewRepresentable
    }
    
    // from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var inoutText: String
        
        init(text: Binding<String>) {
            self._inoutText = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            inoutText = textField.text ?? ""
        }
    }
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}

#Preview {
    UIViewRepresentableBootcamp()
}
