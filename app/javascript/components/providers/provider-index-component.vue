<template>
  <div>
  <p>{{this.providers}}</p>
  <table>
    <tr 
      v-for="element in this.providers"
      :key="element.name"
      >
      </tr>
  </table>
  </div>
  
</template>

<script>
import { getProviders, postProvider } from './../../api/providers.js';
export default {
  data() {
    return {
      providers: [],
    }
  },

  async created() {
    try {
      const response = await getProviders();
      this.providers = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
      this.successResponse(response);
    } catch (error) {
      this.errorResponse(error);
    }
  },
  methods: {
    // async addProvider() {
    //   try {
    //     const {
    //       status,
    //       data:
    //         { data: { id, attributes },
    //         },
    //     } = await postProvider();
    //     const providerToAdd = { id, ...attributes };
    //     this.providers.push(providerToAdd);
    //     this.successResponse(status);
    //   } catch (error) {
    //     this.errorResponse(error);
    //   }
    // },
    async successResponse(status) {
      this.status = status;
      this.error = '';
    },
    async errorResponse(error) {
      this.status = error.response.status;
      this.error = error;
    },
  }
};

</script>
