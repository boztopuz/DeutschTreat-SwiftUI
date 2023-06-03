//
//  ContentView.swift
//  WeSplit
//
//  Created by Burak Öztopuz on 22.05.2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDark = false
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocus : Bool
    
    let tipPercentagesList = [0,10,15,20,25]
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let totalTip = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * totalTip
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "TRY"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocus)
                    
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2..<21){
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("How much money will be paid?")
                }
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentagesList, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How much tıp do you want to leave?")
                }
                
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "TRY"))
                } header: {
                    Text("Payment/Person")
                }
            }
            .navigationTitle("Deutsch Treat")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        isDark.toggle()
                    }, label: {
                        isDark ? Label("Dark", systemImage: "sun.max.fill") : Label("Light", systemImage: "moon.fill")
                    })
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        amountIsFocus = false
                    }
                }
            }
        }.environment(\.colorScheme, isDark ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
