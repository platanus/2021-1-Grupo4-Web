<template>
  <div
    id="app"
    class="w-full bg-gray-200 flex items-center justify-center"
  >
    {{ elements }}
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
        :text="element"
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
    svg: { type: Object, required: true },
    input: { type: Boolean, default: false },
    forceupdate: { type: Boolean, required: true },
  },
  components: {
    draggable,
  },
  mounted() {
    console.log('montado');
  },
  data() {
    return {
      enabled: true,
      dragging: false,
      par: false,
    };
  },
  methods: {
    onEdit(user) {
      console.log(`Editing ${user.name}`);
    },
    onDelete(user) {
      console.log(`Deleting ${user.name}`);
    },
    color() {
      this.par = !this.par;

      return this.par;
    },
  },
};
</script>
