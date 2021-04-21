<template>
    <table class="min-w-full divide-y divide-gray-200">
        <thead class="justify-between">
            <tr class="bg-yellow-500 border-4 border-yellow-500 py-1">
                <th v-for="h in table.header">
                    <span class="text-white font-bold">{{ h }}</span>
                </th>
                <th v-if="dots">
                </th> 
            </tr>
        </thead>
        <tbody class="bg-gray-200"> 
            <tr v-for="element in table.body" class="bg-white border-4 border-gray-200">
                <td v-for="property in table.header" class="content-center py-2">
                    <p class="content-center text-center ml-2 font-semibold">{{ JSON.parse(element)[property] }}</p>
                </td>
                <td v-if="dots" class="content-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z" />
                    </svg>
                </td> 
            </tr>            
        </tbody>
    </table>
</template>

<script>
export default {
  props: {
    table: { type: Object, required: true },
    dots: {type: Boolean, required: true },
  },
};
</script>
