//
//  ContentView.swift
//  LittleGad
//
//  Created by Matt Laver on 16/11/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title)
    ]) var entries: FetchedResults<Entry>
    
    @State private var showingAddScreen = false
    
    //@AppStorage("notes") private var notes = ""

       var body: some View {
           NavigationView {
               List {
                   ForEach(entries) { entry in
                       NavigationLink {
                           EntryDetailView(entry: entry)
                           //Text(entry.title ?? "Unknown Title")
                       } label: {
                           HStack {
                               EmojiRatingView(rating: entry.rating)
                                   .font(.largeTitle)

                               VStack(alignment: .leading) {
                                   Text(entry.title ?? "Unknown Title")
                                       .font(.headline)
                                   Text(entry.company ?? "Unknown company")
                                       .foregroundColor(.secondary)
                               }
                           }
                       }
                   }
                   .onDelete(perform: deleteEntries)
               }
                  .navigationTitle("Bookworm")
                  .toolbar {
                      ToolbarItem(placement: .navigationBarTrailing) {
                          Button {
                              showingAddScreen.toggle()
                          } label: {
                              Label("Add Entry", systemImage: "plus")
                          }
                      }
                      ToolbarItem(placement: .navigationBarLeading) {
                          EditButton()
                      }
                  }
                  .sheet(isPresented: $showingAddScreen) {
                      AddEntryView()
                  }
              
          }
       }
    
    
    func deleteEntries(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let entry = entries[offset]

            // delete it from the context
            moc.delete(entry)
        }

        // save the context
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
