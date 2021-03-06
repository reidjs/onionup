# OnionUp

## LIVE LINK: https://onionup.herokuapp.com

## Uptime Checking Service for Tor Hidden Services

### Background

Onion services are websites that are accessible through the Tor anonymity network. These services are gaining popularity among journalists and people in repressive countries. In fact, major companies like the [New York Times](https://www.nytimes3xbfgragh.onion/) and [Facebook](https://facebookcorewwi.onion/) recently launched Onion services for their content. By going through Tor, users gain superior encryption relative to unencrypted, or "clearnet," websites. In order to maintain anonymity, there are certain tradeoffs Tor users are accustomed to. Onion services are much slower than their clearnet counterparts and they go offline frequently. Thus, Tor users would benefit from a utility to check which sites are online before they devote a substantial amount of time and effort connecting. OnionUp is a Pingdom-inspired uptime checker that displays the health of both Onion services and clearnet websites. As an added feature, OnionUp will allow users to easily keep track of their favorite Onion services.


### Functionality & MVP 

Users can 

- [ ] Sign in/Sign out 
- [ ] Add sites to track
- [ ] View index of sites. Each site will show the health (up or down), ping time, and a live graph
- [ ] View specific site details and remove site from their tracker.
- [ ] Edit site specifics such as a site alias and descriptions.

### Wireframes

Index of sites 

![Index](https://github.com/reidjs/onionup/blob/master/wireframes/index_view.png)

Log in modal 

![Session Modal](https://github.com/reidjs/onionup/blob/master/wireframes/session_modal.png)

Site view 

![Site View](https://github.com/reidjs/onionup/blob/master/wireframes/site_view.png)

### Technologies and Technical Challenges

This will be implemented using a Ruby on Rails backend with a vue frontend. 

Primary technical challenges:

* Pinging Tor sites from an Amazon EC2 Instance
* Deploying to heroku (heroku uses dynamic ips which will cause issues with the tor proxy)
* Linking Vue with the Ruby on Rails backend
* Building live graphs with D3
* User authentication 

### Things we accomplished this weekend.

1. Opened Amazon ec2 port successfully 
2. Set up multi-threaded pinger
3. (Hopefully) integrated vue frontend with rails backend

### Group Members and Work Breakdown

Our group consists of four members, Chris Bigelow, Jay Park, Artem Kharshan, Reid Sherman

Primary Responsibilities

Chris:

* Amazon server setup
* Heroku deployment
* Tor port setup

Jay: 

* Wireframes
* Vue frontend components 
* Devise auth 

Artem: 

* Running multiple threads to ping many sites at once
* Setting up sidekiq/jobs
* Sending data from backend to frontend 

Reid:

* Writing Readme 
* D3 for graphs 
* Integrating rails with vue 
* Vue frontend components

## Monday

**Reid**

- [ ] Site show page 
- [ ] User show page
- [ ] Settings show page 

**Jay**

- [ ] Index Component 
- [ ] Sidebar/page styling, navigation

**Chris** 
- [ ] Have rails server running concurrently with onion proxy able to make ping requests
- [ ] Bootup tor and rails with one command 

**Artem**

- [ ] Making APIs for frontend to get information 
- [ ] Timestamped data for graphs

## Tuesday

**Reid**

- [ ] Graphing ping data in d3

**Jay**

- [ ] Create site card component for index 

**Chris** 

- [ ] Store ping data in database and requesting data 

**Artem**

- [ ] Look into websockets (Application Cable) connecting front and backend

## Wednesday

**Reid**

- [ ] Display historical data from backend to frontend

**Jay**

- [ ] Create site cards in vue

**Chris** 

- [ ] Display historical data from backend to frontend 

**Artem**

- [ ] Work on concurrency in backend

## Thursday

**Reid**

- [ ] Polish frontend user accounts

**Jay**

- [ ] Polish frontend sites page

**Chris** 

- [ ] Launch to Heroku

**Artem**

- [ ] Optimize pinging algorithm

## Friday

**Reid**

- [ ] Write production readme

**Jay**

- [ ] Ensure frontend is responsive for different screen sizes

**Chris** 

- [ ] Deploy to heroku

**Artem**

- [ ] Deploy to heroku

