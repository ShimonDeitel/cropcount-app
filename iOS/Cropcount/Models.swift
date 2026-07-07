import Foundation

struct Harvest: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var crop: String
    var quantity: Double
    var unit: String
    var marketValue: Double
    var harvestDate: Date

    init(id: UUID = UUID(), crop: String = "", quantity: Double = 0.0, unit: String = "", marketValue: Double = 0.0, harvestDate: Date = Date()) {
        self.id = id
        self.crop = crop
        self.quantity = quantity
        self.unit = unit
        self.marketValue = marketValue
        self.harvestDate = harvestDate
    }
}
