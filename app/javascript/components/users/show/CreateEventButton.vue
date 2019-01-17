<template>
  <div class='create-event-button'>
    <button class='gray-button' v-on:click='onClickButton'>
      Create event
    </button>
  </div>
</template>

<script>
  export default {
    methods: {
      onClickButton() {
        this.$emit('show', true)
      }
    }
  }
</script>
