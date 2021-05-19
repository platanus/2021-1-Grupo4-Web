 <template> 
  <button
      @click="clickButton"
  > + </button>
</template>

<script>
import baseButtonComponent from '../../base/base-button-component.vue'
export default {
  components: { baseButtonComponent },
  props: {
    object: {type: Object, required:true}
  },
  data() {
    return {
    }
  },
  methods: {
    clickButton() {
      this.$emit('addIngredient', this.object);
    },
  },
}
</script>
