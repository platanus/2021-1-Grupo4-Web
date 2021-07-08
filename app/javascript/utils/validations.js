function geqZero(field, initialError) {
  let error = initialError;
  if (field && !(field >= 0)) error = 'geqZero';

  return error;
}
function intGeqZero(field, initialError) {
  let error = initialError;
  if (!(Number.isInteger(field - 0)) || !(field > 0)) error = 'intGeqZero';

  return error;
}
function requiredField(field, initialError) {
  let error = initialError;
  if (!field) error = 'requiredField';

  return error;
}

export { geqZero, intGeqZero, requiredField };
