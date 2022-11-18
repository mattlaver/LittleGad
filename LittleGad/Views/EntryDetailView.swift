//
//  EntryDetailView.swift
//  LittleGad
//
//  Created by Matt Laver on 17/11/2022.
//

import CoreData
import SwiftUI

struct EntryDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let entry: Entry
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(entry.category ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                Text(entry.category?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
        }
        .navigationTitle(entry.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this entry", systemImage: "trash")
            }
        }
        
        Text(entry.company ?? "Unknown author")
            .font(.title)
            .foregroundColor(.secondary)

        Text(entry.notes ?? "No review")
            .padding()

        RatingView(rating: .constant(Int(entry.rating)))
            .font(.largeTitle)
    }
    
    func deleteBook() {
        moc.delete(entry)

        // uncomment this line if you want to make the deletion permanent
        // try? moc.save()
        dismiss()
    }
}

struct EntryDetailView_Previews: PreviewProvider {
        static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

            static var previews: some View {
                let entry = Entry(context: moc)
                entry.title = "Test Entry"
                entry.rating = 4
                entry.category = "1"
               
                return NavigationView {
                    EntryDetailView(entry: entry)
                }
            
    }
}
