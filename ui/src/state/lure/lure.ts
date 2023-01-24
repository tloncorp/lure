import api from '@/api';
import { useState, useEffect } from 'react';

export function useLureBait() {
  const [lureBait, setLureBait] = useState('');
  useEffect(() => {
    api
      .scry<string>({
        app: 'lure',
        path: '/bait',
      })
      .then((result) => setLureBait(result));
  });

  return lureBait;
}

export async function lurePokeDescription(token: string, description: string) {
  await api.poke({
    app: 'lure',
    mark: 'lure-describe',
    json: {
      token,
      description,
    },
  });
}
