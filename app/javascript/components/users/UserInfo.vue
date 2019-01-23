<template>
  <div class="row">
    <div class="col-6">
      <h3>{{ user.first_name + " " +user.last_name }}</h3>
      <p>{{ user.phone }}</p>
      <p>{{ user.email }}</p>
    </div>
    <div class="col-6">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title">{{ user.project.name }}</h5>
          <p class="card-text">{{ user.project.desc }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data: function () {
      return {
        user: JSON.parse(this.userForProps),
        titlesProjectInfo: {
          "Project name": "name",
          "Project description": "desc"
        }
      }
    },
    props: {
      userForProps: { type: String }
    }
  }
</script>
