#!/bin/bash
swift -e '
import CoreWLAN
import Foundation
let client = CWWiFiClient.shared()
guard let iface = client.interface() else {
    print("CURRENT:Not Connected")
    exit(0)
}
let currentSSID = iface.ssid()
if let ssid = currentSSID { print("CURRENT:\(ssid)") }
else { print("CURRENT:Unknown") }
do {
    let networks = try iface.scanForNetworks(withName: nil)
    var best: [String: Int] = [:]
    for n in networks {
        guard let ssid = n.ssid, !ssid.isEmpty else { continue }
        if let existing = best[ssid] { if n.rssiValue > existing { best[ssid] = n.rssiValue } }
        else { best[ssid] = n.rssiValue }
    }
    for (ssid, rssi) in best.sorted(by: { $0.value > $1.value }) {
        let c = (ssid == currentSSID) ? "YES" : "NO"
        print("NET:\(ssid)|\(rssi)|\(c)")
    }
} catch { print("SCAN_ERROR:\(error)") }
' 2>/dev/null
