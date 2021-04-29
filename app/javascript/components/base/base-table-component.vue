<template>
  <table class="min-w-full divide-y divide-gray-200">
    <thead class="justify-between">
      <tr class="bg-yellow-500 border-4 border-yellow-500 py-1">
        <th
          v-for="attribute in table.header"
          :key="attribute"
        >
          <span class="text-white font-bold">{{ attribute }}</span>
        </th>
        <th v-if="dots" />
      </tr>
    </thead>
    <tbody class="bg-gray-200">
      <tr
        v-for="parsedElement in parsedElements"
        :key="parsedElement"
        class="bg-white border-4 border-gray-200"
      >
        <td
          v-for="property in table.header"
          :key="property"
          class="content-center py-2"
        >
          <p class="content-center text-center ml-2 font-semibold">
            {{ parsedElement[property] }}
          </p>
        </td>
        <td
          v-if="dots"
          class="content-center"
        >
          <dropdown
            :elements="{
              edit:true,
              del:true
            }"
            @edit="editIngredient(element)"
            @del="deleteIngredient"
          />
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script>

export default {
  props: {
    table: { type: Object, required: true },
    dots: { type: Boolean, required: true },
  },
  methods: {
    editIngredient(element) {
      this.$emit('edit', element);
    },
    deleteIngredient() {
      this.$emit('del');
    },
  },

  computed: {
    parsedElements() {
      const parsedElements = this.table.body.map((element) => JSON.parse(element));

      return parsedElements;
    },

  },
};

</script>
