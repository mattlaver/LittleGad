//
//  AddEntryView.swift
//  LittleGad
//
//  Created by Matt Laver on 17/11/2022.
//

import SwiftUI

struct AddEntryView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var notes = ""
    @State private var company = ""
    @State private var created_by = ""
    @State private var category = ""
    @State private var rating = 3
    
    let categories = ["utility", "invoice"]
    
    //@State private var author = ""

    //@State private var genre = ""
    //@State private var review = ""
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Company", text: $company)

                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextEditor(text: $notes)
                    RatingView(rating: $rating)
                } header: {
                    Text("Notes")
                }

                Section {
                    Button("Save") {
                        let newEntry = Entry(context: moc)
                        newEntry.id = UUID()
                        newEntry.title = title
                        newEntry.company = company
                        newEntry.notes = notes
                    
                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add")
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
