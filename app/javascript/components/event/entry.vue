<template lang="pug">
  li.entry 
    .entry_metadata
      .date {{ createdAt }}
      .volunteer 
        | Created by 
        a(:href="this.userLink") {{ user.realname }} 
        | as {{ rolename }}
    .description(v-html="this.markedDescription")
      
</template>

<script>
import { marked } from 'marked';
export default {
  props: ['createdAt', 'description', 'rolename', 'user'],
  computed: {
    markedDescription() {
      return marked(this.description);
    },
    userLink() {
      return `/users/${this.user.id}`;
    }
  }
}
</script>
