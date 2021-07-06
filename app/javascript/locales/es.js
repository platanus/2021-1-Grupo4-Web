export default {
  msg: {
    welcomeTitle: '¡Bienvenido/a a KitchenGram!',
    welcomeSubtitle: 'La nueva forma de gestionar tu cocina y negocio',
    start: '¡Comienza ya!',
    add: 'Agregar',
    edit: 'Editar',
    delete: 'Eliminar',
    yesDelete: 'Sí, eliminar',
    save: 'Guardar',
    cancel: 'Cancelar',
    noElements: 'Aún no tienes',
    seeMore: 'Ver Más',
    filters: 'Filtros',
    apply: 'Aplicar',
    deleteFilters: 'Borrar filtros',
    min: 'Mínimo',
    max: 'Máximo',
    quantity: 'Cantidad',
    download: 'Descargar',
    saveChanges: 'Guardar cambios',
    close: 'Cerrar',
    current: 'Actual',
    unexpectedError: 'Ha ocurrido un error inesperado',
    requiredField: 'Campo Obligatorio',
    intNonZero: 'Debe ser un entero mayor a cero',
    floatNonZero: 'Debe ser mayor a cero',
    geqZero: 'Debe ser mayor o igual a cero',
    intGeqZero: 'Debe ser un entero mayor o igual a cero',

    users: {
      registerTitle: 'Crear Cuenta',
      loginTitle: 'Iniciar Sesión',
      labelEmail: 'Correo',
      labelPassword: 'Contraseña',
      labelPasswordConfirmation: 'Confirmar contraseña',
      placeholderEmail: 'Ingresa tu correo',
      register: 'Registrarse',
      login: 'Iniciar Sesión',
      logout: 'Cerrar Sesión',
      successRegister: 'Usuario creado exitosamente',
      alreadyHaveAccount: '¿Ya tienes cuenta? Inicia sesión',
      notHaveAccount: '¿No tienes cuenta? Registrate',
      requiredEmail: 'El correo es obligatorio',
      invalidEmail: 'El correo no es válido',
      requiredPassword: 'La contraseña es obligatoria',
      passwordTooShort: 'La contraseña debe tener al menos 6 caracteres',
      requiredPasswordConfirmation: 'Confirma tu contraseña',
      passwordConfirmationIncorrect: 'La contraseña no coincide',
      emailNotFound: 'Este correo no está registrado',
      incorrectPassword: 'La contraseña es incorrecta',
      enterEmail: 'Ingresa tu correo',
      enterPassword: 'Ingresa tu contraseña',
    },

    ingredients: {
      title: 'Ingredientes',
      search: 'Buscar ingrediente...',
      searchInMarket: 'Buscar en supermercados',
      selectMarket: 'Seleccionar supermercado',
      add: 'Agregar ingrediente',
      searchAdd: 'Agregar',
      edit: 'Editar ingrediente',
      delete: 'Eliminar ingrediente',
      alerts: 'Alertas',
      deleteMsg: '¿Estás seguro de que deseas eliminar este ingrediente?',
      name: 'Nombre',
      provider: 'Proveedor',
      price: 'Precio',
      unitPrice: 'Precio Unitario',
      quantity: 'Cantidad',
      measure: 'Unidad',
      selected: 'Ingredientes seleccionados',
      providerName: 'Nombre del proveedor',
      defaultUnit: 'Unidad por defecto',
      alternativeUnit: 'Unidades alternativas',
      addUnit: 'Agregar Unidad',
      associationWarning: 'Este ingrediente se encuentra en la(s) siguiente(s) receta(s):',
      newMeasure: 'Crear la medida',
      inventory: {
        title: 'Inventario',
        editingInventories: 'Editando varios inventarios',
        editInventories: 'Editar varios inventarios',
        actualQuantity: 'Inventario Actual',
        increaseIn: 'Aumentar en',
        decreaseIn: 'Disminuir en',
        resulting: 'Inventario Resultante',
      },
      noAlert: 'No tienes ingredientes bajo el límite de inventario',
      alertIngredients: 'Ingredientes acabándose',
      minimumQuantity: 'Regla mínimo en inventario',
      minimumQuantityShort: 'Mínimo',
    },

    recipes: {
      title: 'Recetas',
      search: 'Buscar receta...',
      searchIngredient: 'Buscar Ingrediente',
      add: 'Agregar nueva receta',
      edit: 'Editar',
      delete: 'Eliminar',
      deleteMsg: '¿Estás seguro de que deseas eliminar esta receta?',
      price: 'Precio',
      unitary: 'Unitario',
      minutes: 'Minuto(s)',
      portions: 'Porcion(es)',
      steps: 'Pasos',
      noIngredients: 'Esta receta aún no tiene ingredientes',
      noSteps: 'Esta receta aún no tiene pasos',
      create: 'Crear receta',
      basic: 'Datos básicos',
      name: 'Nombre',
      preparation: 'Tiempo de preparación (min.)',
      step: 'Paso de la receta...',
      ingredients: 'Ingredientes',
      cost: 'Costo total',
      more: 'Buscar más ingredientes',
      selectedIngredients: 'Ingredientes seleccionados',
      addstep: 'Agregar paso',
      cancel: 'Cancelar',
      accept: 'Aceptar',
      recipePrice: 'Total receta',
      saveChanges: 'Guardar cambios',
      filter: {
        price: 'Precio',
        portions: 'Nº de Porciones',
        minPortions: 'Mínimas',
        maxPortions: 'Máximas',
        minPrice: 'Mínimo',
        maxPrice: 'Máximo',
        aply: 'Aplicar',
        delete: 'Borrar filtro',
      },
      associationWarning: 'Esta receta se encuentra en el(los) siguiente(s) menú(s):',
    },

    menus: {
      title: 'Menús',
      search: 'Buscar menú...',
      add: 'Agregar menú',
      edit: 'Editar menú',
      delete: 'Eliminar menú',
      deleteMsg: '¿Estás seguro de que deseas eliminar este menú?',
      create: 'Crear menú',
      menuName: 'Nombre menú',
      portions: 'Porcion(es)',
      price: 'Precio',
      minutes: 'minuto(s)',
      addRecipes: 'Agregar recetas',
      selectedRecipes: 'Recetas seleccionadas',
      searchRecipes: 'Buscar recetas',
      menuPrice: 'Total del menú',
      name: 'Nombre',
      totalCost: 'Costo Total ($)',
      recipesQuantity: 'Cantidad de recetas',
      recipes: 'Recetas',
      noRecipes: 'Este menú aún no tiene recetas',
      saveChanges: 'Guardar cambios',
      shoppingList: 'Lista de compras',
      closeShoppingList: 'Cerrar',
      actions: 'Acciones',
      reduceInventory: 'Reducir Inventario',
      reduceMsg: '¿Estás seguro que quieres reducir el inventario?',
      yesReduce: 'Reducir',
      menuRecipes: 'Este menú tiene la(s) siguiente(s) receta(s):',
    },
    providers: {
      title: 'Proveedores',
      search: 'Buscar proveedores...',
      name: 'Nombre',
      rut: 'Rut',
      address: 'Dirección',
      country: 'Pais',
      days: 'días',
      email: 'Correo',
      webpageUrl: 'Página Web',
      minimumPurchase: 'Mínimo de Compra',
      deliveryDays: 'Tiempo de Entrega',
      phone: 'Teléfono',
      add: 'Agregar Proveedor',
      delete: 'Eliminar proveedor',
      edit: 'Editar Proveedor',
      deleteMsg: '¿Estás seguro de que deseas eliminar este proveedor?',
      see: 'Ver datos',
      copy: 'Copiar',
      bank: 'Cuenta Bancaria',
      bankAccount: {
        name: 'Nombre',
        rut: 'Rut',
        bank: 'Banco',
        type: 'Tipo de cuenta',
        number: 'Número de cuenta',
      },
      noTransferData: 'Aún no se tiene esta información',
    },
  },
};
