//
//  ContentView.swift
//  Pick-a-Pal
//
//  Created by Teddy on 11/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var names: [String] = []
    @State private var nameToAdd: String = ""
    @State private var pickedName: String = ""
    @State private var shouldRemovePickedName: Bool = false
    
    private func pickAName() {
        if let randomName = names.randomElement() {
            withAnimation(.linear(duration: 0.1)) {
                pickedName = randomName
            }
            if shouldRemovePickedName {
                names.removeAll() { name in
                    return name == randomName
                }
            }
        } else {
            pickedName = ""
        }
    }
    
    private func handleSubmit() {
        if !nameToAdd.isEmpty && !names.contains(nameToAdd) {
            names.append(nameToAdd)
            nameToAdd = ""
        }
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Image(systemName: "person.3.sequence.fill")
                    .foregroundStyle(.tint)
                    .symbolRenderingMode(.hierarchical)
                Text("Pick-a-Pal")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .font(.title)
            .bold()
            Text(!pickedName.isEmpty ? pickedName : " ")
                .font(.title3)
                .foregroundStyle(.tint)
                .padding(.top, 8)
            if !names.isEmpty{
                HStack {
                    Spacer()
                    Button {
                        names = []
                    } label: {
                        Text("Reset")
                }
                }
            }
            List {
                ForEach(names, id: \.self) {name in
                    Text(name)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            TextField("Add a name", text: $nameToAdd)
                .autocorrectionDisabled()
                .onSubmit {
                    handleSubmit()
                }
            Divider()
            Toggle("Remove when piched", isOn: $shouldRemovePickedName)
            Button {
                pickAName()
            } label: {
                Text("Pick random name")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
