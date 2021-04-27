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
        v-for="element in table.body"
        :key="element"
        class="bg-white border-4 border-gray-200"
      >
        <td
          v-for="property in table.header"
          :key="property"
          class="content-center py-2"
        >
          <p class="content-center text-center ml-2 font-semibold">
            {{ table_body[property] }}
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
            @edit="editIngredient"
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

  computed: {
    table_body: () => {
      let return_thing;
      for (let element in this.table.body) {
        for (let property in this.table.header) {
          return_thing[property] = JSON.parse(element)[property];
        };
      };
      return return_thing;
    },
  },
  
  methods: {
    editIngredient() {
      this.$emit('edit');
    },
    deleteIngredient() {
      this.$emit('del');
    },
  },
};
</script>
