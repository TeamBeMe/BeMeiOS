
import WidgetKit
import SwiftUI


struct TodoEntry: TimelineEntry {
    let date = Date()
    let question: String
    
    
    
}


@available(iOS 14.0, *)
struct Provider: TimelineProvider {
    let myDefaults = UserDefaults.init(suiteName: "group.com.teamBeMe.BeMe1")


    func getTimeline(in context: Context, completion: @escaping (Timeline<TodoEntry>) -> Void) {
        guard let question = myDefaults?.string(forKey: "question")  else { return}
        let entry = TodoEntry(question: question)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
        
    }
    
    func placeholder(in context: Context) -> TodoEntry {
        guard let question = myDefaults?.string(forKey: "question")  else { return TodoEntry(question: "")}
        return TodoEntry(question: question)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (TodoEntry) -> Void) {
        guard let question = myDefaults?.string(forKey: "question")  else { return}
        
        let entry = TodoEntry(question: question)
        completion(entry)
        
        
        
    }
    
   
    
    
    typealias Entry = TodoEntry
    
    
    
}


struct PlaceholderView: View{
    let entry: Provider.Entry
    var body: some View {
       
        Text(entry.question)
            .foregroundColor(.white)
            
    }
    
    
}


@available(iOS 14.0, *)
struct WidgetEntryView: View {
    let entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Text(entry.question)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
               
        }
       
    }
     
    
}



@main
struct BeMeWidget: Widget {
    private let kind = "BeMeWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
            
        }
        .configurationDisplayName("오늘의 질문")
        .description("오늘의 질문을 체크해보세요")
    }
    
    
}
