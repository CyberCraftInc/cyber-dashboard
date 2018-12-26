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
          <th scope="row" v-for="title in theadTitles" >{{ title }}</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(user, index) in filteredList">
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
      theadTitles: ['#', 'First name', 'Last name', 'Email', 'Phone', 'Project' ],
      tableName: 'List of users',
      listOfProjects: JSON.parse(this.listProjectsAll),
      selected: '0',
      search: ''
    }
  },
  props: {
    listUsersAll: {
      type: String
    },
    listProjectsAll:{
      type: String
    },
    usersPath:{
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
    }
  },
  computed: {
    filteredList() {
      return this.listOfUsers.filter(listOfUsers => {
        return (listOfUsers.email + listOfUsers.phone + listOfUsers.first_name + listOfUsers.last_name).toLowerCase()
                .includes(this.search.toLowerCase())
      })
    }
  }
}
</script>
