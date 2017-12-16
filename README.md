# OnionUp

## Uptime Checking Service for Tor Hidden Services

### Background

Onion services are websites that are accessible through the Tor anonymity network. These services are gaining popularity among journalists and people in repressive countries. In fact, major companies like the [New York Times](https://www.nytimes3xbfgragh.onion/) and [Facebook](https://facebookcorewwi.onion/) recently launched Onion services for their content. By going through Tor, users gain superior encryption relative to unencrypted, or "clearnet," websites. In order to maintain anonymity, there are certain tradeoffs Tor users are accustomed to. Onion services are much slower than their clearnet counterparts and they go offline frequently. Thus, Tor users would benefit from a utility to check which sites are online before they devote a substantial amount of time and effort connecting. OnionUp is a Pingdom-inspired uptime checker that displays the health of both Onion services and clearnet websites. As an added feature, OnionUp will allow users to easily keep track of their favorite Onion services.

### Functionality

OnionUp users can:
- Add clearnet or onion sites to their account
- Track the ping response latency or page load time of any given site 
- Alias cryptic onion site names with readable nicknames
- View graphical representations and statistical analyses to forecast site reliability

### Technology

#### Frontend 

OnionUp's frontend was developed as a Vue single page web application to provide a seamless and responsive UX. 

- show vuetify

- show graphs 


Frontend routing of our SPA (Single Page App) was accomplished using the Vue Router. These are OnionUp's frontend routes:

- `/` Index
- `/sites/:id` Site show page
- `/login` Login form
- `/signup` Signup form

To ensure data consistency, we utilized flux architecture by integrating Vue with Vuex. This simplified our state to this simple object
```
  state: {
    sites: {},
    pings: {},
    session: { currentUser:getUser},
    errors: null
  }
```

#### Backend

OnionUp's backend leverages Ruby on Rails concurrency using Rails ActiveJobs to ensure multiple sites can be pinged as a background task.


To ping Tor sites, we used `socksify/http` to route traffic through a SOCKS5 proxy. The following ruby code allowed us to retrieve both the HTTP Response and the load time of any onion or clearnet site. 

```
uri = URI.parse(self.url)
      begin
        puts "started socks request!  url: " + self.url
        a = Time.now
        Net::HTTP.SOCKSProxy(ENV['TOR_IP'], 9050).start(uri.host, uri.port, open_timeout:10) do |http|
          b = Time.now
          status = true
          responseTime =  (b-a)*1000
          http.read_timeout = 10
          http.open_timeout = 10
          begin
            a = Time.now
            res = http.get(uri)
            b = Time.now
            loaded = true
            loadTime = (b-a)*1000
          rescue
            return {responseTime:responseTime, loadTime:loadTime, status: status, loaded:loaded}
          end 
        end
        return {responseTime:responseTime, loadTime:loadTime, status: status, loaded:status}
      rescue
        puts "Host unreachable error"
      end
    
```


### Future Additions

- Use websockets to allow for realtime data updates.

- Delete sites without widowing data (such as pings attached to that site)

- Edit user accounts

- Devise Authentication/Oauth