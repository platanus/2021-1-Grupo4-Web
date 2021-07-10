<template>
  <div class="flex flex-col items-center bg-gray-200">
    <!-- Titulo -->
    <div class="flex flex-col items-center flex-none flex-grow-0 mb-4">
      <img
        class="h-16 w-16 pt-4 m-auto"
        svg-inline
        src="../../../assets/images/user-svg.svg"
      >
      <h1 class="font-bold text-3xl text-gray-700 flex-none flex-grow-0">
        {{ $t(`msg.users.profile`) }}
      </h1>
    </div>
    <!-- form -->
    <div class="flex flex-col justify-center items-center p-8 bg-white rounded flex-none flex-grow-0 w-4/5 lg:w-1/2">
      <form
        @submit.prevent="changePasword"
        method="post"
        class="w-full"
      >
        <h2 class="text-base text-black font-normal flex-none self-stretch flex-grow-0 mb-8">
          {{ $t('msg.users.modify') }}
        </h2>
        <!-- new password -->
        <div class="mb-6 w-full">
          <input
            v-model="form.userPassword"
            class="flex items-start w-full py-5 px-4 bg-white border border-solid border-gray-200 rounded-md flex-none flex-grow-0"
            id="password"
            type="password"
            :placeholder="$t('msg.users.labelPassword')"
          >
          <p
            v-if="errors.password"
            class="mt-2 ml-1 text-xs text-red-400"
          >
            {{ $t(`msg.users.${errors.password}`) }}
          </p>
        </div>
        <!-- Password Confirmation -->
        <div class="mb-6 w-full">
          <input
            v-model="form.passwordConfirmation"
            class="flex items-start w-full py-5 px-4 bg-white border border-solid border-gray-200 rounded-md flex-none flex-grow-0"
            id="password-confirmation"
            type="password"
            :placeholder="$t('msg.users.labelPasswordConfirmation')"
          >
          <p
            v-if="errors.passwordConfirmation"
            class="mt-2 ml-1 text-xs text-red-400"
          >
            {{ $t(`msg.users.${errors.passwordConfirmation}`) }}
          </p>
        </div>
        <div class="w-full flex flex-none self-stretch flex-grow-0">
          <div class="mx-auto lg:m-0">
            <base-button
              :elements="{ placeholder: $t('msg.save'),
                           color: 'bg-green-500 hover:bg-green-700 text-white' }"
            />
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>

import { changeUserPassword } from '../../api/users.js';

export default {
  data() {
    return {
      form: {
        userPassword: '',
        passwordConfirmation: '',
      },
      userEmail: '',
      errors: { password: '', passwordConfirmation: '' },
    };
  },

  methods: {

    async changePasword() {
      //   if (this.validations()) {
      //     try {
      //       await changeUserPassword(this.userEmail, this.form.userPassword, this.form.passwordConfirmation);
      //       window.location.href = '/';
      //     } catch (error) {
      //       console.log(error);
      //     }
      //   }
    },

    // eslint-disable-next-line max-statements
    validations() {
      this.errors = { password: '', passwordConfirmation: '' };
      let validForm = true;

      const minPasswordLen = 6;
      if (!(this.form.userPassword.length >= minPasswordLen)) {
        this.errors.password = 'passwordTooShort';
        validForm = false;
      }

      if (this.form.userPassword !== this.form.passwordConfirmation) {
        this.errors.passwordConfirmation = 'passwordConfirmationIncorrect';
        validForm = false;
      }

      if (!this.form.userPassword) {
        this.errors.password = 'requiredPassword';
        validForm = false;
      }
      if (!this.form.passwordConfirmation) {
        this.errors.passwordConfirmation = 'requiredPasswordConfirmation';
        validForm = false;
      }

      return validForm;
    },
  },
};

</script>
