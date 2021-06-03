<template>
  <div>
    <div
      v-if="input"
      :class="color ? 'bg-white' : 'bg-gray-100'"
    >
      <div
        class="p-4 items-center justify-items-center grid grid-cols-3"
      >
        <div class="justify-self-start">
          <input
            v-model="ingredient.ingredientQuantity"
            class="w-16 h-12 self-center bg-white text-gray-700
            border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none"
            v-if="input"
            id="grams"
            type="text"
            placeholder="XXX"
            value=""
          >
          <span v-if="input">{{ element.measure }} </span>
        </div>
        <div :class="input ? '' : 'flex-auto m-1'">
          <span>{{ element.name }}</span>
        </div>
        <div class="text-right">
          <button>
            <img
              class="w-4 h-4"
              v-if="svg.cancel"
              src="../../../../assets/images/cancel-svg.svg"
            >
          </button>
        </div>
      </div>
    </div>

    <div
      v-else-if="!edit"
      :class="color ? 'bg-white' : 'bg-gray-100'"
    >
      <div class="p-4 flex items-center justify-items-center">
        <div class="justify-self-start flex-none m-2">
          <img
            v-if="svg.sixdots"
            svg-inline
            class="w-4 h-4 "
            src="../../../../assets/images/menu-recipe-svg.svg"
          >
        </div>
        <div class="flex-auto m-1">
          <span>{{ text }}</span>
        </div>
        <div class="flex-none text-right m-2 grid justify-item-end">
          <button>
            <img
              class="w-4 h-4"
              v-if="svg.cancel"
              src="../../../../assets/images/cancel-svg.svg"
            >
          </button>
          <dots-dropdown
            class="text-left"
            v-if="svg.dropdown"
            :elements="{
              edit:true,
              del:true
            }"
            @edit="editStep"
            @del="delStep"
          />
        </div>
      </div>
    </div>

    <div
      v-else
      :class="color ? 'bg-white' : 'bg-gray-100'"
    >
      <div class="p-4 flex items-center justify-items-center">
        <div class="justify-self-start flex-none m-2">
          <img
            v-if="svg.sixdots"
            svg-inline
            class="w-4 h-4 "
            src="../../../../assets/images/menu-recipe-svg.svg"
          >
        </div>
        <text-box
          tid="newTextBox"
          class="flex-1"
          :value="text"
        />
      </div>
      <div class="grid grid-cols-3 gap-4">
        <div />
        <base-button
          :elements="{
            placeholder: $t('msg.recipes.cancel'),
            color: 'text-black border-2 border-gray-300 align-center hover:bg-gray-300 h-8 text-base w-full -mx-4'
          }"
          @click="cancel"
        />
        <base-button
          :elements="{
            placeholder: $t('msg.recipes.accept'),
            color: 'text-black border-2 border-purple-400 align-center hover:bg-gray-300 h-8 text-base w-full -mx-4'
          }"
          @click="acceptEdit"
        />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    text: { type: String, default: () => ('') },
    element: { type: Object, default: () => ({}) },
    input: { type: Boolean, required: true },
    svg: { type: Object, required: true },
    color: { type: Boolean, required: true },
  },
  data() {
    return {
      edit: false,
      ingredient: this.element,
    };
  },
  methods: {
    editStep() {
      this.edit = !this.edit;
      this.$forceUpdate();
    },
    delStep() {
      this.$emit('del', this.text);
    },
    acceptEdit() {
      const text = document.getElementById('newTextBox').value;
      this.$emit('edit', this.text, text);
      this.edit = !this.edit;
    },
    cancel() {
      this.edit = !this.edit;
    },
  },
};
</script>
