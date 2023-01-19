import React, { forwardRef } from 'react';
import { Components as VirtuosoComponents, Virtuoso } from 'react-virtuoso';
import { useIsMobile } from '@/logic/useMedia';
import GroupMemberItem from './GroupMemberItem';

interface MemberScrollerProps {
  members: string[];
}

const Components: VirtuosoComponents = {
  List: forwardRef((props, listRef) => (
    <div className="h-full w-full space-y-6 py-2" {...props} ref={listRef}>
      {props.children}
    </div>
  )),
  Item: forwardRef((props, itemRef) => (
    // @ts-expect-error tsc complains about the ref prop, but it's fine
    <div className="flex items-center font-semibold" {...props} ref={itemRef}>
      {props.children}
    </div>
  )),
};

export default function MemberScroller({ members }: MemberScrollerProps) {
  const isMobile = useIsMobile();

  const thresholds = {
    atBottomThreshold: 125,
    atTopThreshold: 125,
    overscan: isMobile
      ? { main: 200, reverse: 200 }
      : { main: 400, reverse: 400 },
  };

  if (members.length === 0) {
    return <p>No members</p>;
  }

  return (
    <Virtuoso
      {...thresholds}
      data={members}
      computeItemKey={(i, member) => member}
      itemContent={(i, member) => <GroupMemberItem member={member} />}
      style={{
        minHeight: '100%',
      }}
      components={Components}
    />
  );
}
