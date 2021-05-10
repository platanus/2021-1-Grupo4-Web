<template>
    <div>
        <span>{{this.message}}</span>
    </div>
</template>
<script>
export default {
    props: {
    mail: { type: String, required: true },
    },
    data() {
    return {
      message: '',
    }
    },
    computed:{
        check(){
            if (this.mail.includes("@")){
                this.message = ""
            } else {
                this.message = "Mail invalido"
            }
            return this.message
        },
    },
}
</script>
    