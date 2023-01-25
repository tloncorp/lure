import api from '@/api';
import { useState, useEffect } from 'react';

export function useLureBait() {
  const [lureBait, setLureBait] = useState('');
  useEffect(() => {
    api
      .scry<string>({
        app: 'reel',
        path: '/bait',
      })
      .then((result) => setLureBait(result));
  });

  return lureBait;
}

export function useLureEnabled(name: string): [boolean, (b: boolean) => void] {
  const [lureEnabled, setLureEnabled] = useState<boolean>(false);

  useEffect(() => {
    api
      .scry<boolean>({
        app: 'grouper',
        path: `/enabled/${name}`,
      })
      .then((result) => setLureEnabled(result));
  });

  return [lureEnabled, setLureEnabled];
}

export async function lurePokeDescription(token: string, description: string) {
  await api.poke({
    app: 'reel',
    mark: 'reel-describe',
    json: {
      token,
      description,
    },
  });
}

export async function lureEnableGroup(name: string) {
  await api.poke({
    app: 'grouper',
    mark: 'grouper-enable',
    json: name,
  });
}

export async function lureDisableGroup(name: string) {
  await api.poke({
    app: 'grouper',
    mark: 'grouper-disable',
    json: name,
  });
}
