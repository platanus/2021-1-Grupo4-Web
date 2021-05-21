<template>
  <table class="divide-y divide-gray-200">
    <thead class="justify-between bg-gray-600 border-4 border-gray-600">
      <tr class="text-left">
        <th
          class="px-8 py-3"
        >
          <span class="text-white font-bold">{{ $t('msg.results') }}</span>
        </th>
      </tr>
    </thead>
    <tbody class="bg-gray-200">
      <tr
        v-for="recipe in recipesResult"
        :key="recipe"
        class="bg-white border-2 border-gray-200 text-left"
      >
        <td key="recipe">
          <search-results-item
            :recipe="recipe"
          />
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script>
import SearchResultsItem from './search-results-item';

export default {
  components: {
    SearchResultsItem,
  },

  props: {
    recipesResult: { type: Array, required: true },
  },
};

</script>
