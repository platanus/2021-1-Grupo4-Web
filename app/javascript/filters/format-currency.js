export default function formatCurrency(value) {
  if (value % 1) {
    return new Intl.NumberFormat('es-CL', { style: 'currency',
      currency: 'CLP',
      minimumFractionDigits: 2,
    }).format(value);
  }

  return new Intl.NumberFormat('es-CL', { style: 'currency',
    currency: 'CLP',
    maximumFractionDigits: 0,
  }).format(value);
}
