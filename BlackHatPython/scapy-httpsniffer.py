from scapy.all import *

def packet_callback(packet):
    if packet[TCP].payload:
        http_packet  = str(packet[TCP].payload)
        if "google" in http_packet.lower() or "twitter" in http_packet.lower():
            print("[*] Server: %s" % packet[IP].dst)
            print("[*] %s" % packet[TCP].payload)

sniff(filter="tcp port 80",prn=packet_callback,store=0)
