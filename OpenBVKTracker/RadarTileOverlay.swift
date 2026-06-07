//
//  RadarTileOverlay.swift
//  OpenBVKTracker
//
//  Neerslag radar overlay via Rainviewer API (gratis, geen key).
//  Haalt elke 5 minuten het actuele radarpad op en ververst de tiles.
//

import MapKit

/// Eigen MKTileOverlay subklasse zodat de renderer hem uniek kan herkennen.
class RadarTileOverlay: MKTileOverlay {

    /// Basispad van het radarframe, bijv. "/v2/radar/abc123"
    var radarPath: String = ""

    private static let baseURL = "https://tilecache.rainviewer.com"
    private static let colorScheme = 2   // 0=original, 1=universal blue, 2=TITAN
    private static let smooth      = 1   // 1=smooth
    private static let snow        = 1   // 1=snow visible

    init(radarPath: String) {
        self.radarPath = radarPath
        // Tijdelijke placeholder URL — wordt overschreven via url(forTilePath:)
        super.init(urlTemplate: "")
        canReplaceMapContent = false
        minimumZ = 0
        maximumZ = 22  // Rainviewer herhaalt tiles bij hoog zoom — geen limiet nodig
        tileSize = CGSize(width: 256, height: 256)
    }

    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        let urlStr = "\(RadarTileOverlay.baseURL)\(radarPath)/256/\(path.z)/\(path.x)/\(path.y)/\(RadarTileOverlay.colorScheme)/\(RadarTileOverlay.smooth)_\(RadarTileOverlay.snow).png"
        return URL(string: urlStr)!
    }
}
