<template>
  <div
    id="app"
    class="min-h-screen w-screen bg-gray-200 flex items-center justify-center"
  >
    <draggable
      :list="elements"
      :animation="200"
      ghost-class="moving-card"
      group="steps"
      filter=".action-button"
      class="w-full max-w-md"
      tag="ul"
    >
      <container
        v-for="element in elements"
        :key="element.id"
        :element="element"
        :svg="svg"
        :input="input"
        :color="color()"
      />
    </draggable>
  </div>
</template>

<script>
import draggable from 'vuedraggable';

export default {
  props: {
    elements: { type: Array, required: true },
  },
  components: {
    draggable,
  },
  data() {
    return {
      enabled: true,
      dragging: false,
    };
  },
  methods: {
    onEdit(user) {
      console.log(`Editing ${user.name}`);
    },
    onDelete(user) {
      console.log(`Deleting ${user.name}`);
    },
  },
};
</script>
