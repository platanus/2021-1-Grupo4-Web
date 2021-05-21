<template>
  <table class="min-w-full divide-y divide-gray-200">
    <thead class="justify-between bg-gray-600 border-4 border-gray-600">
      <tr class="text-left">
        <th
          class="px-8 py-3"
          v-for="attribute in header"
          :key="attribute"
        >
          <span class="text-white font-bold">{{ $t(`msg.${modelType}.${attribute}`) }}</span>
        </th>
        <th v-if="dots" />
      </tr>
    </thead>
    <tbody class="bg-gray-200">
      <tr
        v-for="element in body"
        :key="element.id"
        class="bg-white border-4 border-gray-200 text-left"
      >
        <td
          v-for="property in header"
          :key="property"
          class="py-2 px-8"
        >
          <p class="ml-2 font-medium">
            {{ element[property] }}
          </p>
        </td>
        <td
          v-if="dots"
          class="content-center"
        >
          <dots-dropdown
            :elements="{
              edit:true,
              del:true
            }"
            @edit="editIngredient(element)"
            @del="deleteIngredient(element)"
          />
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script>

export default {
  props: {
    header: { type: Array, required: true },
    body: { type: Array, required: true },
    dots: { type: Boolean, required: true },
    modelType: { type: String, required: true },
  },
  methods: {
    editIngredient(element) {
      this.$emit('edit', element);
    },
    deleteIngredient(element) {
      this.$emit('del', element);
    },
  },

};

</script>
