<template>
  <nav class="flex items-center justify-between bg-gray-800 p-6 h-16">
    <div class="flex items-center flex-shrink-0 text-white mr-6">
      <a
        href="/"
        class="font-semibold text-xl tracking-widest"
      >KitchenGram</a>
    </div>
    <div class="w-full flex-grow lg:flex lg:items-end lg:w-auto justify-end pr-5">
      <a
        href="/users/sign_in"
        class="text-lg px-4 py-2 text-white hover:bg-gray-900 mt-4 lg:mt-0"
      >{{ $t('msg.users.login') }}</a>
      <a
        href="/users/sign_up"
        class="text-lg px-4 py-2 text-white hover:bg-gray-900 mt-4 lg:mt-0"
      >{{ $t('msg.users.register') }}</a>
    </div>
  </nav>
</template>

<script>
export default {
};
</script>
