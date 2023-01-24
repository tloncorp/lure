import api from '@/api';
import { useState, useEffect } from 'react';

export default function useLureBait() {
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
