<template lang="pug">
  .event.form-group
    .col-md-12
      // EventMetadata(:event="this.event")
      // EventFlagHistory(:event="this.event")
      ul.entries
        Entry(
          v-for="entry in entries" 
          :key="entry.id"
          :description="entry.description"
          :createdAt="entry.created_at"
          :user="entry.user"
          :rolename="entry.rolename"
        )
</template>

<script>
export default {
  props: ['createdAt', 'entries']
}
</script>
