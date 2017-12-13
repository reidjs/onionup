import Vuex from 'vuex';
import Vue from 'vue';
Vue.use(Vuex);
import axios from 'axios';
// let getUser = undefined;

// if (window.currentUser) {
//   getUser = window.currentUser;
// }

// console.log("STORE",window.currentUser);

export const store = new Vuex.Store({
  state: {
    sites: {},
    session: {currentUser: window.currentUser},
    errors: {}
  },
  getters: {
    sites: state => state.sites,
    session: state => state.session
  },
  mutations: {
    ADD_CURRENT_USER (state, payload) {
      const currentUser = {
        id: payload.id,
        username: payload.username
      };
      console.log("payload",payload)
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
    }
  },
  actions: {
    addSite (context) {
      context.commit('ADD_SITE');
    },
    addCurrentUser (context, user) {
      console.log('addcurrentuser action',user);

        axios.post(`/api/session`,
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
            this.errors.push(e.response.data[0]);
          });
      
    },
    logout (context) {
      context.commit('LOGOUT');
    }
  }
});