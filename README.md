# BVK GPX Tracker 🚤

🔒 Laatste security check: 2026-07-07 21:17 CEST

[![Available on the App Store](https://developer.apple.com/assets/elements/badges/download-on-the-app-store.svg)](https://apps.apple.com/nl/app/bvk-gpx-tracker/id6770708440)
![Versie](https://img.shields.io/badge/versie-2.2.0-blue)
![Platform](https://img.shields.io/badge/platform-iOS%2012%2B%20%7C%20watchOS-lightgrey)
![App Store](https://img.shields.io/badge/App%20Store-live%20🟢-brightgreen)

GPS tracker voor iPhone en Apple Watch. Speciaal gebouwd voor **BVK — de Blocq van Kuffeler**. Registreer je vaarroute, voeg waypoints toe en deel je GPX-sporen via e-mail of AirDrop.

---

## Wat is nieuw in versie 2.2.0

- 🌧️ **Neerslag mm/uur** — live neerslag in de infobalk (zichtbaar bij actieve regen)
- 🗺️ **OWM kleurlegenda** — kleine kleurschaal zichtbaar op de kaart bij actieve OWM overlay
- 💨 **Windsnelheid op de pijl** — knotenwaarde als tekst onder de Beaufort-cirkel op de kaart
- ℹ️ **Info-knop verplaatst** — "i" staat nu in de bovenste knoppen-rij rechts van de deelknop

---

## Functies

### iPhone
- GPS-spoor opnemen en weergeven op de kaart
- Kaartservers: Apple Maps, OpenStreetMap, OpenSeaMap, CartoDB, OpenTopoMap
- **OpenWeatherMap kaartlagen** (neerslag, bewolking, wind, druk, temperatuur) met **kleurlegenda**
- Offline kaartcache (browse het gebied vooraf)
- Pauze / Hervat opname
- Waypoints toevoegen (op locatie of via lang indrukken op kaart)
- Waypoint naam bewerken, verplaatsen, verwijderen
- Bestaande sessie laden en verder opnemen
- Huidige locatie, hoogte, snelheid, koers en nauwkeurigheid
- Opgenomen afstand (totaal + huidig segment)
- GPX-bestanden importeren vanuit andere apps
- GPX-bestanden delen via e-mail / AirDrop / andere apps
- Bestandsoverdracht via iTunes
- Donkere modus
- **Snelheidsgebaseerde kaart-zoom** (automatisch, 5 niveaus)
- **Koers-up modus** — kaart draait mee met vaarrichting
- **Live infobalk** — 2 rijen met weer, waterstand, stroming, neerslag en druktrend

### Live weer & water (infobalk)
| Rij | Links | Midden | Rechts |
|-----|-------|--------|--------|
| 1 | Lat / Lon | BVK TRACKER + windrichting | Waterstand (cm NAP) |
| 2 | Temperatuur + zicht | Luchtdruk + trend | Golven + stroming + neerslag |

### Apple Watch
- GPX-sporen opnemen op de Watch
- Pauze / Hervat
- Opslaan als GPX-bestand
- Waypoint toevoegen op huidige locatie
- Bestand sturen naar gekoppelde iPhone
- GPS-signaalsterkte weergeven
- Locatie-informatie: snelheid, lat/lon, hoogte
- **"Doorgaan"** optie in reset-actieblad

### Talen (11)
Nederlands, Engels, Duits, Spaans, Frans, Italiaans, Fins, Portugees (Brazilië), Russisch, Oekraïens, Chinees (vereenvoudigd)

---

## Versiegeschiedenis

| Versie | Datum | Wijzigingen |
|--------|-------|-------------|
| **2.2.0** | 2026-06-09 | Neerslag mm/u in infobalk, OWM kleurlegenda op kaart, windsnelheid kn op windpijl, info-knop in knoppen-rij |
| **2.1.2** | 2026-06-08 | Live weer, OWM kaartlagen, waterstand, windstroming, koers-up, windpijl, nieuw icoon |
| **2.1.1** | 2026-06-05 | Nieuw app-icoon (officieel BvK-logo) |
| **2.1.0** | 2026-06-02 | GPS batterijbesparing, lader-modus, About-scherm bijgewerkt |
| **2.0.0** | 2026-05-29 | Snelheidsgebaseerde zoom, "Doorgaan" actieblad iPhone + Watch, live in App Store |
| 1.10.1 | 2026-05-22 | TestFlight release, stabiliteitsverbeteringen |

---

## Installeren

De app is beschikbaar in de **[App Store](https://apps.apple.com/nl/app/bvk-gpx-tracker/id6770708440)**.

Je kunt de broncode ook zelf compileren met Xcode:
```bash
git clone https://github.com/EdCafferata/BVK-GpxTracker.git
open OpenBVKTracker.xcodeproj
```

---

## Technische details

- **Platform:** iOS 12+ / watchOS
- **Taal:** Swift / UIKit / WatchKit
- **Kaartcaching:** MapCache package
- **Weer:** [Open-Meteo](https://open-meteo.com) — gratis, geen API key nodig
- **Waterstand:** Rijkswaterstaat DDAPI — meetpunt Almere Hollandse Brug (Markermeer)
- **OWM kaartlagen:** [OpenWeatherMap](https://openweathermap.org) — gratis account vereist
- **Privacy:** alle GPS-data blijft op het apparaat of in iCloud als je het daar zelf plaatst — niets wordt gedeeld met derden

---

## Eigenaren

| Naam | Rol |
|------|-----|
| Ed Cafferata | Ontwikkelaar |
| BVK — de Blocq van Kuffeler | Kadootje |

---

## Testers

Frank, Marc, Murali, Tania, Theo, Wil

---

## Licentie

Open BVK Tracker — gebaseerd op [Open GPX Tracker](https://github.com/merlos/iOS-Open-GPX-Tracker) door Juan M. Merlos.
Uitgebracht onder de **GNU General Public License v3.0**.

Gebruikt:
- [CoreGPX Framework](https://github.com/vincentneo/CoreGPX) door [@vincentneo](https://github.com/vincentneo)
- [Open-Meteo](https://open-meteo.com) — weerdata API
- [OpenWeatherMap](https://openweathermap.org) — kaartlagen
- [Rijkswaterstaat DDAPI](https://www.rijkswaterstaat.nl/zakelijk/open-data) — waterstandsdata
