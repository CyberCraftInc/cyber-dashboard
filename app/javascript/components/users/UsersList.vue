<template>
  <div>
    <h1>{{ tableName }}</h1>
    <div class="form-group select-project">
      <select
        v-model="selected"
        @change="created"
        class="form-control select"
      >
        <option value="0">All Projects</option>
        <option
          v-for="project in listOfProjects"
          v-bind:value="project.id"
          :key="project.id"
        >{{ project.name }}</option>
      </select>
      <input
        type="text"
        v-model="search"
        placeholder="Search"
        id="search"
      >
    </div>
    <div class="table-responsive">
      <table class="table">
        <thead class="thead-dark">
          <tr>
            <th
              scope="row"
              v-for="(title) in Object.keys(theadSortTitles)"
              :key="title.id"
            >
              <span @click="change_col(theadSortTitles[title])">{{ title }}</span>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(user, index) in sortedUsers"
            :key="user.id"
          >
            <th scope="row">{{ index + 1 }}</th>
            <td class="first-name-column">{{ user.first_name }}</td>
            <td class="last-name-column">{{ user.last_name }}</td>
            <td class="email-column">{{ user.email }}</td>
            <td class="phone-column">{{ user.phone }}</td>
            <td class="project-name-column">{{ user.project.name }}</td>
            <td>
              <a
                class="btn-show"
                :href="userPath + user.id"
              >show</a>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      listOfUsers: JSON.parse(this.listUsersAll),
      theadSortTitles: {
        "#": "id",
        "First name": "first_name",
        "Last name": "last_name",
        Email: "email",
        Phone: "phone",
        "Project name": "project.name",
        "": ""
      },
      blackListSort: ["id", "project.name"],
      tableName: "List of users",
      listOfProjects: JSON.parse(this.listProjectsAll),
      selected: "0",
      search: "",
      currentSort: "last_name",
      currentSortDir: "asc",
      userPath: this.usersPath + "/"
    };
  },
  props: {
    listUsersAll: {
      type: String
    },
    listProjectsAll: {
      type: String
    },
    usersPath: {
      type: String
    }
  },
  methods: {
    created () {
      this.$axios
        .get(this.usersPath, {
          params: {
            id: this.selected
          }
        })
        .then(response => (this.listOfUsers = response.data))
        .catch(error => console.log(error.response.data));
    },
    change_col (s) {
      // if not sorting title
      if (this.blackListSort.includes(s)) {
        return;
      }
      //if s == current sort, reverse
      if (s === this.currentSort) {
        this.currentSortDir = this.currentSortDir === "asc" ? "desc" : "asc";
      } else {
        this.currentSortDir = "asc";
        this.currentSort = s;
      }
    }
  },
  computed: {
    filteredList () {
      return this.listOfUsers.filter(listOfUsers => {
        return (
          listOfUsers.email +
          listOfUsers.phone +
          listOfUsers.first_name +
          listOfUsers.last_name
        )
          .toLowerCase()
          .includes(this.search.toLowerCase());
      });
    },
    sortedUsers () {
      return this.filteredList.sort((a, b) => {
        let modifier = 1;
        if (this.currentSortDir === 'desc') {
          modifier = -1;
        }
        if (a[this.currentSort].toLowerCase() < b[this.currentSort].toLowerCase()) {
          return -1 * modifier;
        }
        if (a[this.currentSort].toLowerCase() > b[this.currentSort].toLowerCase()) {
          return modifier;
        }
        return 0;
      });
    }
  }
};
</script>
