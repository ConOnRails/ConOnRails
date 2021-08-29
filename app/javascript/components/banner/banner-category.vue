<template lang="pug">
  div.col-md6.col-sm-6
    div(:class="this.icon")
    span {{this.text}}
</template>

<script>
export default {
  props: {
    conditional: String,
    icon: String,
    text: String
  }
}
</script>
