//
//  EditDeckView.swift
//  FlashCards
//
//  Created by Jacob Hoffman on 1/1/21.
//

import SwiftUI

struct EditDeckView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var deck = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add a new card: ")) {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action:  addCard)
                }
                
                Section {
                    ForEach(0..<deck.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(self.deck[index].prompt)
                                .font(.headline)
                            Text(self.deck[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationBarTitle("Edit Deck")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
            .listStyle(GroupedListStyle())
            .onAppear(perform: loadData)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Deck") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.deck = decoded
            }
        }
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(deck) {
            UserDefaults.standard.set(data, forKey: "Deck")
        }
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        deck.insert(card, at: 0)
        saveData()
    }
    
    func removeCards(at offsets: IndexSet) {
        deck.remove(atOffsets: offsets)
        saveData()
    }
     
}

struct EditDeckView_Previews: PreviewProvider {
    static var previews: some View {
        EditDeckView()
    }
}
