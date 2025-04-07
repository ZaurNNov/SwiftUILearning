//
//  UITestingBootcampView.swift
//  SwiftUILearning
//
//  Created by Zaur  on 04.04.2025.
//

import SwiftUI

class UITestingBootcampViewModel: ObservableObject {
    var placeholder: String = "Add your name..."
    @Published var textFieldText: String = ""
    @Published var currentUserIsSignedIn: Bool
    
    init(currentUserIsSignedIn signedIn: Bool) {
        self.currentUserIsSignedIn = signedIn
    }
    
    func signInButtonPressed() {
        print("Sign in button pressed with text: \(textFieldText)")
        guard !textFieldText.isEmpty else {
            return
        }
        currentUserIsSignedIn = true
    }
}

struct UITestingBootcampView: View {
    
    @StateObject private var viewModel: UITestingBootcampViewModel
    
    init(viewModel model: UITestingBootcampViewModel) {
       _viewModel = StateObject(wrappedValue: model)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                if viewModel.currentUserIsSignedIn {
                    SignedInHomeScreen()
                }
                else {
                    signInLayer
                        .transition(.move(edge: .bottom))
                }
                Spacer()
            }
        }
    }
}

extension UITestingBootcampView {
    
    private var signInLayer: some View {
        VStack(spacing: 12) {
            TextField(text: $viewModel.textFieldText) {
                Text(viewModel.placeholder)
            }
            .font(.headline)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .frame(height: 60)
            .accessibilityIdentifier("SignInTextField")
            
            Button(role: .none) {
                withAnimation(.spring) {
                    viewModel.signInButtonPressed()
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
            }
            .accessibilityIdentifier("SignUpButton")
        }
        .padding()
    }
    
    private var helloWorldLayer: some View {
        VStack {
            Text("Hello, World!")
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Text("SwiftUI is awesome!")
                .font(.headline)
                .foregroundColor(.white)
        }
    }
}

struct SignedInHomeScreen: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 24) {
                Text("Signed screen!")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Welcome to the signed in home screen!")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .accessibilityIdentifier("ShowAlertButton")
                .alert(isPresented: $showAlert) {
                    return Alert(title: Text("Welcome"), message: Text("Signed in home screen"), dismissButton: .cancel())
                }
                
                NavigationLink(
                    destination: Text("Destination")) {
                        Text("Next Screen")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white)
                            .background(Color.red.opacity(0.3))
                            .cornerRadius(10)
                    }
                    .accessibilityIdentifier("NavigationLinkToDestination")
            }
            .padding()
            .navigationTitle("Signed In Home Screen")
        }
    }
}

#Preview {
    UITestingBootcampView(viewModel: UITestingBootcampViewModel(currentUserIsSignedIn: false))
//    SignedInHomeScreen()
}
