<template>
  <div>
    <label :for="labelForAndInputId">{{ labelName }}</label>
    <input
      :class="inputClass"
      :type="inputType"
      :value="inputValue"
      :name="inputName"
      :id="labelForAndInputId"
    >
  </div>
</template>

<script>
export default {
  props: {
    labelName: { type: String },
    labelForAndInputId: { type: String },
    inputType: { type: String },
    inputValue: { type: String },
    inputName: { type: String },
    inputClass: { type: String }
  }
};
</script>
