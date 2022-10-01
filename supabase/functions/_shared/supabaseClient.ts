import { createClient } from "https://esm.sh/@supabase/supabase-js@1.35.6";

export const supabaseClient = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);
