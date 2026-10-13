import 'dart:io';

enum HostScope { loopback, privateNetwork, public }

/// Classifies the gateway host so the app can warn before sending breeding
/// data anywhere that is not the user's own machine or private network.
/// Private = RFC1918, link-local, CGNAT/Tailscale (100.64/10), IPv6 ULA,
/// `*.local` (mDNS) and `*.ts.net` (Tailscale MagicDNS).
HostScope classifyHost(String host) {
  final h = host.toLowerCase().replaceAll(RegExp(r'^\[|\]$'), '');
  if (h == 'localhost' || h.endsWith('.localhost')) return HostScope.loopback;
  if (h.endsWith('.local') || h.endsWith('.ts.net') || h.endsWith('.home.arpa')) {
    return HostScope.privateNetwork;
  }
  final ip = InternetAddress.tryParse(h);
  if (ip == null) return HostScope.public;
  if (ip.isLoopback) return HostScope.loopback;
  if (ip.isLinkLocal) return HostScope.privateNetwork;
  if (ip.type == InternetAddressType.IPv4) {
    final b = ip.rawAddress;
    if (b[0] == 10) return HostScope.privateNetwork;
    if (b[0] == 172 && b[1] >= 16 && b[1] <= 31) return HostScope.privateNetwork;
    if (b[0] == 192 && b[1] == 168) return HostScope.privateNetwork;
    if (b[0] == 100 && b[1] >= 64 && b[1] <= 127) return HostScope.privateNetwork;
    return HostScope.public;
  }
  final b = ip.rawAddress;
  if ((b[0] & 0xfe) == 0xfc) return HostScope.privateNetwork; // fc00::/7
  return HostScope.public;
}

/// HTTPS is required except for loopback development.
bool isTransportAllowed(Uri uri) =>
    uri.scheme == 'https' || (uri.scheme == 'http' && classifyHost(uri.host) == HostScope.loopback);
