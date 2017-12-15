import Vuex from 'vuex';
import Vue from 'vue';
Vue.use(Vuex);
import axios from 'axios';
let getUser = undefined;

if (window.currentUser) {
  // console.log("BOOTSTRAP");
  getUser = window.currentUser;
}

// console.log("STORE",window.currentUser);

export const store = new Vuex.Store({
  state: {
    sites: {},
    pings: {},
    session: { currentUser:getUser},
    errors: null
  },
  getters: {
    sites: state => state.sites,
    session: state => state.session,
    pings: state => state.pings,
    errors: state => state.errors
  },
  mutations: {
    ADD_CURRENT_USER (state, payload) {
      const currentUser = {
        id: payload.id,
        username: payload.username
      };
      state.session.currentUser = currentUser;
    },
    ADD_SITE (state, payload) {
      const site = {
        id: payload.id,
        url: payload.url
      };
      state.sites.unshift(site); 
    },
    LOGOUT (state) {
      state.session = {currentUser: undefined};
      state.sites = {};
      state.pings = {};
    },
    SET_ERRORS (state, payload) {
      state.errors = payload;
    },
    CLEAR_ERRORS (state) {
      state.errors = null;
    },
    CLEAR_SITES (state) {
      state.sites = {};
    },
    CLEAR_PINGS (state) {
      state.pings = {};
    }, 
    ADD_SITES(state,payload){
      state.sites = Object.assign({},state.sites, payload);
    },
    ADD_PINGS(state, payload){
      // state.pings = Object.assign({},state.pings, payload);
      state.pings = Object.assign({},state.pings,payload)
    }
  },
  actions: {
    addSite (context) {
      context.commit('ADD_SITE');
    },
    clearSites (context) {
      context.commit('CLEAR_SITES');
    },
    clearPings (context) {
      context.commit('CLEAR_PINGS');
    },
    clearErrors (context) {
      context.commit('CLEAR_ERRORS');
    },
    postSite(context, site) {
      return axios.post(`api/sites`, {site : {url:site}})
        .then(res => {
          // console.log("res",res)
          context.commit('ADD_SITES', res.data)
          return (res)
        })
        .catch(e => {
          // console.log("didnt post site") 
          return (false)
        })
    },
    logCurrentUserIn (context, user) {
      context.commit('CLEAR_ERRORS');
      // console.log('logCurrentUserIn action',user);


        return axios.post(`api/session`, user )
          .then(res => {
            // console.log('addcurrenuser OK', res.data);
            // window.currentUser='true';
            context.commit('ADD_CURRENT_USER', res.data);
            
          })
          .catch(e => {
            // console.log('addcurrenuser ERROR', e);
            // debugger
            context.commit('SET_ERRORS', e.response.data[0]);
          });
      
    },
    signUserIn(context, user){
        context.commit('CLEAR_ERRORS');
        return axios.post(`api/users`,
          user
        )
          .then(res => {
            context.commit('ADD_CURRENT_USER', res.data);
            return true;
            // alert(`logged in as ${res.data.username}`)
          })
          .catch(e => {
            // console.log(e);
            context.commit('SET_ERRORS', e.response.data[0]);
            return false;
          });
      
    },
    logout (context) {
      return axios.delete(`api/session`)
        .then(res => {
          context.commit('LOGOUT');
          // alert(`logged in as ${res.data.username}`)
        })
        .catch(e => {
          console.log(e);
          context.commit('SET_ERRORS', e.response.data[0]);
        });


      
    },
    getSite(context, id){
      return axios.get(`api/sites/${id}`)
        .then(res => {
          // console.log("gite got", res);
          context.commit('ADD_SITES', res.data.sites)
          context.commit('ADD_PINGS', res.data.pings)
        })
        .catch(e => {
          // console.log('failed to get ping request');

        })
    },
    getSites(context) {
      // console.log("getsites")
      return axios.get(`api/sites`)
        .then(res => {
          context.commit('ADD_SITES', res.data.sites)
          context.commit('ADD_PINGS', res.data.pings)
        })
        .catch(e => {
          // console.log('failed to get ping request');

        })
    },
    pingSite(context, siteId){
      return axios.get(`api/ping/${siteId}`)
        .then(res => {
          context.commit('ADD_SITES', res.data.site);
          context.commit('ADD_PINGS', res.data.pings); 
        })
        .catch(e => {
          // console.log('failed to get ping request');
  
        })      
    },
    pingSites(context){
      return axios.get(`api/ping`)
          .then(res => {
            // this shouldnd be needed BUT
            // without also adding sites the site_component doesnt update :(
            context.commit('ADD_SITES', res.data.sites)

            context.commit('ADD_PINGS', res.data.pings) 
          })
          .catch(e => {
            // console.log('failed to get ping request');

          })      
    }
  }
  
});