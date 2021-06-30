<template>
  <div class="max-h-48 overflow-auto">
    <table class="mt-4 min-w-full">
      <thead>
        <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
          <th class="py-3 px-6 text-left">
            {{ header }}
          </th>
        </tr>
      </thead>
      <tbody class="text-black text-sm font-light">
        <tr
          v-for="row in rows"
          :key="row"
          class="border-b border-gray-200"
        >
          <td class="py-3 px-6 text-left">
            <p class="font-medium">
              {{ row }}
            </p>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  props: {
    header: { type: String, required: true },
    rows: { type: Array, required: true },
  },
};
</script>
