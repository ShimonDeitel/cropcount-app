import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [Harvest] = []
    @Published var isPro: Bool = false

    /// Free tier allows this many entries. Seed data below is always fewer than this
    /// so a fresh install never opens straight into the paywall.
    static let freeLimit = 20

    private let fileName = "cropcount_items.json"

    private var fileURL: URL {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        if !FileManager.default.fileExists(atPath: dir.path) {
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir.appendingPathComponent(fileName)
    }

    init() {
        load()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([Harvest].self, from: data) else {
            items = Self.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    var canAddMore: Bool {
        isPro || items.count < Self.freeLimit
    }

    @discardableResult
    func add(_ item: Harvest) -> Bool {
        guard canAddMore else { return false }
        items.append(item)
        save()
        return true
    }

    func update(_ item: Harvest) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Harvest) {
        items.removeAll { $0.id == item.id }
        save()
    }

    static func seedData() -> [Harvest] {
        [
        Harvest(crop: "Tomatoes", quantity: 3.5, unit: "lb", marketValue: 3.5, harvestDate: Date().addingTimeInterval(-259200)),
        Harvest(crop: "Zucchini", quantity: 5.75, unit: "each", marketValue: 5.75, harvestDate: Date().addingTimeInterval(-518400)),
        Harvest(crop: "Peppers", quantity: 8.0, unit: "lb", marketValue: 8.0, harvestDate: Date().addingTimeInterval(-777600)),
        Harvest(crop: "Tomatoes", quantity: 10.25, unit: "each", marketValue: 10.25, harvestDate: Date().addingTimeInterval(-1036800))
        ]
    }
}
