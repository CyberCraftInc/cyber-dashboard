<template>
  <div class='col-12 d-flex justify-content-end'>
    <button class='btn bg-dark text-white' v-bind:disabled="!canEditEvent" @click='onClickButton'>
      Create event
    </button>
  </div>
</template>

<script>
  export default {
    methods: {
      onClickButton() {
        this.$emit('show', true);
      }
    },
    props: ['canEditEvent']
  }
</script>
