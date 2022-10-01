import { definitions } from "./types.ts";

export type SupportedLocales = "en" | "tr";
export type ValueOf<T> = T[keyof T];

export interface SupabaseRequest {
  table: keyof definitions;
  type: string;
  record: unknown;
  schema: string;
  old_record: boolean;
}

export interface IFirebaseNotification {
  title?: string;
  body?: string;
}
