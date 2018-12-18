<template>
  <div>
    <h1>{{ tableName }}</h1>
    <table class="table">
      <thead class="thead-dark">
        <tr>
          <th scope="row" v-for="title in theadTitles" >{{ title }}</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(user, index) in listOfUsers">
          <th scope="row">{{ index + 1 }}</th>
          <td>{{ user.first_name }}</td>
          <td>{{ user.last_name }}</td>
          <td>{{ user.email }}</td>
          <td>{{ user.phone }}</td>
          <td>{{ user.name }}</td>
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
      tableName: 'List of users'
    }
  },
  props: {
    listUsersAll: {
      type: String
    }
  }
}
</script>
