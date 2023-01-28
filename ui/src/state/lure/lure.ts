import api from '@/api';
import { useState } from 'react';
import { useEffectOnce } from 'usehooks-ts';

export function useLureBait() {
  const [lureBait, setLureBait] = useState('');
  useEffectOnce(() => {
    api
      .scry<{ url: string; ship: string }>({
        app: 'reel',
        path: '/bait',
      })
      .then((result) => setLureBait(result.url));
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

export function useLureWelcome(name: string): [string, (s: string) => void] {
  const [lureWelcome, setLureWelcome] = useState<string>(
    'Write a welcome message for your group'
  );

  useEffectOnce(() => {
    api
      .scry<{ tag: string; fields: any }>({
        app: 'reel',
        path: `/metadata/${name}`,
      })
      .then((result) => setLureWelcome(result.fields.welcome));
  });

  return [lureWelcome, setLureWelcome];
}

export async function lurePokeDescribe(token: string, metadata: any) {
  await api.poke({
    app: 'reel',
    mark: 'reel-describe',
    json: {
      token,
      metadata,
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
