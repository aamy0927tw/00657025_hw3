//
//  ContentView.swift
//  00657025_hw3
//
//  Created by User23 on 2020/4/28.
//  Copyright © 2020 User23. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showSecondPage = false
    @State private var isProfile = false
    @State private var gender = "Boy"
    let gend = ["Boy", "Girl"]
    @State private var name = ""
    @State private var birthday = Date()
    @State private var mood = 0
    @State private var red: Double = 0
    @State private var green: Double = 0
    @State private var blue: Double = 0
    @State private var showAlert = false
    var body: some View {
        VStack {
            if isProfile {
                Image(gender)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipped()
            }
            else {
                Image("person")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipped()
            }
            Form {
                Toggle("Do you want to show picture?", isOn: $isProfile)
                if isProfile {
                    VStack(alignment: .leading) {
                        Picker("Gender", selection: $gender) {
                            ForEach(gend, id: \.self) { (gende) in
                                Text(gende)
                            }
                        }
                    .pickerStyle(SegmentedPickerStyle())
                    }
                }
                TextField("What's your Name?", text: $name)
                DatePicker("When is your birthday?", selection: $birthday, in: ...Date(), displayedComponents: .date)
                Stepper(value: $mood, in: -10...10) {
                    if mood < -3 {
                        Text("Mood: Upset")
                    }
                    else if mood > 3 {
                        Text("Mood: Elated")
                    }
                    else {
                        Text("Mood: Normal")
                    }
                }
                chooseColor(red: $red, green: $green, blue: $blue)
            }
            Text("Your color")
                .font(.headline)
                .frame(width: 200, height: 100)
                .background(Color(red: red, green: green, blue: blue, opacity: 0.3))
            Spacer()
            Button(action: {self.showSecondPage = true}) {
                Text("OK!")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.purple)
                    .frame(width: 80, height: 50)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.purple, lineWidth: 5))
            }
            .sheet(isPresented: self.$showSecondPage) {
                SecondPage(showSecondPage: self.$showSecondPage, isProfile: self.$isProfile, gender: self.$gender, name: self.$name, birthday: self.$birthday, mood: self.$mood, red: self.$red, green: self.$green, blue: self.$blue)
            }
        }
    .background(Image("back1")
    .resizable()
    .scaledToFill()
    .opacity(0.7)
    .edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct chooseColor: View {
    @Binding var red: Double
    @Binding var green: Double
    @Binding var blue: Double
    var body: some View {
        VStack {
            HStack {
                Text("Red")
                    .foregroundColor(Color.red)
                Slider(value: $red, in: 0...1)
                    .accentColor(.red)
            }
            HStack {
                Text("Green")
                    .foregroundColor(Color.green)
                Slider(value: $green, in: 0...1)
                    .accentColor(.green)
            }
            HStack {
                Text("Blue")
                    .foregroundColor(Color.blue)
                Slider(value: $blue, in: 0...1)
                    .accentColor(.blue)
            }
        }
    }
}
