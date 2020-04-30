//
//  SecondPage.swift
//  00657025_hw3
//
//  Created by User23 on 2020/4/28.
//  Copyright © 2020 User23. All rights reserved.
//

import SwiftUI

struct SecondPage: View {
    @Binding var showSecondPage: Bool
    @Binding var isProfile: Bool
    @Binding var gender: String
    @Binding var name: String
    @Binding var birthday: Date
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    @Binding var mood: Int
    @Binding var red: Double
    @Binding var green: Double
    @Binding var blue: Double
    @State private var showAlert = false
    @State private var showSheet = false
    @State private var showUp = false
    @State private var showHeart = false
    var number = Int.random(in: 0...10)
    var body: some View {
        VStack {
            if isProfile {
                Image(gender)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 150)
                    .clipShape(Circle())
            }
            else {
                Image("person")
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 160)
                .clipShape(Circle())
            }
            if name == "" {
                Text("No name")
                .font(.custom("SnellRoundhand-Bold", size: 27))
                .bold()
            }
            else {
                Text(name)
                    .font(.custom("SnellRoundhand-Bold", size: 27))
                    .bold()
            }
            Text(dateFormatter.string(from: birthday))
                .font(.custom("SnellRoundhand-Bold", size: 27))
                .bold()
            Spacer()
            ZStack {
                if mood < -3 {
                    Text(upset[number])
                        .font(.custom("AvenirNextCondensed-UltraLightItalic", size: 27))
                }
                else if mood > 3 {
                    Text(elated[number])
                        .font(.custom("AvenirNextCondensed-UltraLightItalic", size: 27))
                }
                else {
                    Text(normal[number])
                        .font(.custom("AvenirNextCondensed-UltraLightItalic", size: 27))
                }
                if showUp {
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 50))
                        .transition(.opacity)
                        .offset(y: 200)
                }
                if showHeart {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 50))
                        .transition(.opacity)
                        .offset(y: 200)
                }
            }
            .animation(.easeInOut(duration: 3))
            Spacer()
            HStack {
                Button(action: {self.showAlert = true}) {
                    Text("說得真好！！")
                        .underline()
                }
                .alert(isPresented: $showAlert) { () -> Alert in
                    return Alert(title: Text("Thank you~\n重開一次看看別句！"))
                }
                Spacer()
                Button(action: {self.showSheet = true}) {
                    Text("按讚！！")
                        .underline()
                }
                .actionSheet(isPresented: $showSheet) {
                    ActionSheet(title: Text("快按快按"), message: Text("有驚喜"), buttons: [.default(Text("讚"), action: {
                        self.showUp = true
                        self.showHeart = false
                    }), .default(Text("愛心"), action: {
                        self.showHeart = true
                        self.showUp = false
                    })])
                }
            }
            .padding()
        }
    .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color(red: red, green:green, blue: blue, opacity: 0.3)
        .edgesIgnoringSafeArea(.all))
    }
}

struct SecondPage_Previews: PreviewProvider {
    static var previews: some View {
        SecondPage(showSecondPage: .constant(true), isProfile: .constant(true), gender: .constant("Boy"), name: .constant(""), birthday: .constant(Date()), mood: .constant(0), red: .constant(0), green: .constant(0), blue: .constant(0))
    }
}
