<template>
  <div>
    <button @click="openDropdown">
      <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z" />
      </svg>
    </button>
    <div v-if="active">
      <div class="origin-top-right absolute right-0 mt-1 w-32 bg-white border overflow-hidden rounded-lg shadow-md cursor-pointer">
        <ul>
          <li class="hover:bg-gray-100">
            <a 
              class="font-semibold block px-4 py-3" 
              v-if="elements.edit" 
              @click="editIngredient"
            >Editar</a>
          </li>
          <li class="hover:bg-gray-100">
            <a 
              class="font-semibold block px-4 py-3" 
              v-if="elements.del" 
              @click="deleteIngredient"
            >Eliminar</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template> 


<script>
export default {
    props: {
        elements: {
            type: Object, 
            required: true
        },
    },
    data() {
        return {
            active: false
        }
    },
    methods: {
        openDropdown() {
            this.active = !this.active
        },
        editIngredient() {
            this.$emit('edit');
        },
        deleteIngredient() {
            this.$emit('del');
        },
    },
}
</script>