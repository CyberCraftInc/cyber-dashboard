<template>
  <div id="edit-user">
    <h2>{{ title }}</h2>
    <edit-input
      input-class="form-control"
      label-for-and-input-id="userFirstName"
      label-name="First name"
      input-type="text"
      :input-value="user.first_name"
    ></edit-input>

    <edit-input
      input-class="form-control"
      label-for-and-input-id="userLastName"
      label-name="Last name"
      input-type="text"
      :input-value="user.last_name"
    ></edit-input>

    <edit-input
      input-class="form-control phone-input"
      label-for-and-input-id="userPhone"
      label-name="Phone"
      input-type="text"
      :input-value="user.phone"
    ></edit-input>

    <edit-input
      input-class="form-control"
      label-for-and-input-id="userBirthday"
      label-name="Birthday"
      input-type="date"
      :input-value="user.birthday"
    ></edit-input>

    <br>
    <form v-bind:action="editPasswordPath">
      <input type="submit" class="btn" value="Edit password" />
    </form>
    <edit-submit :update-path="updatePath"></edit-submit>
    <span id="notice"></span>
  </div>
</template>

<script>
import Input from "./EditInput";
import EditSubmit from "./EditSubmit";

export default {
  name: "Edit",
  components: {
    "edit-input": Input,
    "edit-submit": EditSubmit
  },
  data () {
    return {
      title: "Profile information",
      user: JSON.parse(this.userForEdit)
    };
  },
  props: {
    userForEdit: { type: String },
    updatePath: { type: String },
    editPasswordPath: {type: String},
  },
  mounted: function () {
    let firstName = document.querySelector("input#userFirstName");
    firstName.setAttribute("autofocus", "autofocus");
  }
};
</script>	
