import Vuex from 'vuex';
import Vue from 'vue';
Vue.use(Vuex);

export const store = new Vuex.Store({
  state: {
    sites: {},
    session: {}
  },
  getters: {
    sites: state => state.sites,
    session: state => state.session
  },
  mutations: {
    addCurrentUser: (state, payload) => {
      const currentUser = {
        id: payload.id,
        username: payload.username
      };
      state.session = currentUser;
    },
    addSite: (state, payload) => {
      const site = {
        id: payload.id,
        url: payload.url
      };
      state.sites.unshift(site); 
    }
  }
});