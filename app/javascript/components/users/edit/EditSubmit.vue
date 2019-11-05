<template>
  <div>
    <button
      id="button-edit"
      @click="submitForm"
      class="btn btn-warning"
    >{{ buttonTitle }}</button>
  </div>
</template>

<script>
export default {
  name: "Submit",
  props: ["updatePath"],
  data () {
    return {
      buttonTitle: "Update",
      update: this.updatePath
    };
  },
  methods: {
    submitForm () {
      unmaskPhone();
      this.$axios
        .put(this.update, {
          user: {
            first_name: userFirstName.value,
            last_name: userLastName.value,
            phone: document.querySelector("input#userPhone").value,
            current_phone: userPhone.value,
            birthday: userBirthday.value,
            password: newPassword.value,
            password_confirmation: confirmNewPassword.value,
            current_password: currentPassword.value
          }
        })
        .then(response => this.showNotice(response.data))
        .catch(error => console.log(error.response));
    },
    showNotice (response) {
      let notice = document.getElementById("notice");

      const message = () => {
        if (response.success) {
          window.setTimeout(function () {
            location.href = "/";
          }, 3000);
          notice.style.color = "green";
          return "Profile updated. You will be redirected in 3 seconds";
        } else if (response.errors != 0) {
          notice.style.color = "red";
          return response.errors;
        }
      };
      notice.textContent = message();

      if (response) {
        document.querySelector(
          "div.dropdown__header > span:nth-child(1)"
        ).textContent = userFirstName.value;
      }
      setTimeout(() => {
        notice.textContent = "";
      }, 4000);
    }
  }
};
</script>
