# OnionUp

## Uptime Checking Service for Tor Hidden Services

### Background

Onion services are websites that are accessible through the Tor anonymity network. These services are gaining popularity among journalists and people in repressive countries. In fact, major companies like the [New York Times](https://www.nytimes3xbfgragh.onion/) and [Facebook](https://facebookcorewwi.onion/) recently launched Onion services for their content. By going through Tor, users gain superior encryption relative to unencrypted, or "clearnet," websites. In order to maintain anonymity, there are certain tradeoffs Tor users are accustomed to. Onion services are much slower than their clearnet counterparts and they go offline frequently. Tor users need the capability to easily check which Onion services are online before they devote a substantial amount of time and effort connecting. This is why we created *OnionUp*, a Pingdom-inspired uptime checker that displays the health of both Onion services and clearnet websites. As an added feature, OnionUp allows users to easily keep track of their favorite Onion services.

### Functionality

OnionUp users can:
- Add clearnet or onion sites to their account
- Track the ping response latency or page load time of any given site 
- Alias cryptic onion site names with readable nicknames
- View graphical representations and statistical analyses to forecast site reliability

### Technology

#### Frontend 

OnionUp's frontend was developed using Vue with VueX to create a Single Page Application (SPA) that provides a seamless, responsive, and beautiful UX. 

| Add Sites | Ping Sites |
| ---------- | --------- |
| ![Add Sites](https://media.giphy.com/media/xT0xeJQt00hGlLOpoc/giphy.gif) | ![Ping Sites](https://media.giphy.com/media/xT0xei2Vk2njAvdBle/giphy.gif) |


Frontend routing of our SPA was accomplished using the Vue Router. We also implemented Vue Routers meta tags and NavigationGuards to navigate unsigned users to the login page. These are OnionUp's frontend routes:

- `/` Index
- `/sites/:id` Site show page (protected)
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


| Navigate Easily | View Site Stats |
| --------------- | --------------- |
| ![Navigate Easily](https://media.giphy.com/media/3o6fIT1NdOEHKgoRJ6/giphy.gif) | ![View Site Statistics](https://media.giphy.com/media/3o6fIV05Vw1KJZCMtW/giphy.gif) |


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
| multi-threaded-pinging | single-threaded-pinging |
| --------------- | --------------- |
| ![multi-threaded-pinging](https://res.cloudinary.com/flyakite/image/upload/v1513404952/ezgif.com-crop_1_owjbdj.gif) | ![single-threaded-pinging](http://res.cloudinary.com/flyakite/image/upload/v1513404956/ezgif.com-crop_2_a1kt65.gif) |

To make sure that a user can ping all of his sites in a reasonable time we used ruby threads to make concurrent requests. This cuts users' wait times to half to a third of synchronous requests
```
    #make a new thread for every site and record the results of attempting a socksify connection.
    # save pings to thread safe finished_ping queue and save after all threads are done.im
    threads = @sites.map do |site|
      Thread.new do
          Ping.new
          ping = pings.pop
          ping.site_id = site.id
          res = site.ping
          p res
          ping.responseTime = res[:responseTime]
          ping.status = res[:status]
          ping.loaded = res[:loaded]
          ping.loadTime = res[:loadTime]
          finished_pings.push(ping)
      end
    end
    
    #wait for threads to finish then save pings
    threads.each{|thr| thr.join}    
    while (!finished_pings.empty?)
      finished_pings.pop(true).save!
    end
```

we also set up automatic updating and cleaning of the database using rake tasks and heroku's scheduler. We set the logic up in rails ActiveJobs to allow us to be flexible in our choice of scheduler. The following code is a rake task that takes in a parameter of oldest ping to keep, selects all ping created before that, and deletes them. 

```  
  def perform(oldestPermitted)
    time = DateTime.now-oldestPermitted
    oldPings = Ping.where("created_at <= ?",time)
    oldPings.each{|ping| ping.delete}
  end

    desc "delete all pings older than parameter. Call like clean:older_than[30] to delete all older than 30 days"
    task :older_than,[:day] => :environment do |t,args|
        days= args[:day].to_i
        RemoveOldPingsJob.new.perform(days)
    end
  ```

### Future Additions

- Use websockets to allow for realtime data updates.

- Delete sites without widowing data (such as pings attached to that site)

- Edit user accounts

- Devise Authentication/Oauth
