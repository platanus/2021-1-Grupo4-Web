<template>
  <div>
    <base-modal
      @ok="toggleAddIngredientModal"
      @cancel="toggleAddIngredientModal"
      v-if="showingAddIngredientModal"
      :title="$t('msg.ingredients.add')"
      :ok-button-label="$t('msg.add')"
      :cancel-button-label="$t('msg.cancel')"
    >
      <div class="flex f-row w-full">
        <div class="mr-10">
          <search-ingredient-list 
            :ingredients="objects"
            @addIngredient2="addIngredient"
          />
        </div>
        <selected-ingredients 
          :elements="selectedIngredients"
          :svg="{sixdots: true, cancel: false, menu_recipe: true}"
          :input="false"
          :placeholder="'------'"
          :addIngredientKey="addIngredientKey['lol']"
        /> 
      </div>
    </base-modal>
  </div>
</template>

<script>
import BaseModalComponent from '../../base/base-modal-component.vue';
import searchIngredientListComponent from './search-ingredient-list-component.vue';
import Vue from 'vue';
export default {
  components: { searchIngredientListComponent, BaseModalComponent },
  props: {
    objects: { type: Array, required: true },
  },
  data() {
    return {
      steps: this.objects,
      showingAddIngredientModal: true,
      addIngredientKey: {lol: 0},
      selectedIngredients: [],
    }
  },
  methods: {
    create() {
      return null
    },
    toggleAddIngredientModal(){
      this.showingAddIngredientModal = !this.showingAddIngredientModal;
    },
    addIngredient(object){
      this.selectedIngredients.push(object);
      Vue.set(this.addIngredientKey, 'lol', 2);
    }
  },
};
</script>
