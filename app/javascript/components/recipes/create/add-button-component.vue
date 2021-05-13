 <template> 
  <base-button
      :elements="{
        placeholder: '+',
        color: 'hover:bg-gray text-black'
      }"
      @click="clickButton"
    />
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
      this.$emit('click');
      alert("aaaaaaaaaaaaa");
    },
  },
}
</script>
