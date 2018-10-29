import Foundation
import SQLite

struct SeedDB: Migration {
  var version: Int64 = 20160119131206685

  func migrateDatabase(db: Connection) throws {
    let episodes = Table("episodes")
    let season = Expression<Int>("season")
    let name = Expression<String>("name")

    try (1...24).map { "Episode \($0)" }.forEach {
      try db.run(episodes.insert(season <- 1, name <- $0))
    }
  }
}

struct YunTV: Migration {
    var version: Int64 = 20160828150706685
    
    func migrateDatabase(db: Connection) throws {
        let table = Table("television")
        
        let id = Expression<Int64>("id")
        let deviceId = Expression<String>("deviceId") // 投放内容的body 电视的deviceId
        let name = Expression<String>("name") // 投放内容的title 电视的name
        let date = Expression<NSDate>("date")
        let remark = Expression<String?>("remark") // 电视的备注
        let enable = Expression<Bool?>("enable")
        do {
            try db.run(table.create {
                $0.column(id, primaryKey: true)
                $0.column(deviceId)
                $0.column(name)
                $0.column(date)
                $0.column(remark)
                $0.column(enable)
                })
        } catch {
            print("📈📈📈 table create error 此错误暂时忽略")
        }

    }
}
