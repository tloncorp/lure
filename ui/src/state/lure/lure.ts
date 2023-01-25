import api from '@/api';
import { useState } from 'react';
import { useEffectOnce } from 'usehooks-ts';

export function useLureBait() {
  const [lureBait, setLureBait] = useState('');
  useEffectOnce(() => {
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

  useEffectOnce(() => {
    api
      .scry<boolean>({
        app: 'grouper',
        path: `/enabled/${name}`,
      })
      .then((result) => setLureEnabled(result));
  });

  return [lureEnabled, setLureEnabled];
}

export function useLureDescription(
  name: string
): [string, (s: string) => void] {
  const [lureDescription, setLureDescription] = useState<string>(
    'Write a welcome message for your group'
  );

  useEffectOnce(() => {
    api
      .scry<string>({
        app: 'reel',
        path: `/description/${name}`,
      })
      .then((result) => setLureDescription(result));
  });

  return [lureDescription, setLureDescription];
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
