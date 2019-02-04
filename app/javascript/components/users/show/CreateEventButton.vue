<template>
  <div class='col-12 d-flex justify-content-end'>
    <button id='create-event' class='btn bg-dark text-white' v-bind:class="showButtonForCanEditEvent()" @click='onClickButton'>
      Create event
    </button>
  </div>
</template>

<script>
  export default {
    methods: {
      onClickButton() {
        this.$emit('show', true);
      },
      showButtonForCanEditEvent(){
        return this.$parent.showButtonForCanEditEvent()
      }
    },
    props: ['canEditEvent']
  }
</script>
