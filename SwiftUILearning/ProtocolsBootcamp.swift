//
//  ProtocolsBootcamp.swift
//  SwiftUILearning
//
//  Created by Zaur  on 02.04.2025.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeColotTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .purple
}

protocol ColorThemeProtocol {
    var primary: Color { get } // { get, set }
    var secondary: Color { get }
    var tertiary: Color { get }
}

struct AnotherColorTheme: ColorThemeProtocol {
    var primary: Color = .orange
    var secondary: Color = .purple
    var tertiary: Color = .black
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
}

protocol ButtonPressedProtocol {
    func buttonPressed()
}

protocol ButtonDataPressedProtocol: ButtonTextProtocol, ButtonPressedProtocol {
    var buttonText: String { get }
    func buttonPressed()
}

class DefaultDataSourse: ButtonDataPressedProtocol {
    var buttonText: String = "Protocol Default Text"
    
    func buttonPressed() {
        print(#function)
    }
}

class AlternativeDataSourse: ButtonTextProtocol {
    var buttonText: String = "Protocol are lame"
}

struct ProtocolsBootcamp: View {
    
    // let colorTheme: DefaultColorTheme = .init()
    // let colorTheme: AlternativeColotTheme = .init()
    // let colorTheme: DefaultColorTheme = AlternativeColotTheme()
    
    let colorTheme: ColorThemeProtocol // = DefaultColorTheme() // AlternativeColotTheme()
    let dataSourse: ButtonDataPressedProtocol
    
    var body: some View {
        
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()
            
            Text(dataSourse.buttonText)
                .font(.largeTitle)
                .foregroundColor(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
                .onTapGesture {
                    dataSourse.buttonPressed()
                }
        }
    }
}

#Preview {
    ProtocolsBootcamp(colorTheme: DefaultColorTheme(), dataSourse: DefaultDataSourse())
}
