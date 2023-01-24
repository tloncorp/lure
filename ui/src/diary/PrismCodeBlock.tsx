import React, { useState } from 'react';
import CodeBlock, { CodeBlockOptions } from '@tiptap/extension-code-block';
import { Plugin, PluginKey } from 'prosemirror-state';
import { findChildren, NodeViewProps } from '@tiptap/core';
import { Node as ProsemirrorNode } from 'prosemirror-model';
import { Decoration, DecorationSet } from 'prosemirror-view';
import { refractor } from 'refractor/lib/common.js';
import hoon from 'refractor/lang/hoon.js';

import {
  NodeViewContent,
  NodeViewWrapper,
  ReactNodeViewRenderer,
} from '@tiptap/react';
import './PrismCodeBlock.css';

export interface CodeBlockPrismOptions extends CodeBlockOptions {
  defaultLanguage: string | null | undefined;
}

function parseNodes(
  nodes: any[],
  className: string[] = []
): { text: string; classes: string[] }[] {
  return nodes
    .map((node) => {
      const classes = [
        ...className,
        ...(node.properties ? node.properties.className : []),
      ];

      if (node.children) {
        return parseNodes(node.children, classes);
      }

      return {
        text: node.value,
        classes,
      };
    })
    .flat();
}

function getHighlightNodes(result: any) {
  return result.children || [];
}

function getDecorations({
  doc,
  name,
  defaultLanguage,
}: {
  doc: ProsemirrorNode;
  name: string;
  defaultLanguage: string | null | undefined;
}) {
  const decorations: Decoration[] = [];
  const { highlight, listLanguages } = refractor;
  const allLanguages = listLanguages();

  findChildren(doc, (node) => node.type.name === name).forEach((block) => {
    let from = block.pos + 1;
    const language = block.node.attrs.language || defaultLanguage;
    if (!language || !allLanguages.includes(language)) {
      console.warn(
        'Unsupported language detected, this language has not been supported by prism: ',
        language
      );
      return;
    }
    const nodes = getHighlightNodes(
      highlight(block.node.textContent, language)
    );
    parseNodes(nodes).forEach((node) => {
      const to = from + node.text.length;

      if (node.classes.length) {
        const decoration = Decoration.inline(from, to, {
          class: node.classes.join(' '),
        });

        decorations.push(decoration);
      }

      from = to;
    });
  });
  return DecorationSet.create(doc, decorations);
}

function CodeBlockView(props: NodeViewProps) {
  const { node, updateAttributes } = props;
  const { listLanguages, register } = refractor;
  register(hoon);
  const allLanguages = listLanguages().sort();
  const providedLanguage: string | undefined = node.attrs?.language;
  const [selectedLanguage, setSelectedLanguage] = useState<string>(
    providedLanguage && allLanguages.includes(providedLanguage)
      ? providedLanguage
      : 'plaintext'
  );
  const options = allLanguages.map((l) => ({
    value: l,
    label: l.toUpperCase(),
  }));
  const onChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const newValue = e.target.value;
    if (newValue) {
      setSelectedLanguage(newValue);
      updateAttributes({ language: newValue });
    }
  };

  return (
    <NodeViewWrapper className={'relative'}>
      <select
        className="absolute top-1.5 right-1.5 w-[130px] rounded-md border border-solid border-gray-200 bg-gray-700 text-gray-50"
        onChange={onChange}
      >
        {options.map((o) => (
          <option value={o.value} selected={selectedLanguage === o.value}>
            {o.label}
          </option>
        ))}
      </select>
      <pre>
        <NodeViewContent as="code" />
      </pre>
    </NodeViewWrapper>
  );
}

const PrismCodeBlock = CodeBlock.extend<CodeBlockPrismOptions>({
  addOptions() {
    return {
      ...this.parent?.(),
      languageClassPrefix: 'language-',
      defaultLanguage: 'plaintext',
    };
  },
  addNodeView() {
    return ReactNodeViewRenderer(CodeBlockView);
  },
  addProseMirrorPlugins() {
    const { name, options } = this;
    return [
      ...(this.parent?.() || []),
      new Plugin({
        key: new PluginKey('prismPlugin'),

        state: {
          init: (_, { doc }) =>
            getDecorations({
              doc,
              name,
              defaultLanguage: options.defaultLanguage,
            }),
          apply(transaction, decorationSet, oldState, newState) {
            const oldNodeName = oldState.selection.$head.parent.type.name;
            const newNodeName = newState.selection.$head.parent.type.name;
            const oldNodes = findChildren(
              oldState.doc,
              (node) => node.type.name === name
            );
            const newNodes = findChildren(
              newState.doc,
              (node) => node.type.name === name
            );

            if (
              transaction.docChanged &&
              // Apply decorations if:
              // selection includes named node,
              ([oldNodeName, newNodeName].includes(name) ||
                // OR transaction adds/removes named node,
                newNodes.length !== oldNodes.length ||
                // OR transaction has changes that completely encapsulte a node
                // (for example, a transaction that affects the entire document).
                // Such transactions can happen during collab syncing via y-prosemirror, for example.
                transaction.steps.some(
                  (step) =>
                    // @ts-expect-error prosemirror#step
                    step.from !== undefined &&
                    // @ts-expect-error prosemirror#step
                    step.to !== undefined &&
                    oldNodes.some(
                      (node) =>
                        // @ts-expect-error prosemirror#step
                        node.pos >= step.from &&
                        // @ts-expect-error prosemirror#step
                        node.pos + node.node.nodeSize <= step.to
                    )
                ))
            ) {
              return getDecorations({
                doc: transaction.doc,
                name,
                defaultLanguage: options.defaultLanguage,
              });
            }

            return decorationSet.map(transaction.mapping, transaction.doc);
          },
        },

        props: {
          decorations(state) {
            return this.getState(state);
          },
        },
      }),
    ];
  },
});

export default PrismCodeBlock;
