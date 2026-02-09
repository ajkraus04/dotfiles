import CoreWLAN
import Foundation

let client = CWWiFiClient.shared()
guard let iface = client.interface() else {
    print("CURRENT:Not Connected")
    exit(0)
}

// Try to get current SSID
let currentSSID = iface.ssid()
let hasIP = iface.powerOn()

// Scan for nearby networks
do {
    let networks = try iface.scanForNetworks(withName: nil)

    // Deduplicate by SSID, keeping strongest signal
    var best: [String: (Int, CWNetwork)] = [:]
    for n in networks {
        guard let ssid = n.ssid, !ssid.isEmpty else { continue }
        if let existing = best[ssid] {
            if n.rssiValue > existing.0 {
                best[ssid] = (n.rssiValue, n)
            }
        } else {
            best[ssid] = (n.rssiValue, n)
        }
    }

    // If we have a current SSID, print it
    if let ssid = currentSSID {
        print("CURRENT:\(ssid)")
    } else {
        print("CURRENT:Unknown")
    }

    // Print sorted networks
    let sorted = best.sorted { $0.value.0 > $1.value.0 }
    for (ssid, (rssi, _)) in sorted {
        let connected = (ssid == currentSSID) ? "YES" : "NO"
        print("NET:\(ssid)|\(rssi)|\(connected)")
    }
} catch {
    if let ssid = currentSSID {
        print("CURRENT:\(ssid)")
    } else {
        print("CURRENT:Unknown")
    }
    print("SCAN_ERROR:\(error)")
}
