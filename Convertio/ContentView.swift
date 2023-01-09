//
//  ContentView.swift
//  Convertio
//
//  Created by MAC on 09/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputUnit =  ""
    @State private var outputUnit = ""
    @State private var value = 0
    @FocusState private var valueIsFocused: Bool
    
    let timeFrames = ["Seconds", "Minutes", "Hours", "Days"]
    
    
    //---------------------------------
    var newestValue: Int {
        var newValue = 0
        
        switch inputUnit {
            
        case "Minutes":
            newValue = value * 60
            
        case "Hours":
            newValue = value * 3600
            
        case "Days":
            newValue = value * 86400
            
        default:
            newValue = value
        }
        
        return newValue
    }
    
    //---------------------------------
    var result: Double {
        var convertedResult = 0.0
        
        switch outputUnit {
            
        case "Minutes":
            convertedResult = Double(newestValue) / 60
            
        case "Hours":
            convertedResult = Double(newestValue) / 3600
            
        case "Days":
            convertedResult = Double(newestValue) / 86400
            
        default:
            convertedResult = Double(newestValue)
        }
        
        return round(convertedResult * 10) / 10.0
    }
    
    //-------------------------------------------------------------------------
    var body: some View {
        NavigationView {
            Form{
            //-----------------------------------
                Section{
                    TextField("Enter Value", value:$value, format: .number)
                        .keyboardType(.numberPad)
                        .focused($valueIsFocused)
                }header: {
                    Text("Enter Time Value:")
                }
            //-----------------------------------
                Section{
                    Picker("TimeFrames", selection:$inputUnit) {
                        ForEach(timeFrames, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Convert From")
                }
            //-----------------------------------
                Section{
                    Picker("TimeFrames", selection:$outputUnit) {
                        ForEach(timeFrames, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Convert To")
                }
            //-----------------------------------
                Section{
                    Text("Result")
                    Text("\(result.formatted()) \(outputUnit)")
                }
            //-----------------------------------
                
                
            }.navigationTitle("Time Converter")
             .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                                        
                     Button("Done") {
                        valueIsFocused = false
                    }
                }
         }

      }
   }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
