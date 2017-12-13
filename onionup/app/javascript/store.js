import Vuex from 'vuex';
import Vue from 'vue';
Vue.use(Vuex);
import axios from 'axios';
let getUser = undefined;

if (window.currentUser) {
  console.log("BOOTSTRAP");
  getUser = window.currentUser;
}

// console.log("STORE",window.currentUser);

export const store = new Vuex.Store({
  state: {
    sites: {},
    session: { currentUser:getUser},
    errors: null
  },
  getters: {
    sites: state => state.sites,
    session: state => state.session,
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
    },
    SET_ERRORS (state, payload) {
      state.errors = payload;
    },
    CLEAR_ERRORS (state) {
      state.errors = null;
    },
    ADD_SITES(state,payload){
      state.sites = Object.assign({},state.sites, payload);
    },
    ADD_PINGS(state, payload){
      state.pings = Object.assign({},state.sites, payload);
    }
  },
  actions: {
    addSite (context, site) {
      context.commit('CLEAR_ERRORS');
      context.commit('ADD_SITE');

        // return axios.post(`api/sites`, site)
        //   .then()
    },
    clearErrors (context) {
      context.commit('CLEAR_ERRORS');
    },
    logCurrentUserIn (context, user) {
      context.commit('CLEAR_ERRORS');
      console.log('logCurrentUserIn action',user);


        return axios.post(`api/session`,

          user
        )
          .then(res => {
            console.log('addcurrenuser OK', res.data);
            // window.currentUser='true';
            context.commit('ADD_CURRENT_USER', res.data);
            
          })
          .catch(e => {
            console.log('addcurrenuser ERROR', e);
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
            // alert(`logged in as ${res.data.username}`)
          })
          .catch(e => {
            console.log(e);
            context.commit('SET_ERRORS', e.response.data[0]);
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
          console.log("gite got", res);
          context.commit('ADD_SITES', res.data.sites)
          context.commit('ADD_PINGS', res.data.pings)
        })
        .catch(e => {
          console.log('failed to get ping request');

        })
    },
    getSites(context) {
      console.log("getsites")
      return axios.get(`api/sites`)
        .then(res => {
          context.commit('ADD_SITES', res.data.sites)
          context.commit('ADD_PINGS', res.data.pings)
        })
        .catch(e => {
          console.log('failed to get ping request');

        })
    },
    pingSites(context){
      return axios.get(`api/ping`)
          .then(res => {
            context.commit('ADD_SITES', res.data.sites)
            context.commit('ADD_PINGS', res.data.pings) 
          })
          .catch(e => {
            console.log('failed to get ping request');

          })      
    }
  }
});