<template>
  <div class="dropdown">
    <div
      class="dropdown__header"
      @click="toggleDropdown($event)"
    >
      <span>{{ user }}</span>
      <span
        class="dropdown-toggle"
        data-toggle
        href
      ></span>
    </div>

    <div
      class="dropdown__content"
      @mouseleave="mouseLeave"
    >
      <ul class="nav navbar-nav">
        <li>
          <a :href="profileLink">{{ profile }}</a>
        </li>
        <li>
          <a :href="editUserLink">{{ editUser }}</a>
        </li>
        <li>
          <a
            rel="nofollow"
            :data-method="methodLogOut"
            :href="logOutLink"
          >{{ logOut }}</a>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    toggleDropdown (event) {
      event.currentTarget.classList.toggle("is-active");
    },
    mouseLeave: function () {
      document
        .querySelector("div.dropdown__header")
        .classList.remove("is-active");
    }
  },
  data () {
    return {
      editUser: "Edit profile",
      logOut: "Logout",
      methodLogOut: "delete",
      profile: "Profile",
      user: this.userName
    };
  },
  props: {
    editUserLink: { type: String },
    logOutLink: { type: String },
    userName: { type: String },
    profileLink: { type: String }
  }
};
</script>
