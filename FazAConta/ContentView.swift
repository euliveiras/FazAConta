//
//  ContentView.swift
//  FazAConta
//
//  Created by Matheus Oliveira  on 12/03/23.
//

import SwiftUI

struct ConfigurationsPage: View {
    @State var start: Int
    @State var end: Int
    
    var onSave: (_ start: Int, _ end: Int) -> Void
    
    func save() {
        onSave(start, end)
    }
    
    var body: some View {
        VStack {
            Text("Escolha as tabuadas que você quer praticar")
            
            Form {
                Section {
                    Stepper("\(start)", value: $start, in: 1...10)
                } header: {
                    Text("Tabuada de")
                }
                
                Section {
                    Stepper("\(end)", value: $end, in: 1...10)
                } header: {
                    Text("até")
                }
            }
            
            Button("Salvar configurações") {
                save()
            }
            
        }
        
        .navigationTitle("Configurações")
    }
}

struct Expression: View {
    @Binding var showResult: Bool
    @State var userAnswer: Int? = nil
    
    @State var firstFactor = Array(1...10).randomElement()!
    @State var secFactor: Int = Array(1...10).randomElement()!

    var body: some View {
        HStack{
            Text("\(firstFactor) x \(secFactor) = ")
            TextField("", value: $userAnswer, format: .number)
                .foregroundColor(showResult ? userAnswer == (firstFactor * secFactor) ? .green : .red : .black)
        }
    }
}

struct ContentView: View {
    @State var tables: [String: Int] = ["start": 1, "end": 10]
    @State var numberOfExercises: Int = 10
    @State var showResults = false
    
    func onSave(start: Int, end: Int) {
        tables["start"] = start
        tables["end"] = end
        
        print(tables)
    }
    
    var body: some View {
        NavigationStack {
            Spacer()
            
            VStack {
                VStack{
                    Text("Faz a conta")
                        .font(.largeTitle)
                    Text("Pratique! Nem sempre a calculadora tá na mão")
                        .font(.subheadline)
                }
                
            }
            
            Spacer()
            Spacer()
            
                .toolbar {
                    NavigationLink("Configurações") {
                        ConfigurationsPage(start: tables["start"] ?? 1, end: tables["end"] ?? 10, onSave: onSave)
                    }
                }
            
            NavigationLink {
                List {
                    ForEach(1..<numberOfExercises, id: \.self) { _ in
                        Expression(showResult: $showResults, secFactor: Array(tables["start"]!...tables["end"]!).randomElement()!)
                    }
                }
                
                Button(showResults ? "Esconder resultados" : "Mostrar resultados" ) {
                    showResults.toggle()
                }
            } label: {
                Text("Começar")
                    .font(.title)
                Image(systemName: "arrow.right")
                    .font(.title)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
