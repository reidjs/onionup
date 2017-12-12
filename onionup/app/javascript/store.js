import Vuex from 'vuex';
import Vue from 'vue';
Vue.use(Vuex);

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
    ADD_CURRENT_USER: (state, payload) => {
      const currentUser = {
        id: payload.id,
        username: payload.username
      };
      state.session.currentUser = currentUser;
    },
    ADD_SITE: (state, payload) => {
      const site = {
        id: payload.id,
        url: payload.url
      };
      state.sites.unshift(site); 
    }
  },
  actions: {
    addSite (context) {
      context.commit('ADD_SITE');
    },
    addCurrentUser (context) {
      context.commit('ADD_CURRENT_USER');
    }
  }
});