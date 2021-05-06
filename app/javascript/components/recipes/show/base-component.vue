<template>
  <div>
    <!--Title-->
    <div class="flex justify-between items-center w-auto h-8 self-stretch flex-grow-0 my-1">
      <div class="flex items-center">
        <img
          class="h-6 w-6 text-white mx-2"
          svg-inline
          src="../../../../assets/images/arrow-left-svg.svg"
        >
        <div class="h-7 font-sans font-normal text-2xl text-black flex-grow mx-2">
          Lazaña Vegetariana
        </div>
      </div>
      <div class="flex items-center">
        <a
          class="flex justify-center items-center px-3 w-24 h-8 bg-white border-2 border-purple-600 rounded flex-grow-0 mx-2 text-purple-600"
          @click="toggleDelModal"
        >
          {{ $t('msg.recipes.delete') }}
        </a>
        <div class="flex justify-center items-center px-3 w-24 h-8 bg-white border-2 border-blue-700 rounded flex-grow-0 mx-2 text-blue-700">
          {{ $t('msg.recipes.edit') }}
        </div>
      </div>
    </div>
    <!--Info-->
    <recipe-info />
    <!--Body-->
    <div class="flex items-start w-auto h-auto self-stretch flex-grow-0 my-4">
      <recipe-ingredients />
      <recipe-instructions />
    </div>
    <!--DeleteModal-->
    <base-modal
      @ok="toggleDelModal"
      @cancel="toggleDelModal"
      v-if="showingDel"
      :title="$t('msg.recipes.delete')"
      :ok-button-label="$t('msg.yesDelete')"
      :cancel-button-label="$t('msg.cancel')"
    >
      <p>{{ $t('msg.recipes.deleteMsg') }}</p>
    </base-modal>
  </div>
</template>

<script>

export default {
  data() {
    return {
      showingDel: false,
    };
  },
  methods: {
    toggleDelModal() {
      this.showingDel = !this.showingDel;
    },
  },

};
</script>
