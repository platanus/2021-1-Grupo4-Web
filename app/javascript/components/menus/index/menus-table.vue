<template>
  <table class="min-w-full divide-y divide-gray-200">
    <thead class="justify-between">
      <tr class="bg-yellow-500 border-4 border-yellow-500 py-1 text-left">
        <th
          v-for="attribute in header"
          :key="attribute"
          class="pl-2"
        >
          <span class="text-white font-bold">{{ $t(`msg.${modelType}.${attribute}`) }}</span>
        </th>
        <th v-if="dots" />
      </tr>
    </thead>
    <tbody class="bg-gray-200">
      <tr
        v-for="parsedElement in parsedElements"
        :key="parsedElement.name"
        class="bg-white border-4 border-gray-200"
      >
        <td
          v-for="property in header"
          :key="property"
          class="content-center py-2 pl-2"
        >
          <p
            v-if="property!='recipes'"
            class="content-center font-semibold text-left"
          >
            {{ parsedElement[property] }}
          </p>
          <div
            v-else
            class="flex flex-col"
          >
            <div
              v-for="element in parsedElement[property]"
              :key="element"
            >
              {{ element }}
            </div>
          </div>
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
            @edit="editIngredient(parsedElement)"
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
    header: { type: Array, required: true },
    body: { type: Array, required: true },
    dots: { type: Boolean, required: true },
    modelType: { type: String, required: true },
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
      const parsedElements = this.body.map((element) => JSON.parse(element));

      return parsedElements;
    },

  },
};

</script>
