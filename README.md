# OnionUp

## Uptime Checking Service for Tor Hidden Services

### Background

Onion services are websites that are accessible through the Tor anonymity network. These services are gaining popularity among journalists and people in repressive countries. In fact, major companies like the [New York Times](https://www.nytimes3xbfgragh.onion/) and [Facebook](https://facebookcorewwi.onion/) recently launched Onion services for their content. By going through Tor, users gain superior encryption relative to unencrypted, or "clearnet," websites. In order to maintain anonymity, there are certain tradeoffs Tor users are accustomed to. Onion services are much slower than their clearnet counterparts and they go offline frequently. Thus, Tor users would benefit from a utility to check which sites are online before they devote a substantial amount of time and effort connecting. OnionUp is a Pingdom-inspired uptime checker that displays the health of both Onion services and clearnet websites. As an added feature, OnionUp will allow users to easily keep track of their favorite Onion services.

### Functionality

OnionUp users can:
- Add clearnet or onion sites to their account
- Track the ping response latency or page load time of any given site 
- Alias cryptic onion site names with readable nicknames
