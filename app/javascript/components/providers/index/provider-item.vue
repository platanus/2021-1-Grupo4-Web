<template>
  <div class="flex flex-col items-start p-4 border-2 border-solid border-gray-400 box-border flex-none flex-grow-0">
    <div class="flex items-center w-80 h-auto flex-none self-stretch flex-grow-0 my-4">
      <!-- Imagen -->
      <div class="w-24 h-24 border-2 border-solid border-gray-400 box-border flex-none flex-grow-0 mr-2" />
      <!-- Info -->
      <div class="flex flex-col items-start w-auto h-auto flex-none self-stretch flex-grow mr-2">
        <!-- nombre Proveedor -->
        <div class="flex items-center w-auto h-5 flex-none flex-grow-0">
          Jumbo
        </div>
        <div class="flex flex-col items-start w-auto h-10 flex-none flex-grow-0 my-4">
          <!-- Mail -->
          <div class="flex items-center w-auto h-5 flex-none flex-grow-0 mb-4">
            <!-- Icono -->
            <div class="w-4 h-4 flex-none flex-grow-0 m-1.5">
              <img
                svg-inline
                src="../../../../assets/images/mail-svg.svg"
                class="w-4 h-4"
              >
            </div>
            <!-- Texto -->
            <div class="flex w-auto h-5 font-normal font-sans text-base items-center text-gray-400 flex-grow-0 flex-none">
              jumbo@jumbo.cl
            </div>
          </div>
          <!-- Telefono -->
          <div class="flex items-center w-auto h-5 flex-none flex-grow-0">
            <!-- Icono -->
            <div class="w-4 h-4 flex-none flex-grow-0 m-1.5">
              <img
                svg-inline
                src="../../../../assets/images/phone-svg.svg"
                class="w-4 h-4"
              >
            </div>
            <!-- Texto -->
            <div class="flex w-auto h-5 font-normal font-sans text-base items-center text-gray-400 flex-grow-0 flex-none">
              12345678
            </div>
          </div>
        </div>
      </div>
      <!-- flecha -->
      <div class="flex items-center w-6 h-6 flex-none self-stretch">
        <img
          svg-inline
          src="../../../../assets/images/chevron-down-svg.svg"
          class="w-6 h-6"
        >
      </div>
    </div>
  </div>
</template>

<script>

export default {
};

</script>
