import React, { Ref } from 'react';
import cn from 'classnames';
import { makePrettyDay, pluralize } from '@/logic/utils';

interface DateDividerProps {
  date: Date;
  unreadCount?: number;
}

function DateDividerComponent(
  { date, unreadCount }: DateDividerProps,
  ref: Ref<HTMLDivElement>
) {
  const prettyDay = makePrettyDay(date);

  return (
    <div ref={ref} className="flex w-full items-center py-4">
      <div
        className={cn(
          'h-[2px] w-8 rounded-sm',
          unreadCount ? 'bg-blue' : 'bg-gray-200'
        )}
      >
        &nbsp;
      </div>
      <span
        className={cn(
          'whitespace-nowrap px-3 font-semibold',
          unreadCount ? 'text-blue' : 'text-gray-400'
        )}
      >
        {prettyDay}
        {unreadCount ? (
          <>
            &nbsp;&bull;&nbsp;
            {unreadCount} new {pluralize('messsage', unreadCount)} below
          </>
        ) : null}
      </span>
      <div
        className={cn(
          'h-[2px] w-full rounded-sm',
          unreadCount ? 'bg-blue' : 'bg-gray-200'
        )}
      >
        &nbsp;
      </div>
    </div>
  );
}

const DateDivider = React.forwardRef(DateDividerComponent);

export default DateDivider;
