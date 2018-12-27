-<template>
  <div>
    <h1>{{ tableName }}</h1>
      <div class="form-group select-project">
        <select v-model="selected" @change='created' class="form-control select">
          <option value="0">All Projects</option>
          <option v-for="project in listOfProjects" v-bind:value="project.id" >{{ project.name }}</option>
        </select>
      <input type="text" v-model="search" placeholder="Search">
      </div>
    <table class="table">
      <thead class="thead-dark">
        <tr>
          <th scope="row" v-for="(title, index) in theadTitles" ><a @click="change_col(sortTitles[index])" >{{ title }}</a></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(user, index) in sortedUsers">
          <th scope="row">{{ index + 1 }}</th>
          <td>{{ user.first_name }}</td>
          <td>{{ user.last_name }}</td>
          <td>{{ user.email }}</td>
          <td>{{ user.phone }}</td>
          <td>{{ user.project.name }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>

export default {
  data: function () {
    return {
      listOfUsers: JSON.parse(this.listUsersAll),
      theadTitles: ['#', 'First name', 'Last name', 'Email', 'Phone', 'Project'],
      sortTitles: ['id', 'first_name', 'last_name', 'email', 'phone', 'project.name'],
      tableName: 'List of users',
      listOfProjects: JSON.parse(this.listProjectsAll),
      selected: '0',
      search: '',
      currentSort: 'email',
      currentSortDir: 'asc'
    }
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
    created() {
      axios.get(this.usersPath, {
        params: {
          id: this.selected
        }
      }).then((response) => this.listOfUsers = response.data)
              .catch((error) => console.log(error.response.data));
    },
    change_col(s) {
      //if s == current sort, reverse
      if (s === this.currentSort) {
        this.currentSortDir = this.currentSortDir === 'asc' ? 'desc' : 'asc';
      }
      else {
        this.currentSortDir = 'asc';
        this.currentSort = s;
      }

    }
  },
  computed: {
    filteredList() {
      return this.listOfUsers.filter(listOfUsers => {
        return (listOfUsers.email + listOfUsers.phone + listOfUsers.first_name + listOfUsers.last_name).toLowerCase()
                .includes(this.search.toLowerCase())
      })
    },
    sortedUsers() {
      return this.filteredList.sort((a, b) => {
        let modifier = 1;
        if (this.currentSortDir === 'desc') {modifier = -1;}
        if (a[this.currentSort] < b[this.currentSort]) return -1 * modifier;
        if (a[this.currentSort] > b[this.currentSort]) return modifier;
        return 0;
      });
    }
  },
}
</script>
