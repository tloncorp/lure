import {
  Editor,
  isNodeSelection,
  isTextSelection,
  posToDOMRect,
} from '@tiptap/react';
import { Editor as CoreEditor } from '@tiptap/core';
import * as Popover from '@radix-ui/react-popover';
import React, {
  KeyboardEvent,
  useCallback,
  useEffect,
  useRef,
  useState,
} from 'react';
import ChatInputMenuToolbar, {
  MenuState,
  LinkEditorForm,
} from './ChatInputMenuToolbar';
import { useIsMobile } from '../../logic/useMedia';

interface ChatInputMenuProps {
  editor: Editor;
}

const options = ['bold', 'italic', 'strike', 'link', 'blockquote', 'code'];

export default function ChatInputMenu({ editor }: ChatInputMenuProps) {
  const toolbarRef = useRef<HTMLDivElement>(null);
  const [selected, setSelected] = useState(-1);
  const [selectionPos, setSelectionPos] = useState<DOMRect>();
  const [status, setStatus] = useState<MenuState>('closed');
  const isMobile = useIsMobile();

  const onSelection = useCallback(
    ({ editor: currentEditor }: { editor: CoreEditor }) => {
      setSelected(-1);
      const { view } = currentEditor;
      const { doc, selection } = currentEditor.state;
      const { empty, ranges } = selection;

      // Sometime check for `empty` is not enough.
      // Doubleclick an empty paragraph returns a node size of 2.
      // So we check also for an empty text size.
      const from = Math.min(...ranges.map((range) => range.$from.pos));
      const to = Math.max(...ranges.map((range) => range.$to.pos));
      const isEmptyTextBlock =
        !doc.textBetween(from, to).length && isTextSelection(selection);

      if (!view.hasFocus() || empty || isEmptyTextBlock) {
        setStatus('closed');
        return;
      }

      if (isNodeSelection(selection)) {
        const node = view.nodeDOM(from) as HTMLElement;

        if (node) {
          setSelectionPos(node.getBoundingClientRect());
        }
      } else {
        setSelectionPos(posToDOMRect(view, from, to));
      }

      setStatus('open');
    },
    []
  );

  useEffect(() => {
    editor.on('selectionUpdate', onSelection);

    return () => {
      editor.off('selectionUpdate', onSelection);
    };
  }, [editor, onSelection]);

  const isSelected = useCallback(
    (key: string) => {
      if (selected === -1) {
        return false;
      }

      return options[selected] === key;
    },
    [selected]
  );

  const openLinkEditor = useCallback(() => {
    setStatus('editing-link');
  }, []);

  const setLink = useCallback(
    ({ url }: LinkEditorForm) => {
      if (url === '') {
        editor.chain().extendMarkRange('link').unsetLink().run();
      } else {
        editor.chain().extendMarkRange('link').setLink({ href: url }).run();
      }

      editor.chain().focus();
      setStatus('open');
    },
    [editor]
  );

  const onNavigation = useCallback(
    (event: KeyboardEvent<HTMLDivElement>) => {
      event.stopPropagation();
      if (event.key === 'Escape') {
        if (status === 'open') {
          setStatus('closed');
          setSelected(-1);
          editor
            .chain()
            .setTextSelection(editor.state.selection.from)
            .focus()
            .run();
        } else {
          setStatus('open');
          toolbarRef.current?.focus();
        }
      }

      const total = options.length;
      if (event.key === 'ArrowRight' || event.key === 'ArrowDown') {
        setSelected((total + selected + 1) % total);
      }

      if (event.key === 'ArrowLeft' || event.key === 'ArrowUp') {
        setSelected((total + selected - 1) % total);
      }
    },
    [selected, status, editor]
  );
  if (isMobile) {
    return editor.view.hasFocus() || status === 'editing-link' ? (
      <ChatInputMenuToolbar
        editor={editor}
        toolbarRef={toolbarRef}
        status={status}
        setStatus={setStatus}
        setLink={setLink}
        onNavigation={onNavigation}
        isSelected={isSelected}
        openLinkEditor={openLinkEditor}
      />
    ) : null;
  }
  return (
    <Popover.Root open={status !== 'closed'}>
      <Popover.Anchor
        className="pointer-events-none fixed"
        style={{
          width: selectionPos?.width,
          height: selectionPos?.height,
          top: selectionPos?.top,
          left: selectionPos?.left,
        }}
      />
      <Popover.Content
        side="top"
        sideOffset={8}
        onOpenAutoFocus={(event) => event.preventDefault()}
        onPointerDownOutside={() => setStatus('closed')}
      >
        <ChatInputMenuToolbar
          editor={editor}
          toolbarRef={toolbarRef}
          status={status}
          setStatus={setStatus}
          setLink={setLink}
          onNavigation={onNavigation}
          isSelected={isSelected}
          openLinkEditor={openLinkEditor}
        />
      </Popover.Content>
    </Popover.Root>
  );
}
