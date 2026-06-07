//
//  SatelliteTileOverlay.swift
//  OpenBVKTracker
//
//  Satelliettiles via NASA GIBS (gratis, geen API key).
//  Toont MODIS Terra ware-kleur satellietbeelden van de huidige dag.
//  URL formaat: {z}/{TileRow}/{TileCol} = zoom/y/x (omgedraaid t.o.v. standaard)
//

import MapKit

/// Satelliet tile overlay via NASA GIBS (Earthdata).
class SatelliteTileOverlay: MKTileOverlay {

    private static let baseURL = "https://gibs.earthdata.nasa.gov/wmts/epsg3857/best/MODIS_Terra_CorrectedReflectance_TrueColor/default"
    private static let matrixSet = "GoogleMapsCompatible_Level9"

    static func make(path: String = "") -> SatelliteTileOverlay {
        let overlay = SatelliteTileOverlay(urlTemplate: "placeholder")
        overlay.canReplaceMapContent = false
        overlay.minimumZ = 0
        overlay.maximumZ = 9  // MODIS Terra max = level 9
        overlay.tileSize = CGSize(width: 256, height: 256)
        return overlay
    }

    /// NASA GIBS gebruikt {z}/{TileRow}/{TileCol} = zoom/y/x (let op: y en x omgedraaid!)
    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        let dateStr = SatelliteTileOverlay.todayString()
        let urlStr = "\(SatelliteTileOverlay.baseURL)/\(dateStr)/\(SatelliteTileOverlay.matrixSet)/\(path.z)/\(path.y)/\(path.x).jpg"
        return URL(string: urlStr)!
    }

    private static func todayString() -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        fmt.timeZone = TimeZone(identifier: "UTC")
        return fmt.string(from: Date())
    }
}
