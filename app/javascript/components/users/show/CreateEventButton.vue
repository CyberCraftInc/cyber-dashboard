<template>
  <div class="row">
    <div class='col-2 offset-10 p-0 d-flex justify-content-end'>
      <button id='create-event' class='btn bg-dark text-white mr-5' v-bind:class="showButtonForCanEditEvent()" @click='onClickButton'>
        Create event
      </button>
    </div>
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
