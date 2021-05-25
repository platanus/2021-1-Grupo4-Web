<template>
  <div class="w-96">
    <div class="flex space-x-4">
      <search
        placeholder="Ingrediente"
        :searchIcon="true"
        class="flex-2"
      />
    </div>
    <table class="min-w-full divide-y divide-gray-200 border-2">
      <thead class="justify-between">
        <tr class="bg-gray-100  py-1">
          <th 
            class="border-solid border-2 border-color-gray-300"
            v-for="attribute in header"
            :key="attribute"
          >
            <span class="text-black font-bold">{{ $t(`msg.ingredients.${attribute}`) }}</span>
          </th>
          <th/>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="parsedElement in parsedElements"
          :key="parsedElement.name"
          class="bg-white border-2"
        >
          <td
            v-for="property in header"
            :key="property"
            class="content-center py-2 border-solid border-2"
          >
            <p class="content-center text-center ml-2 font-semibold">
              {{ parsedElement[property] }}
            </p>
          </td>
          <td
          class="content-center py-2">
           <p class="content-center text-center ml-2 font-semibold">
             <add-button 
              :object=parsedElement
              @addIngredient="addIngredient"
             />
           </p>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import addButtonComponent from './add-button-component.vue';
export default {
  components: { addButtonComponent },
  props: {
    ingredients: { type: Array, required: true }
  },
  data() {
    return {
      current_page: 0,
      header: ['name', 'price', 'quantity']
    }
  },
  methods: {
    addIngredient(object) {
      this.$emit('addIngredient2', object);
    },
  },
  computed: {
    parsedElements() {
      const parsedElements = this.ingredients.map((element) => JSON.parse(element));
      return parsedElements;
    },

  },
}
</script>
