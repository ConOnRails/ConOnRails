<template lang="pug">
  .event.form-group
    .col-md-12
      // EventMetadata(:event="this.event")
      // EventFlagHistory(:event="this.event")
      ul.entries
        Entry(v-for="entry in entries" :key="entry.id")
</template>

<script>
export default {
  props: ['entries']
}
</script>
