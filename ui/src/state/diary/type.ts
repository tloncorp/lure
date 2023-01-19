import { Inline } from '@/types/content';
import {
  Diary,
  DiaryBriefs,
  DiaryCreate,
  DiaryDisplayMode,
  DiaryFlag,
  DiaryNoteMap,
  DiaryOutline,
  NoteEssay,
} from '@/types/diary';

export interface DiaryState {
  set: (fn: (sta: DiaryState) => void) => void;
  batchSet: (fn: (sta: DiaryState) => void) => void;
  shelf: {
    [flag: string]: Diary;
  };
  diarySubs: string[];
  loadedNotes: {
    [path: string]: DiaryOutline;
  };
  notes: {
    [flag: DiaryFlag]: DiaryNoteMap;
  };
  briefs: DiaryBriefs;
  pendingImports: Record<string, boolean>;
  create: (req: DiaryCreate) => Promise<void>;
  start: () => Promise<void>;
  fetchNote: (flag: DiaryFlag, noteId: string) => Promise<void>;
  initialize: (flag: DiaryFlag) => Promise<void>;
  joinDiary: (flag: DiaryFlag) => Promise<void>;
  leaveDiary: (flag: DiaryFlag) => Promise<void>;
  viewDiary: (flag: DiaryFlag, view: DiaryDisplayMode) => Promise<void>;
  markRead: (flag: DiaryFlag) => Promise<void>;
  addNote: (flag: DiaryFlag, essay: NoteEssay) => Promise<string>;
  editNote: (flag: DiaryFlag, time: string, essay: NoteEssay) => Promise<void>;
  delNote: (flag: DiaryFlag, time: string) => Promise<void>;
  getOlderNotes: (flag: string, count: number) => Promise<void>;
  getNewerNotes: (flag: string, count: number) => Promise<void>;
  addSects: (flag: DiaryFlag, writers: string[]) => Promise<void>;
  delSects: (flag: DiaryFlag, writers: string[]) => Promise<void>;
  addQuip: (
    flag: DiaryFlag,
    noteId: string,
    content: Inline[]
  ) => Promise<void>;
}
