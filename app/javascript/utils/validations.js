function geqZero(field, initialError) {
  let error = initialError;
  if (field && !(field >= 0)) error = 'geqZero';

  return error;
}
function intGeqZero(field, initialError) {
  let error = initialError;
  if (field && (!(Number.isInteger(field - 0)) || !(field >= 0))) error = 'intGeqZero';

  return error;
}
function requiredField(field, initialError) {
  let error = initialError;
  if (!field) error = 'requiredField';

  return error;
}

function validEmail(field, initialError) {
  const regexEmail = new RegExp(`${
    /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+/.source
  }${/(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@/.source
  }${/(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+/.source
  }${/[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/.source}`);
  let error = initialError;
  if (field && !regexEmail.test(field)) error = 'invalidEmail';

  return error;
}

export { geqZero, intGeqZero, requiredField, validEmail };
