//
//  SatelliteTileOverlay.swift
//  OpenBVKTracker
//
//  Infrarood satelliet overlay via Rainviewer API (gratis, geen key).
//

import MapKit

/// Satelliet (infrarood) tile overlay via Rainviewer.
class SatelliteTileOverlay: MKTileOverlay {

    var satellitePath: String = ""

    private static let baseURL = "https://tilecache.rainviewer.com"

    init(satellitePath: String = "") {
        self.satellitePath = satellitePath
        super.init(urlTemplate: "")
        canReplaceMapContent = false
        minimumZ = 0
        maximumZ = 22
        tileSize = CGSize(width: 256, height: 256)
    }

    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        // Als er een pad beschikbaar is via de API, gebruik dat. Anders vaste v2/satellite URL.
        let radarPart = satellitePath.isEmpty ? "/v2/satellite" : satellitePath
        let urlStr = "\(SatelliteTileOverlay.baseURL)\(radarPart)/256/\(path.z)/\(path.x)/\(path.y)/0/0_0.png"
        return URL(string: urlStr)!
    }
}
